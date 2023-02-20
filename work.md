# 会议分组

<https://wiki.quanshi.com/pages/viewpage.action?pageId=74610394>
<https://wiki.quanshi.com/pages/viewpage.action?pageId=78583319>

## 数据结构

1. 在会议中添加所有的分组信息列表
2. 用户的分组信息的保存，两种方案
   + 保存在用户的 customStr 中，此方案下可以不用添加获取组信息的信令，获取的用户列表中就包含了用户所属分组的信息，但是和别的逻辑有冲突风险
   + 用户新添加字段来保存分组信息，此方案下则需要调用获取用户信息去获取会议中用户(可以是所有的用户也可以是指定分组用户)的分组信息
3. 主分组 id 为 0

```cpp
每个分组的信息
#define DATA_CONTENT_USER_GROUP_INFO(OP) \
    GROUP_ITEM(OP, uint32_t, id);        \
    GROUP_ITEM(OP, string, name);        \
    GROUP_ITEM(OP, string, extend);
DefData(USER_GROUP_INFO);

每#define DATA_CONTENT_BREAKOUT_ROOM_USER_ITEM(OP)     \
    GROUP_ITEM(OP, uint32_t, userId);                  \
    GROUP_ITEM(OP, uint32_t, userUmsId);               \
    GROUP_ITEM(OP, uint32_t, userPresetRoomId);        \ — 用户需要加入的组
    GROUP_ITEM(OP, uint32_t, userCurrentRoomId);       \ — 用户当前真正加入的分组
    GROUP_ITEM(OP, uint32_t, privilege);               \ 用户在 userGroupId 中的权限, 可听：0x01 可说: 0x02
    GROUP_ITEM(OP, string, extend);
DefData(BREAKOUT_ROOM_USER_ITEM);个用户所在的分组信息
```

## 服务器与客户端交互信令

```cpp
BMS_CONF_USER_GROUP_START
BMS_CONF_USER_GROUP_LIST_NOTIFY
BMS_CONF_USER_SET_USER_GROUP
BMS_CONF_USER_GROUP_STOP
AUDIO_USER_SUBSCRIBE_IN_USER_GROUP
```

## bms

1. 开启分组 (会前会设置分组，服务器不用解析，服务器以打开分组里面的分组信息为准)
主持人发送打开分组请求
bms 处理分组并广播开启分组成功的应答给所有客户端

```cpp
#define DATA_CONTENT_BMS_CONF_BREAKOUT_ROOMS_START(OP)       \
    GROUP_ITEM(OP, uint32_t, confID);                        \
    GROUP_ITEM(OP, uint32_t, userID);                        \
    GROUP_ITEM(OP, string, extend);                          \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_INFO>, rooms);       \ – 组的信息
    – 组内的成员，包含了没有入会的成员（userid=0，umsUserID!=0的用户），bms需要保存独立的列表，因为关闭分组后客户端还可能获取此列表重新编辑分组再开启分组
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_USER_ITEM>, roomUsers); 
DefBMSCommand(BMS_CONF_BREAKOUT_ROOMS_START)


#define DATA_CONTENT_BMS_CONF_BREAKOUT_ROOMS_START_NOTIFY(OP)       \
    GROUP_ITEM(OP, uint32_t, statusCode);                           \
    GROUP_ITEM(OP, uint32_t, confID);                               \
    GROUP_ITEM(OP, uint32_t, userID);                               \
    GROUP_ITEM(OP, string, extend);                                 \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_INFO>, rooms);              \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_USER_ITEM>, roomUsers); 
DefBMSCommand(BMS_CONF_BREAKOUT_ROOMS_START_NOTIFY)
```

+ 获取分组用户信息
处理客户端发送获取会议信息请求 `BMS_CONF_INFO_REQUEST = 0x0101` 的时候 bms 发送所有用户的分组列表给请求者，
分组启动则入会的时候在 `BMS_CONF_INFO_REQUEST` 的处理中bms主动发送这个信息给用户，否则客户端主动调用。

