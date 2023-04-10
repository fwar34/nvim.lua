#include <iostream>
#include <string>
#include <vector>
#include <hiredis.h>
#include <strings.h>
#include <sstream>
#include "json/json.h"

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

redisReply* executeCommandArgv(int argc, const char **argv, const size_t *argvlen)
{
    redisReply* reply = (redisReply*)redisCommandArgv(g_ctx, argc, argv, argvlen);
    if (!reply) {
        std::cout << "execute command failed!" << endl;
    }

    return reply;
}

redisReply* ExecuteRedisCmd(const std::vector<std::string> &cmd_array)
{
	int k = 0;
	std::vector<const char *> argv(cmd_array.size());
	std::vector<size_t> argvlen(cmd_array.size());
	for (auto it = cmd_array.begin(); it != cmd_array.end(); it++, k++) {
		argv[k] = it->c_str();
		argvlen[k] = it->length();
	}
	return executeCommandArgv((int)argv.size(), &(argv[0]), &(argvlen[0]));
}

std::string SerializeToJson(MeetingRoom& room)
{
    Json::FastWriter writer;
    Json::Value value;
    value["id"] = room.id;
    value["name"] = room.name;
    value["capacity"] = room.capacity;
    value["conference"] = 0;
    return writer.write(value);
}

string FindValue(const string &key_value, const char *key)
{
	string null;
	if (key_value.empty()) {
		return null;
	}

	string kv_string = key_value;
	Json::Reader reader;
	Json::Value root;
	if (!reader.parse(kv_string, root)) {
		// sprintf("conf(%d) parse json string(%s) failed!", 999, kv_string.c_str());
		return null;
	}
	if (root.empty() || root.type() != Json::objectValue) {
		// sprintf("conf(%d) root is not object, or root is null. key:%s, key_value:%s", 999, key, kv_string.c_str());
		return null;
	}

	if (!root[key].isNull() && root[key].type() == Json::stringValue) {
		return root[key].asString();
	}

	return null;
}

// "meetingrooms":"{\"customercode\":\"154430\",\"access_rooms\":[{\"id\":12455,\"capacity\":2000}]}"
void test_json()
{
    string custmor_json = R"(
    {
        "meetingrooms": {
	        "customercode": "111",
	        "access_rooms": [{
	        		"id": "1111",
	        		"name": "room1",
	        		"capacity": 150
	        	},
	        	{
	        		"id": "5555",
	        		"name": "room5",
	        		"capacity": 80
	        	},
	        	{
	        		"id": "6666",
	        		"name": "room6",
	        		"capacity": 160
	        	}
	        ]
       }
    })";
    Json::Reader reader;
    Json::Value root;
    reader.parse(custmor_json, root);
    cout << "type:->" << root["meetingrooms"].type() << endl;
    cout << root["meetingrooms"].empty() << endl;
    cout << root["meetingrooms"]["access_rooms"].size() << endl;
    cout << root["meetingrooms"]["access_rooms"].empty() << endl;
    cout << root["meetingrooms"] << endl;
    cout << root["meetingrooms"]["customercode"] << endl;
    cout << root["meetingrooms"]["access_rooms"][0]["name"] << endl;
    // cout << root.type() << endl;
    // cout << root["access_rooms"].type() << endl;
    // cout << root["access_rooms"][0].type() << endl;
    // cout << root["access_rooms"][0]["name"].type() << endl;
    // string customercode = root["customercode"].asString();
    // cout << customercode << endl;
    ostringstream oss;
    oss << root["meetingrooms"];
    cout << oss.str() << endl;

    // for (auto& item : root["meetingrooms"]["access_rooms"]) {
    //     if (item["id"].find("5555")) {
    //         cout << "find 5555" << endl;
    //     }
    // }
    cout << root["meetingrooms"]["customercode"].asString() << endl;

    cout << "------------------" << endl;
    string ret = FindValue(custmor_json, "encryptionType");
    cout << ret.empty() << endl;
}

