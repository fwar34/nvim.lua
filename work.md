## 会议分组需求 https://wiki.quanshi.com/pages/viewpage.action?pageId=74610394

## 数据结构
1. 在会议中添加所有的分组信息列表
2. 用户的分组信息的保存，两种方案
   + 保存在用户的 customStr 中，此方案下可以不用添加获取组信息的信令，获取的用户列表中就包含了用户所属分组的信息，但是和别的逻辑有冲突风险
   + 用户新添加字段来保存分组信息，此方案下则需要调用获取用户信息去获取会议中用户(可以是所有的用户也可以是指定分组用户)的分组信息
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
客户端入会后获取的会议信息后发现已经开启了用户分组（在 `BMS_CONF_INFO_REQUEST_NOTIFY` 最后添加一个 string 字段）
客户端发送请求分组信息到 bms
bms 发送请求分组信息的成功应答给请求者（应答中包含了所有的分组信息列表）
bms 发送用户的分组列表给请求者

3. 加入分组（切换分组）
会中客户端拿到分组信息后发送加入分组请求到 bms 
bms 找到对应客户端用户对象，设置分组信息
bms 发送用户加入分组通知给 audioserver
bms 广播加入分组成功应答

5. 退出分组
客户端发送退出分组请求给 bms
bms 找到对应客户端用户对象，清除分组信息
bms 发送退出分组通知给 audioserver
bms 广播退出分组成功应答

4. 关闭分组
主持人发送关闭分组请求给 bms
bms 清楚分组信息
bms 发送关闭分组通知给 audioserver
bms 广播关闭分组成功应答

## audio
1. 加入分组
audioserver 收到 bms 发送的用户加入分组通知
audioserver 设置对应用户对象的分组信息
audioserver 发送用户加入分组通知给 cdts
cdts 处理对应的逻辑

2. 退出分组
audioserver 收到 bms 发送的用户退出分组通知
audioserver 设置对应的用户对象的分组信息
audioserver 发送用户退出分组通知给 cdts
cdts 处理对应的逻辑

3. 关闭分组
audioserver 收到 bms 发送的关闭分组通知
audioserver 清楚分组信息
audioserver 发送关闭分组通知给 cdts
cdts 处理对应逻辑

## cdts
1. 切换
cdts 切换的时候需要从 redis 加载用户分组列表（或者从 audioserver 请求最新的用户分组列表）


## 问题
1. 分组开启的过程中能否再修改分组？