```cpp
#define DATA_CONTENT_BMS_CONF_GET_BREAKOUT_ROOMS_LIST(OP)    \
    GROUP_ITEM(OP, uint32_t, confID);                        \
    GROUP_ITEM(OP, uint32_t, userID);
DefBMSCommand(BMS_CONF_GET_BREAKOUT_ROOMS_LIST)

#define DATA_CONTENT_BMS_CONF_GET_BREAKOUT_ROOMS_LIST_NOTIFY(OP)    \
    GROUP_ITEM(OP, uint32_t, confID);                               \
    GROUP_ITEM(OP, string, extend);                                 \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_INFO>, rooms);              \ – 组的信息
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_USER_ITEM>, roomUsers);
DefBMSCommand(BMS_CONF_GET_BREAKOUT_ROOMS_LIST_NOTIFY)
```

+ 加入分组/切换分组/退出分组 (用户加入某个分组默认就订阅此分组的声音)
会中客户端拿到分组信息后发送设置分组请求到 bms (userGroupId: 退出分组->0，加入分组/切换分组->分组id)
bms 找到对应客户端用户对象，设置分组信息
bms 发送用户设置分组通知给 audioserver
bms 广播设置分组成功应答

```cpp
#define DATA_CONTENT_BMS_CONF_SET_USER_BREAKOUT_ROOM(OP)     \
    GROUP_ITEM(OP, uint32_t, confID);                        \
    GROUP_ITEM(OP, uint32_t, userID);                        \
    GROUP_ITEM(OP, uint32_t, userGroupId);                   \
    GROUP_ITEM(OP,BREAKOUT_ROOM_USER_ITEM, user)
DefBMSCommand(BMS_CONF_SET_USER_BREAKOUT_ROOM)

#define DATA_CONTENT_BMS_CONF_USER_SET_USER_BREAKOUT_ROOM_NOTIFY(OP)   \
    GROUP_ITEM(OP, uint32_t, statusCode);                              \
    GROUP_ITEM(OP, uint32_t, confID);                                  \
    GROUP_ITEM(OP, uint32_t, userID);                                  \
    GROUP_ITEM(OP, uint32_t, userGroupId);                             \
    GROUP_ITEM(OP,BREAKOUT_ROOM_USER_ITEM, user)
DefBMSCommand(BMS_CONF_USER_SET_USER_BREAKOUT_ROOM_NOTIFY)

```
各项操作填充的有效参数：
1.分配或者移动分组
设置 userId/userUmsId，userPresetRoomId
2.加入分组
设置 userId/userUmsId，userPresetRoomId，userCurrentRoomId，而且 userPresetRoomId == userCurrentRoomId
3.离开分组回到主会场
设置 userId/userUmsId，userCurrentRoomId = 0
用户加入分组的时候默认订阅此分组的声音（是否可听可说依据privilege）

## 用户退会
当用户退会时，server需要更新下 roomUsers，如果是有userUmsId的用户则，把userCurrentRoomId设置成0，如果是userId的用户，则删除该条记录。
这个修改不需要通知到客户端，客户端本身会根据用户退会，做相同的处理。
umsUserID为0则把用户从分组列表删除，否则只设置userCurrentRoomId为0，不用通知客户端


+ 关闭分组
主持人发送关闭分组请求给 bms
bms 清楚分组信息
bms 发送关闭分组通知给 audioserver
bms 广播关闭分组成功应答

当客户端发送stop指令时，会根据分组的设置，设置 delayTIme 参数。
1.如果delayTime = 0，则server端马上结束分组，广播 `stop_notify` 消息到客户端，客户端判断delayTime=0，则马上回到主会场。
2.如果delayTime > 0，则server需要启动延时定时器，广播 `stop_notify`  消息到客户端，客户端根据delayTime，显示退出分组的倒计时。
server端当定时器到期或者没有任何人员在分组中，则再次广播 `stop_notify` 消息到客户端，这个时候的delayTime=0。
server端从收到stop指令到分组真正的结束，期间用户不能加入分组。
server端真正结束分组时，需要把用户音频回到主会场，设置分组状态为结束