string replace_all(string& str, const string& old_value, const string& new_value)
{
    while (true) {
        std::size_t pos = str.find(old_value);
        if (pos != string::npos) {
            str.replace(pos, old_value.length(), new_value);
        } else {
            break;
        }
    }
    return str;
}

void test_json2()
{
    string custmor_json = R"({
        "meetingrooms":"{\"customercode\":\"154430\",\"access_rooms\":[{\"id\":\"12455\",\"capacity\":2000}]}"
    })";

    Json::Reader reader;
    Json::Value root;
    string test;
    if (!reader.parse(custmor_json, root)) {
        cout << "xxxxxxxxxx error" << endl;
        return;
    }
    
    cout << "type:->" << root["meetingrooms"].type() << endl;
    cout << root["meetingrooms"] << endl;

    Json::Value rooms;
    reader.parse(root["meetingrooms"].asString(), rooms);
    cout << rooms.type() << endl;
    cout << rooms["customercode"] << endl;
    cout << rooms["access_rooms"].type() << endl;
    cout << rooms["access_rooms"][0]["id"] << endl;
    for (auto& item : rooms["access_rooms"]) {
        cout << item << endl;
        if (item["id"] == "12455") {
            cout << "xxxx" << endl;
        } else {
            cout << "yyyy" << endl;
        }
    }

    cout << "----------------------" << endl;
    string ret = root["meetingrooms"].asString();
    cout << replace_all(ret, "\\", "") << endl;
    cout << ret << endl;
    // cout << root["meetingrooms"]["access_rooms"].size() << endl;
    // cout << root["meetingrooms"]["access_rooms"].empty() << endl;
    // cout << root["meetingrooms"] << endl;
    // cout << root["meetingrooms"]["customercode"] << endl;
    // cout << root["meetingrooms"]["access_rooms"][0]["name"] << endl;
    // // cout << root.type() << endl;
    // // cout << root["access_rooms"].type() << endl;
    // // cout << root["access_rooms"][0].type() << endl;
    // // cout << root["access_rooms"][0]["name"].type() << endl;
    // // string customercode = root["customercode"].asString();
    // // cout << customercode << endl;
    // ostringstream oss;
    // oss << root["meetingrooms"];
    // cout << oss.str() << endl;

    // // for (auto& item : root["meetingrooms"]["access_rooms"]) {
    // //     if (item["id"].find("5555")) {
    // //         cout << "find 5555" << endl;
    // //     }
    // // }
    // cout << root["meetingrooms"]["customercode"].asString() << endl;

    // cout << "------------------" << endl;
    // string ret = FindValue(custmor_json, "encryptionType");
    // cout << ret.empty() << endl;
}

void gen_data()
{
    MeetingRoom room1;
    room1.id = "1111";
    room1.name = "room1";
    room1.capacity = 50;
    string room1_json = SerializeToJson(room1);
    // cout << "room1_json:" << room1_json << endl;

    MeetingRoom room2;
    room2.id = "2222";
    room2.name = "room2";
    room2.capacity = 150;
    string room2_json = SerializeToJson(room2);
    // cout << "room2_json:" << room2_json << endl;

    string script = "if not redis.call('HGET', KEYS[1], KEYS[2]) then\
                         redis.log(redis.LOG_NOTICE, 'add gen_data')\
                         redis.call('HSET', KEYS[1], KEYS[2], KEYS[3], KEYS[4], KEYS[5])\
                     end";

	std::vector<std::string> cmds;
	cmds.push_back("EVAL");
	cmds.push_back(script);
	cmds.push_back("5");
	cmds.push_back("111_meeting_rooms");
    cmds.push_back("1111");
    cmds.push_back(room1_json);
    cmds.push_back("2222");
    cmds.push_back(room2_json);

	redisReply* reply = ExecuteRedisCmd(cmds);
    if (reply && !CheckRedisReply(reply)) {
        std::cout << "error";
    }
}

