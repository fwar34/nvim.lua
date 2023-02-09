## 会议分组需求 https://wiki.quanshi.com/pages/viewpage.action?pageId=74610394

## bms信令
1. 开启分组
包含了所有的分组信息列表，里面没有用户列表
```
#define DATA_CONTENT_USER_GROUP_INFO(OP) \
    GROUP_ITEM(OP, uint32_t, id);        \
    GROUP_ITEM(OP, string, name);        \
    GROUP_ITEM(OP, string, extend);
DefData(USER_GROUP_INFO);

#define DATA_CONTENT_USER_GROUPS(OP) \
    GROUP_ITEM(OP, USER_GROUP_INFO, userGroups);
DefData(USER_GROUPS);


```

2. 关闭分组

3. 加入分组
用户加入某个分组

4. 退出分组
用户退出分组

5. 切换分组
用户从A分组切换到B分组（减少客户端和服务器之间信令交互）

6. 获取分组用户信息
获取所有的用户列表，每个用户有所属分组标志

## audio信令
1. 

## libacctrans信令

## 数据结构
1. 在会议中添加所有的分组信息列表

2. 用户的分组信息，两种方案

