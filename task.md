### 需求
1. 每个账户创建会议的时候携带可用的会议室列表，列表中所有的会议室都在使用则返回失败，否则创建会议占用方数最小的会议室
2. 一个会议当人数达到了所在会议是最大方数的时候就需要升方，升方的时候判断是否有刚好方数大一级的会议室空闲，如果有则升方，否则失败
3. 当前正在开的会议所属的umsuserid可用的会议室列表发生变化(用户入会时候携带的customercode_info)的时候只影响本会议，不影响此customuserid的其他会议
```
注意：会议室的方数不可变，但是每个人可分配的会议室列表可以发生变化
```

### 数据结构
1. Conference中添加可分配的会议室列表(customercode_info)，以及当前在使用的会议室
2. 当前会议所属的customercode

### redis table
```
(customercode)_meeting_rooms -> {
    会议室id1: json(包含会议室名字name，方数capacity，会议conference等信息)
    会议室id2: json(包含会议室名字name，方数capacity，会议conference等信息)
}
```

```
struct MeetingRoom {
    string name;
    string id;
    uint32_t capacity;
};

struct customercode_info {
    string customer_code;
    vector<MeetingRoom> meeting_rooms;
};
```

### 创建会议
+ 创建会议流程
1. 判断customercode_info与本地会议的customercode_info对比是否有增加，增加的话则去(customercode)_meeting_rooms中判断新添加的是否已经存在，没有存在的话更新到(customercode)_meeting_rooms
2. 在(customercode)meeting_rooms中查询并且占用方数最小的会议室，没有的话则返回失败
上面两步在redis中原子操作

+ 入会流程
1. 判断用户入会带的customercode_info与本地会议的customercode_info对比是否增加，增加的话则去(customercode)_meeting_rooms中判断新添加的是否已经存在，没有的话则更新到(customercode)_meeting_rooms
2. 在(customercode)_meeting_rooms中查询当前会议室是否需要升方，如果需要升方则判断出是否有满足需求的会议室，没有的话则返回失败
上面两步在redis中原子操作

```cpp
Conference conf;
CreateConfReq req;
req.customercode_info 对比 conf.customercode_info 增加了 MeetingRoom new_room1 new_room2;
conf.customercode_info = req.customercode_info;
string script = "
if not redis.call('HGET', KEYS[1], KEYS[2]) then
    redis.call('HSET', KEYS[1], KEYS[2])
end

" 3 (customercode)_meeting_rooms new_room1_json new_room2_json ;
```
