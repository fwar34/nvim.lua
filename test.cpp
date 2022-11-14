#include <iostream>
#include <string>
#include <vector>
#include <hiredis.h>
#include <strings.h>
#include <json/json.h>

using namespace std;

static redisContext* g_ctx = nullptr;

struct MeetingRoom {
    string name;
    string id;
    uint32_t capacity;
};

struct customercode_info {
    string customer_code;
    vector<MeetingRoom> meeting_rooms;
};

redisContext* GetConnection(std::string ip, uint32_t port)
{
    redisContext* ctx = redisConnect(ip.c_str(), port); 
    if (!ctx || ctx->err) {
        std::cout << "GetConnection err:" << ctx->err << endl;
        return nullptr;
    } 
    return ctx;
}

/*
#define REDIS_REPLY_STRING 1  
#define REDIS_REPLY_ARRAY 2  
#define REDIS_REPLY_INTEGER 3  
#define REDIS_REPLY_NIL 4  
#define REDIS_REPLY_STATUS 5  
#define REDIS_REPLY_ERROR 6  
*/
bool CheckRedisReply(const redisReply* reply, bool bExcludeNil = true)
{
    switch (reply->type)
    {
        case REDIS_REPLY_STRING:
        case REDIS_REPLY_ARRAY:
        case REDIS_REPLY_INTEGER:
            return true;
        case REDIS_REPLY_NIL:
            if (bExcludeNil)
            {
                return true;
            }
            return false;
        case REDIS_REPLY_STATUS:
            return (strcasecmp(reply->str, "OK") == 0) ? true : false;
        case REDIS_REPLY_ERROR:
            std::cout << reply->str;
            return false;
        default:
            return false;
    }
    return false;
}

redisReply* executeCommandArgv(const std::string& key, int argc, const char **argv, const size_t *argvlen)
{
    redisReply* reply = (redisReply*)redisCommandArgv(g_ctx, argc, argv, argvlen);
    if (!reply) {
        std::cout << "execute command failed!" << endl;
    }

    if (reply && !CheckRedisReply(reply))
    {
        freeReplyObject((void*)reply);
        return nullptr;
    }

    return reply;
}

redisReply* ExecuteRedisCmd(const std::string &key, const std::vector<std::string> &cmd_array)
{
	int k = 0;
	std::vector<const char *> argv(cmd_array.size());
	std::vector<size_t> argvlen(cmd_array.size());
	for (auto it = cmd_array.begin(); it != cmd_array.end(); it++, k++) {
		argv[k] = it->c_str();
		argvlen[k] = it->length();
	}
	return executeCommandArgv(key, (int)argv.size(), &(argv[0]), &(argvlen[0]));
}

std::string SerializeToJson(MeetingRoom& room)
{
    Json::Value value;
    Json::FastWriter writer;
    value['id'] = room.id;
    value['name'] = room.name;
    value['capacity'] = room.capacity;
    value['conference'] = 0;
    return writer.write(value);
}

bool test_script()
{
    // 构造数据
    string access_rooms = ",1,2,3,4,"; // 被分配的会议室列表
    vector<MeetingRoom> new_rooms; // 添加的会议室列表
    MeetingRoom room1;
    room1.name = "room1_name";
    room1.id = "1111";
    room1.capacity = 50;
    new_rooms.push_back(room1);
    MeetingRoom room2;
    room2.name = "room2_name";
    room2.id = "2222";
    room2.capacity = 100;
    new_rooms.push_back(room2);
    // map_name new_room_id1 new_room1_json new_room_id2 new_room2_json ",access_room1_id,access_room2_id,access_room3_id," conf_id
    // KEYS1    KEYS2        KEYS3          KEYS4        KEYS5          ARGV1                                               ARGV2
	std::string scrpit = "for i = 2, #KEYS, 1 do\
                              if not redis.call('HGET', KEYS[1], KEYS[i + 1]) == 1 then\
                                  redis.call('HSET', KEYS[1], KEYS[i], KEYS[i + 1])\
                              end\
                          end\
                          -- 根据传递的会议室列表来判断应该分配哪个会议室\
                          local all_rooms = redis.call('HGETALL', KEYS[1])\
                          local roomid_ret = '0'\
                          local min_capacity = '99999999'\
                          local min_room_json = ''\
                          -- i 下标为奇数，j 是会议室 id，i 为偶数的 j 为会议室 json 串\
                          for i, j in ipairs(all_rooms) do\
                              if i % 2 == 1 and string.match(ARGV[1], ',' .. j .. ',') then\
                                  local room_json = cjson.decode(all_rooms[i + 1])\
                                  if room_json['conference'] ~= '0' and room_json['capacity'] < min_capacity then\
                                      min_capacity = room_json['capacity']\
                                      roomid_ret = j\
                                      min_room_json = room_json\
                                  end\
                              end\
                          end\
                          -- 分配到会议室，则更新会议室所对应的会议id\
                          if roomid_ret ~= '0' then\
                              local new_room = {\
                                  id = min_room_json['id'],\
                                  name = min_room_json['name'],\
                                  capacity = min_room_json['capacity'],\
                                  conference = ARGV[2]\
                              }\
                              if redis.call('HSET', KEYS[1], cjson.encode(new_room)) == 1 then\
                                  return roomid_ret\
                              else\
                                  return '0'\
                              end\
                          end\
                          return '0'\
                          ";

	char key[128] = {0};
	std::vector<std::string> cmds;
	cmds.push_back("EVAL");
	cmds.push_back(scrpit);
	cmds.push_back(std::to_string(new_rooms.size() * 2 + 1));
	cmds.push_back("custom_map");
    for (auto& room : new_rooms) {
        cmds.push_back(std::to_string(room.id));
        cmds.push_back(SerializeToJson(room));
    }
    cmds.push_back(access_rooms);
    cmds.push_back(std::to_string(conf_id));

	redisReply* reply = ExecuteRedisCmd(key, cmds);
    if (reply && !CheckRedisReply(reply)) {
        std::cout << "error";
        return false;
    }

    if (reply->type == REDIS_REPLY_ARRAY) {
        std::cout << "omk" << endl;
        return true;
    } else {
        return false;
    }
}

int main()
{
    g_ctx = GetConnection("127.0.0.1", 6379);
    if (!g_ctx) {
        return 1;
    }

    test_script();

    return 0;
}