void test_json3()
{
    uint32_t conf_id = 12456;
    string custmor_json2 = R"({"roomsinfo": {
	"customercode": "111",
	"rooms": [{
			"id": "1111",
			"name": "room1",
			"capacity": 150
		},
		{
			"id": "5555",
			"name": "room5",
			"capacity": 80
		},
		{
			"id": "6666",
			"name": "room6",
			"capacity": 160
		}
	]
    }})";

    Json::Reader reader;
    Json::Value root;
    reader.parse(custmor_json2, root);
    cout << root.type() << endl;
    cout << root["roomsinfo"].type() << endl;
    cout << root["roomsinfo"].empty() << endl;
    cout << root["roomsinfo"]["rooms"].size() << endl;
    cout << root["roomsinfo"]["customercode"] << endl;
    cout << root["roomsinfo"] << endl;
    ostringstream oss;
    oss << root["roomsinfo"];
    string str = oss.str();
    cout << str << endl;
}

void test_create_json()
{
    uint32_t conf_id = 12456;
    string custmor_json2 = R"({
	"customercode": "111",
	"access_rooms": [{
			"id": "1111",
			"name": "room1",
			"capacity": 150
		},
		{
			"id": "5555",
			"name": "room5",
			"capacity": 80
		},
		{
			"id": "6666",
			"name": "room6",
			"capacity": 160
		}
	]
    })";

    string custmor_json = R"(
        {"customercode":"154430","access_rooms":[{"id":"12455","capacity":2000}]}
    )";
    // string custmor_json = R"(
    //     {"customercode":"154430","access_rooms":[{"id":"12455","capacity":2000}]}
    // )";
    string script = R"(local customer_info = cjson.decode(KEYS[1])
                       local customer_code = customer_info.customercode
                       local access_rooms = customer_info.access_rooms
                       if not access_rooms then
                           return cjson.encode({error = string.format('access_rooms is empty', customer_code)})
                       end
                       redis.log(redis.LOG_NOTICE, 'customercode', customer_code)
                       for _, room in pairs(access_rooms) do
                           redis.log(redis.LOG_NOTICE, 'id:', room.id, ' capacity:', room.capacity)
                       end
                       local all_rooms = redis.call('HKEYS', customer_code .. '_meeting_rooms')
                       all_rooms = all_rooms or {}
                       local min_capacity = 99999999
                       local room_ret
                       for _, room in pairs(access_rooms) do
                           local found = false
                           for _, j in pairs(all_rooms) do
                               if j == room.id then
                                   found = true
                                   break
                               end
                           end
                           if not found and room.capacity < min_capacity then
                               min_capacity = room.capacity
                               room_ret = room
                           end
                       end
                       if room_ret then
                           room_ret.conference = KEYS[2]
                           if redis.call('HSET', customer_code .. '_meeting_rooms', room_ret.id, cjson.encode(room_ret)) then
                               redis.log(redis.LOG_NOTICE, 'roomid_ret', room_ret.id)
                               return cjson.encode({room = room_ret.id})
                           end
                       end
                       return cjson.encode({error = 'alloc room failed'})
                       )";

    std::vector<std::string> cmds;
    cmds.push_back("EVAL");
    cmds.push_back(script);
    cmds.push_back("2");
    cmds.push_back(custmor_json);
    cmds.push_back(std::to_string(conf_id));

    redisReply* reply = ExecuteRedisCmd(cmds);
    if (reply && !CheckRedisReply(reply)) {
        std::cout << "error";
    }

    cout << "create: " << reply->str << endl;
}

