# 会议分组

<https://wiki.quanshi.com/pages/viewpage.action?pageId=74610394>

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

每个用户所在的分组信息
#define DATA_CONTENT_USER_GROUP_ITEM(OP)     \
    GROUP_ITEM(OP, uint32_t, userID);        \
    GROUP_ITEM(OP, uint32_t, userUmsID);     \
    GROUP_ITEM(OP, uint32_t, userGroupId);   \
    GROUP_ITEM(OP, uint32_t, privilege);     \ 用户在 userGroupId 中的权限, 可听：0x01 可说: 0x02
    GROUP_ITEM(OP, string, extend);
DefData(USER_GROUP_ITEM);
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
#define DATA_CONTENT_BMS_CONF_USER_GROUP_START(OP)            \
    GROUP_ITEM(OP, uint32_t, confID);                         \
    GROUP_ITEM(OP, uint32_t, userID);                         \
    GROUP_ITEM(OP, vector<USER_GROUP_INFO>, userGroups);      \
    GROUP_ITEM(OP, vector<USER_GROUP_ITEM>, userGroupOfUser);
DefBMSCommand(BMS_CONF_USER_GROUP_START)

#define DATA_CONTENT_BMS_CONF_USER_GROUP_START_NOTIFY(OP)     \
    GROUP_ITEM(OP, uint32_t, statusCode);                     \
    GROUP_ITEM(OP, uint32_t, confID);                         \
    GROUP_ITEM(OP, uint32_t, userID);                         \
    GROUP_ITEM(OP, vector<USER_GROUP_INFO>, userGroups);      \
    GROUP_ITEM(OP, vector<USER_GROUP_ITEM>, userGroupOfUser);
DefBMSCommand(BMS_CONF_USER_GROUP_START_NOTIFY)
```

+ 获取分组用户信息
客户端发送获取会议信息请求 `BMS_CONF_INFO_REQUEST = 0x0101`
bms 发送会议信息 `BMS_CONF_INFO_REQUEST_NOTIFY = 0x0102` 最后添加一个 `vector<USER_GROUP_INFO>` 字段，此字段包含了会议中的所有分组信息
bms 发送所有用户的分组列表给请求者

```cpp
#define DATA_CONTENT_BMS_CONF_USER_GROUP_LIST_NOTIFY(OP)    \
    GROUP_ITEM(OP, uint32_t, confID);                       \
    GROUP_ITEM(OP, vector<USER_GROUP_ITEM>, userGroupList); 包含所有的用户
DefBMSCommand(BMS_CONF_USER_GROUP_LIST_NOTIFY)
```

+ 加入分组/切换分组/退出分组 (用户加入某个分组默认就订阅此分组的声音)
会中客户端拿到分组信息后发送设置分组请求到 bms (userGroupId: 退出分组->0，加入分组/切换分组->分组id)
bms 找到对应客户端用户对象，设置分组信息
bms 发送用户设置分组通知给 audioserver
bms 广播设置分组成功应答

```cpp
#define DATA_CONTENT_BMS_CONF_USER_SET_USER_GROUP(OP)     \
    GROUP_ITEM(OP, uint32_t, confID);                     \
    GROUP_ITEM(OP, uint32_t, userID);                     \
    GROUP_ITEM(OP, uint32_t, userGroupId);
DefBMSCommand(BMS_CONF_USER_SET_USER_GROUP)

#define DATA_CONTENT_BMS_CONF_USER_SET_USER_GROUP_NOTIFY(OP)  \
    GROUP_ITEM(OP, uint32_t, statusCode);                     \
    GROUP_ITEM(OP, uint32_t, confID);                         \
    GROUP_ITEM(OP, uint32_t, userID);                         \
    GROUP_ITEM(OP, uint32_t, userGroupId);
DefBMSCommand(BMS_CONF_USER_SET_USER_GROUP_NOTIFY)
```

+ 关闭分组
主持人发送关闭分组请求给 bms
bms 清楚分组信息
bms 发送关闭分组通知给 audioserver
bms 广播关闭分组成功应答

```cpp
#define DATA_CONTENT_BMS_CONF_USER_GROUP_STOP(OP)    \
    GROUP_ITEM(OP, uint32_t, confID);                \
    GROUP_ITEM(OP, uint32_t, userID);
DefBMSCommand(BMS_CONF_USER_GROUP_STOP)

#define DATA_CONTENT_BMS_CONF_USER_GROUP_STOP_NOTIFY(OP)    \
    GROUP_ITEM(OP, uint32_t, statusCode);                   \
    GROUP_ITEM(OP, uint32_t, confID);                       \
    GROUP_ITEM(OP, uint32_t, userID);
DefBMSCommand(BMS_CONF_USER_GROUP_STOP_NOTIFY)
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
#define DATA_CONTENT_AUDIO_USER_SUBSCRIBE_IN_USER_GROUP(OP)           \
    GROUP_ITEM(OP, uint32_t, confID);                                 \
    GROUP_ITEM(OP, vector<USER_GROUP_ITEM>, subscribeUserGroupInfos); \
DefBMSCommand(AUDIO_USER_SUBSCRIBE_IN_USER_GROUP)

#define DATA_CONTENT_AUDIO_USER_SUBSCRIBE_IN_USER_GROUP_NOTIFY(OP)    \
    GROUP_ITEM(OP, uint32_t, statusCode);                             \
    GROUP_ITEM(OP, uint32_t, confID);                                 \
    GROUP_ITEM(OP, vector<USER_GROUP_ITEM>, subscribeUserGroupInfos); \
DefBMSCommand(AUDIO_USER_SUBSCRIBE_IN_USER_GROUP_NOTIFY)
```

## cdts

+ 切换
cdts 切换的时候需要从 redis 加载用户分组列表（或者从 audioserver 请求最新的用户分组列表）

## redis

用户的分组信息和用户的音频订阅信息需要分开存储
用户的分组信息 bms 来存储，用户的音频订阅信息 audioserver 来存储

## 问题

+ 分组开启的过程中能否再修改分组？