```cpp
#define DATA_CONTENT_BMS_CONF_BREAKOUT_ROOMS_STOP(OP)    \
    GROUP_ITEM(OP, uint32_t, confID);                    \
    GROUP_ITEM(OP, uint32_t, userID);                    \
    GROUP_ITEM(OP, uint32_t, delayTime);                 \ – 关闭倒计时时间(秒）
DefBMSCommand(BMS_CONF_BREAKOUT_ROOMS_STOP)

#define DATA_CONTENT_BMS_CONF_BREAKOUT_ROOMS_STOP_NOTIFY(OP)    \
    GROUP_ITEM(OP, uint32_t, statusCode);                       \
    GROUP_ITEM(OP, uint32_t, confID);                           \
    GROUP_ITEM(OP, uint32_t, userID);                           \
    GROUP_ITEM(OP, uint32_t, delayTime);
DefBMSCommand(BMS_CONF_BREAKOUT_ROOMS_STOP_NOTIFY)
```

## 特殊用户需要 mixer 混音的声

audioserver 将主分组里面说话的声音继续使用 `JOIN_MIXER` 通知到mixer
全体静音只处理主分组，其他分组的直接广播
16路限制需要对主分组起作用
主分组支持电话会议其他分组不支持

## audio

+ 打开/关闭分组
audioserver 收到 bms 发送的关闭分组通知
audioserver 清除分组信息
audioserver 发送关闭分组通知给 cdts
cdts 处理对应逻辑

```cpp
发送给 cdts
#define DATA_CONTENT_AUDIO_USER_GROUP_STATE_TO_CDTS(OP)       \
    GROUP_ITEM(OP, uint32_t, confID);                         \
    GROUP_ITEM(OP, uint32_t, status);                         \ 打开：1，关闭：0
    GROUP_ITEM(OP, vector<USER_GROUP_ITEM>, userGroupOfUser);
DefAudioCommand(AUDIO_USER_GROUP_STATE_TO_CDTS)
```

+ 加入分组/切换分组/退出分组
audioserver 收到 bms 发送的用户设置分组通知
audioserver 设置对应用户对象的分组信息
audioserver 发送用户设置分组通知给 cdts
cdts 处理对应的逻辑

```cpp
发送给 cdts
#define DATA_CONTENT_AUDIO_USER_SUBSCRIBE_USER_GROUP_TO_CDTS(OP)    \
    GROUP_ITEM(OP, uint32_t, confID);                               \
    GROUP_ITEM(OP, vector<USER_GROUP_ITEM>, userGroupInfos);
DefAudioCommand(AUDIO_USER_SUBSCRIBE_USER_GROUP_TO_CDTS)
```

+ 用户单独订阅某些组的声音(老师在主分组的时候可以指定听某些分组的声音)
用户发送订阅请求给 audioserver
audioserver 更新用户的订阅列表
audisoerver 发送 `AUDIO_USER_SUBSCRIBE_USER_GROUP_TO_CDTS` 给 cdts
audioserver 应答订阅成功应答给请求者

```cpp
#define DATA_CONTENT_AUDIO_USER_SUBSCRIBE_IN_USER_GROUP(OP)                   \
    GROUP_ITEM(OP, uint32_t, confID);                                         \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_USER_ITEM>, subscribeUserGroupInfos);
DefBMSCommand(AUDIO_USER_SUBSCRIBE_IN_USER_GROUP)

#define DATA_CONTENT_AUDIO_USER_SUBSCRIBE_IN_USER_GROUP_NOTIFY(OP)            \
    GROUP_ITEM(OP, uint32_t, statusCode);                                     \
    GROUP_ITEM(OP, uint32_t, confID);                                         \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_USER_ITEM>, subscribeUserGroupInfos);
DefBMSCommand(AUDIO_USER_SUBSCRIBE_IN_USER_GROUP_NOTIFY)
-这个接口支持同时订阅多个组。
```

## cdts

+ 切换
cdts 切换的时候需要从 redis 加载用户分组列表（或者从 audioserver 请求最新的用户分组列表）

## redis

用户的分组信息和用户的音频订阅信息需要分开存储
用户的分组信息 bms 来存储，用户的音频订阅信息 audioserver 来存储

## 问题

+ 分组开启的过程中能否再修改分组？