void test_join_json()
{
    uint32_t conf_id = 12456;
    string custmor_json = R"({
	"customercode": "111",
	"access_rooms": [{
			"id": "1111",
			"name": "room1",
			"capacity": 550
		},
		{
			"id": "5555",
			"name": "room5",
			"capacity": 580
		},
		{
			"id": "6666",
			"name": "room6",
			"capacity": 160
		}
	]
    })";
    string script = R"(local customer_info = cjson.decode(KEYS[1])
                       local customer_code = customer_info.customercode
                       local access_rooms = customer_info.access_rooms
                       if not access_rooms then
                           return cjson.encode({error = string.format('access_rooms is empty', customer_code)})
                       end
                       redis.log(redis.LOG_WARNING, 'conference:', '12345', 'begin----------------------------------------------')
                       local all_rooms = redis.call('HGETALL', customer_code .. '_meeting_rooms')
                       all_rooms = all_rooms or {}
                       local min_capacity = 99999999
                       local room_ret
                       local check_conference = false
                       local current_capacity = tonumber(KEYS[4])
                       for i, j in pairs(all_rooms) do
                           if i % 2 == 1 then
                               redis.log(redis.LOG_WARNING, 'cache room i:', i, 'j:', j, 'all_rooms[i + 1]:', all_rooms[i + 1])
                           end
                       end

                       for i, j in pairs(access_rooms) do
                           redis.log(redis.LOG_WARNING, 'input room i:', i, 'j.id:', j.id)
                       end

                       for _, room in pairs(access_rooms) do
                           local found = false
                           for i, j in pairs(all_rooms) do
                               redis.log(redis.LOG_WARNING, 'cache room i:', i, 'j:', j)
                               if i % 2 == 1 and room.id == j then
                                   redis.log(redis.LOG_WARNING, 'i:', i, 'all_rooms[i + 1]:', all_rooms[i + 1])
                                   local value = cjson.decode(all_rooms[i + 1])
                                   redis.log(redis.LOG_WARNING, 'i:', i, 'value.id', value.id)
                                   if not check_conference and value.conference ~= KEYS[2] then
                                       check_conference = true
                                       redis.log(redis.LOG_WARNING, 'redis conference:', value.conference, ' not equal conference:', KEYS[2])
                                   end
                                   found = true
                                   break
                               end
                           end
                           redis.log(redis.LOG_WARNING, 'min_capacity:', min_capacity, 'found:', found and 1 or 0, 'room.id:', room.id)
                           if not found and room.capacity < min_capacity and room.capacity > current_capacity then
                               min_capacity = room.capacity
                               room_ret = room
                           end
                           redis.log(redis.LOG_WARNING, 'min_capacity:', min_capacity, 'found:', found and 1 or 0)
                       end
                       redis.log(redis.LOG_WARNING, 'conference:', '12345', 'end----------------------------------------------')
                       if room_ret then
                           room_ret.conference = KEYS[2]
                           if redis.call('HSET', customer_code .. '_meeting_rooms', room_ret.id, cjson.encode(room_ret)) and redis.call('DEL', KEYS[3]) then
                               return cjson.encode({room = room_ret.id})
                           end
                       end
                       return cjson.encode({error = 'relloc room failed'})
                       )";

    std::vector<std::string> cmds;
    cmds.push_back("EVAL");
    cmds.push_back(script);
    cmds.push_back("4");
    cmds.push_back(custmor_json);
    cmds.push_back(std::to_string(conf_id));
    cmds.push_back("1111"); //current room id
    cmds.push_back("150");  //current room capacity

    redisReply* reply = ExecuteRedisCmd(cmds);
    if (reply && !CheckRedisReply(reply)) {
        std::cout << "error";
    }

    cout << "join: " << reply->str << endl;
}

