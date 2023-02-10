## 会议分组需求 https://wiki.quanshi.com/pages/viewpage.action?pageId=74610394

## 数据结构
1. 在会议中添加所有的分组信息列表
2. 用户的分组信息的保存，两种方案
   + 保存在用户的 customStr 中，此方案下可以不用添加获取组信息的信令，获取的用户列表中就包含了用户所属分组的信息，但是和别的逻辑有冲突风险
   + 用户新添加字段来保存分组信息，此方案下则需要调用获取用户信息去获取会议中用户(可以是所有的用户也可以是指定分组用户)的分组信息
3. 主分组 id 为 0
```
#define DATA_CONTENT_USER_GROUP_INFO(OP) \
    GROUP_ITEM(OP, uint32_t, id);        \
    GROUP_ITEM(OP, string, name);        \
    GROUP_ITEM(OP, string, extend);
DefData(USER_GROUP_INFO);
```

## bms
1. 开启分组
主持人发送打开分组请求
bms 处理分组并广播开启分组成功的应答给所有客户端
```
#define DATA_CONTENT_BMS_CONF_USER_GROUP_START(OP) \
    GROUP_ITEM(OP, uint32_t, confID);              \
    GROUP_ITEM(OP, uint32_t, userID);
DefBMSCommand(BMS_CONF_USER_GROUP_START)

#define DATA_CONTENT_BMS_CONF_USER_GROUP_START_NOTIFY(OP) \
    GROUP_ITEM(OP, uint32_t, statusCode);                 \
    GROUP_ITEM(OP, uint32_t, confID);                     \
    GROUP_ITEM(OP, uint32_t, userID);                     \
    GROUP_ITEM(OP, vector<USER_GROUP_INFO>, userGroups);
DefBMSCommand(BMS_CONF_USER_GROUP_START_NOTIFY)
```

2. 获取分组用户信息
客户端发送获取会议信息请求
bms 发送会议信息 `BMS_CONF_INFO_REQUEST_NOTIFY` 最后添加一个 `vector<USER_GROUP_INFO>` 字段，此字段包含了会议中的所有分组信息
bms 发送所有用户的分组列表给请求者
```
#define DATA_CONTENT_USER_GROUP_ITEM(OP)     \
    GROUP_ITEM(OP, uint32_t, userGroupId);   \
    GROUP_ITEM(OP, uint32_t, userID);        \
    GROUP_ITEM(OP, string, extend);
DefData(USER_GROUP_ITEM);

#define DATA_CONTENT_BMS_CONF_USER_GROUP_LIST_NOTIFY(OP)    \
    GROUP_ITEM(OP, uint32_t, confID);                       \
    GROUP_ITEM(OP, vector<USER_GROUP_ITEM>, userGroupList);
DefBMSCommand(BMS_CONF_USER_GROUP_LIST_NOTIFY)
```

3. 加入分组/切换分组/退出分组
会中客户端拿到分组信息后发送设置分组请求到 bms (userGroupId: 退出分组->0，加入分组/切换分组->分组id)
bms 找到对应客户端用户对象，设置分组信息
bms 发送用户设置分组通知给 audioserver
bms 广播设置分组成功应答
```
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

4. 关闭分组
主持人发送关闭分组请求给 bms
bms 清楚分组信息
bms 发送关闭分组通知给 audioserver
bms 广播关闭分组成功应答
```
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

## audio
1. 加入分组/切换分组/退出分组
audioserver 收到 bms 发送的用户设置分组通知
audioserver 设置对应用户对象的分组信息
audioserver 发送用户设置分组通知给 cdts
cdts 处理对应的逻辑

2. 关闭分组
audioserver 收到 bms 发送的关闭分组通知
audioserver 清楚分组信息
audioserver 发送关闭分组通知给 cdts
cdts 处理对应逻辑

## cdts
1. 切换
cdts 切换的时候需要从 redis 加载用户分组列表（或者从 audioserver 请求最新的用户分组列表）

## 问题
1. 分组开启的过程中能否再修改分组？