void test_create()
{
    // 构造数据
    uint32_t conf_id = 12456;
    string access_rooms = ",1111,2222,3333,"; // 被分配的会议室列表
    vector<MeetingRoom> new_rooms; // 添加的会议室列表
    MeetingRoom room1;
    room1.name = "room1";
    room1.id = "1111";
    room1.capacity = 50;
    new_rooms.push_back(room1);
    MeetingRoom room3;
    room3.name = "room3";
    room3.id = "3333";
    room3.capacity = 250;
    new_rooms.push_back(room3);
    // map_name new_room_id1 new_room1_json new_room_id2 new_room2_json ",access_room1_id,access_room2_id,access_room3_id," conf_id
    // KEYS1    KEYS2        KEYS3          KEYS4        KEYS5          ARGV1                                               ARGV2
    std::string script = "if #KEYS > 1 then\
                             for i = 2, #KEYS - 1, 2 do\
                                 if not redis.call('HGET', KEYS[1], KEYS[i]) then\
                                     redis.call('HSET', KEYS[1], KEYS[i], KEYS[i + 1])\
                                 end\
                             end\
                         end\
                         local all_rooms = redis.call('HGETALL', KEYS[1])\
                         for a, b in pairs(all_rooms) do\
                             redis.log(redis.LOG_NOTICE, 'all_rooms index:', a, 'value:', b)\
                         end\
                         local roomid_ret = '0'\
                         local min_capacity = 99999999\
                         local min_room_json\
                         for i, j in ipairs(all_rooms) do\
                             if i % 2 == 1 and string.match(ARGV[1], ',' .. j .. ',') then\
                                 local room_json = cjson.decode(all_rooms[i + 1])\
                                 if room_json['conference'] == 0 and room_json['capacity'] < min_capacity then\
                                     min_capacity = room_json['capacity']\
                                     roomid_ret = j\
                                     min_room_json = room_json\
                                 end\
                             end\
                         end\
                         if roomid_ret ~= '0' then\
                             local new_room = {\
                                 id = min_room_json['id'],\
                                 name = min_room_json['name'],\
                                 capacity = min_room_json['capacity'],\
                                 conference = tonumber(ARGV[2])\
                             }\
                             if redis.call('HSET', KEYS[1], roomid_ret, cjson.encode(new_room)) then\
                                 return cjson.encode({room_id = roomid_ret})\
                             elseif not redis.call('HSET', KEYS[1], roomid_ret, min_room_json) then\
                                 return cjson.encode({error = string.format('rollback failed for room:%s conference:%s', roomid_ret, ARGV[2])})\
                             end\
                         end\
                         return cjson.encode({error = string.format('failed alloc meeting room for conference:%s', ARGV[2])})\
                         ";

	std::vector<std::string> cmds;
	cmds.push_back("EVAL");
	cmds.push_back(script);
	cmds.push_back(std::to_string(new_rooms.empty() ? 1 : (new_rooms.size() * 2 + 1)));
	cmds.push_back("111_meeting_rooms");
    for (auto& room : new_rooms) {
        cmds.push_back(room.id);
        cmds.push_back(SerializeToJson(room));
    }
    cmds.push_back(access_rooms);
    cmds.push_back(std::to_string(conf_id));

	redisReply* reply = ExecuteRedisCmd(cmds);
    if (reply && !CheckRedisReply(reply)) {
        std::cout << "error";
    }

    cout << "create: " << reply->str << endl;
}

void test_join()
{
    // 构造数据
    uint32_t conf_id = 12456;
    string access_rooms = ",1111,2222,4444,"; // 被分配的会议室列表
    vector<MeetingRoom> new_rooms; // 添加的会议室列表
    MeetingRoom room4;
    room4.name = "room4";
    room4.id = "4444";
    room4.capacity = 100;
    new_rooms.push_back(room4);
    // map_name new_room_id1 new_room1_json new_room_id2 new_room2_json ",access_room1_id,access_room2_id,access_room3_id," current_meeting_room current_capacity conf_id
    // KEYS1    KEYS2        KEYS3          KEYS4        KEYS5          ARGV1                                               ARGV2                ARGV3            ARGV4
    string script = "redis.log(redis.LOG_NOTICE, 'process join start ---------------------')\
                     if #KEYS > 1 then\
                         for i = 2, #KEYS - 1, 2 do\
                             if not redis.call('HGET', KEYS[1], KEYS[i]) then\
                                 redis.call('HSET', KEYS[1], KEYS[i], KEYS[i + 1])\
                             end\
                         end\
                     end\
                     local all_rooms = redis.call('HGETALL', KEYS[1])\
                     local min_capacity = 99999999\
                     local roomid_ret = '0'\
                     local old_room_json, min_room_json\
                     for i, j in ipairs(all_rooms) do\
                         if j == ARGV[2] then\
                             old_room_json = cjson.decode(all_rooms[i + 1])\
                         elseif i % 2 == 1 and string.match(ARGV[1], ',' .. j .. ',') then\
                             local room_json = cjson.decode(all_rooms[i + 1])\
                             if room_json['conference'] == 0 and room_json['capacity'] < min_capacity and room_json['capacity'] > tonumber(ARGV[3]) then\
                                 min_capacity = room_json['capacity']\
                                 min_room_json = room_json\
                                 roomid_ret = all_rooms[i]\
                             end\
                         end\
                     end\
                     if tostring(old_room_json['conference']) ~= ARGV[4] then\
                         return cjson.encode({error = string.format('meeting conference:%u not equal arg conference:%s', old_room_json['conference'], ARGV[4])})\
                     end\
                     if roomid_ret ~= '0' then\
                         local new_room = {\
                             id = min_room_json['id'],\
                             name = min_room_json['name'],\
                             capacity = min_room_json['capacity'],\
                             conference = tonumber(ARGV[4])\
                         }\
                         local old_room = {\
                             id = old_room_json['id'],\
                             name = old_room_json['name'],\
                             capacity = old_room_json['capacity'],\
                             conference = 0\
                         }\
                         if redis.call('HSET', KEYS[1], roomid_ret, cjson.encode(new_room), ARGV[2], cjson.encode(old_room)) then\
                             return cjson.encode({room_id = roomid_ret})\
                         elseif not redis.call('HSET', KEYS[1], roomid_ret, min_room_json, ARGV[2], old_room_json) then\
                             return cjson.encode({error = string.format('rollback failed for room:%s conference:%s', roomid_ret, ARGV[4])})\
                         end\
                     end\
                     return cjson.encode({error = 'failed relloc meeting room'})\
                     ";

	std::vector<std::string> cmds;
	cmds.push_back("EVAL");
	cmds.push_back(script);
	cmds.push_back(std::to_string(new_rooms.empty() ? 1 : (new_rooms.size() * 2 + 1)));
	cmds.push_back("111_meeting_rooms");
    for (auto& room : new_rooms) {
        cmds.push_back(room.id);
        cmds.push_back(SerializeToJson(room));
    }
    cmds.push_back(access_rooms);
    cmds.push_back("1111"); // current_meeting_room
    cmds.push_back("50"); // current_capacity
    cmds.push_back(std::to_string(conf_id));

	redisReply* reply = ExecuteRedisCmd(cmds);
    if (reply && !CheckRedisReply(reply)) {
        std::cout << "error";
    }

    cout << "join: " << reply->str << endl;
}

void test_json_cpp()
{
    string json = "{\
        \"name\": \"Xiaoming\",\
        \"age\": 20,\
        \"extend\" : {\
            \"members\": [{\"type\": 3}, {\"type\": 4}],\
            \"date\": \"2023\",\
        },\
    }";

    Json::Reader reader;
    Json::Value root;
    reader.parse(json, root);
    cout << root.type() << endl;
    cout << root["extend"].type() << endl;
    cout << root["extend"].empty() << endl;
    cout << root["extend"]["members"].size() << endl;
    cout << root["extend"]["members"][0] << endl;
    cout << root["extend"] << endl;
    ostringstream oss;
    oss << root["extend"];
    string str = oss.str();
    cout << str << endl;
    for (auto& e : root.getMemberNames()) {
        cout << e << endl;
    }
}

int main()
{
    g_ctx = GetConnection("127.0.0.1", 6379);
    if (!g_ctx) {
        return 1;
    }

    // test_json2();
    // test_json3();
    // return 0;

    // gen_data();
    // test_create();
    // getchar();
    // test_join();
    test_create_json();
    // return 0;

    getchar();
    test_join_json();

    std::cout << "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n";
    test_json_cpp();

    return 0;
}

// string replace_all(string& str, const string& old_value, const string& new_value)
// {
//     while (true) {
//         std::size_t pos = str.find(old_value);
//         if (pos != string::npos) {
//             str.replace(pos, old_value.length(), new_value);
//         } else {
//             break;
//         }
//     }
//     return str;
// }
