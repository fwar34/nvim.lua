# 会议分组

<https://wiki.quanshi.com/pages/viewpage.action?pageId=74610394>
<https://wiki.quanshi.com/pages/viewpage.action?pageId=78583319>

## 数据结构

1. 在会议中添加所有的分组信息列表
2. 用户的分组信息的保存，两种方案
   + 保存在用户的 customStr 中，此方案下可以不用添加获取组信息的信令，获取的用户列表中就包含了用户所属分组的信息，但是和别的逻辑有冲突风险
   + 用户新添加字段来保存分组信息，此方案下则需要调用获取用户信息去获取会议中用户(可以是所有的用户也可以是指定分组用户)的分组信息
3. 主分组 id 为 300

```cpp
每个分组的信息
#define DATA_CONTENT_BREAKOUT_ROOM_USER_ITEM(OP)                    \
    GROUP_ITEM(OP, uint32_t, userId);                               \
    GROUP_ITEM(OP, uint32_t, userUmsId);                            \
    /* 用户需要加入的组 */                                          \
    GROUP_ITEM(OP, uint32_t, userPresetRoomId);                     \
    /* 用户当前真正加入的分组 */                                    \
    GROUP_ITEM(OP, uint32_t, userCurrentRoomId);                    \
    /* 用户在 userGroupId 中的权限, 可听：0x01 可说: 0x02 */        \
    GROUP_ITEM(OP, uint32_t, privilege);                            \
    GROUP_ITEM(OP, string, extend);
DefData(BREAKOUT_ROOM_USER_ITEM);

#define DATA_CONTENT_BREAKOUT_ROOM_INFO(OP)                         \
    GROUP_ITEM(OP, uint32_t, roomID);                               \
    GROUP_ITEM(OP, string, name);                                   \
    /*服务器混音还是客户端混音 1：客户端混音 0：服务器混音*/        \
    GROUP_ITEM(OP, uint32_t, mixerMode);                            \
    GROUP_ITEM(OP, string, extend);                                 \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_USER_ITEM>, userItems);
DefData(BREAKOUT_ROOM_INFO);
```

## bms

+ 开启分组 (会前会设置分组，服务器不用解析，服务器以打开分组里面的分组信息为准)
主持人发送打开分组请求
bms 处理分组并广播开启分组成功的应答给所有客户端

```cpp
客户端使用
// 组内的成员 roomUsers，包含了没有入会的成员（userid=0，umsUserID!=0的用户），
// bms需要保存独立的列表，因为关闭分组后客户端还可能获取此列表重新编辑分组再开启分组
#define DATA_CONTENT_BMS_CONF_BREAKOUT_ROOMS_START(OP)              \
    GROUP_ITEM(OP, uint32_t, confID);                               \
    GROUP_ITEM(OP, uint32_t, userID);                               \
    GROUP_ITEM(OP, string, extend);                                 \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_INFO>, roomInfos);
DefBMSCommand(BMS_CONF_BREAKOUT_ROOMS_START)

#define DATA_CONTENT_BMS_CONF_BREAKOUT_ROOMS_START_NOTIFY(OP)       \
    GROUP_ITEM(OP, uint32_t, statusCode);                           \
    /* 当前服务器时间戳，单位为秒 */                                \
    GROUP_ITEM(OP, uint64_t, timestamp);                            \
    GROUP_ITEM(OP, uint32_t, confID);                               \
    GROUP_ITEM(OP, uint32_t, userID);                               \
    GROUP_ITEM(OP, string, extend);                                 \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_INFO>, roomInfos);
DefBMSCommand(BMS_CONF_BREAKOUT_ROOMS_START_NOTIFY)
```

+ 获取分组用户信息
处理客户端发送获取会议信息请求 `BMS_CONF_INFO_REQUEST = 0x0101` 的时候 bms 发送所有用户的分组列表给请求者，
分组启动则入会的时候在 `BMS_CONF_INFO_REQUEST` 的处理中bms主动发送这个信息给用户，否则客户端主动调用。

```cpp
客户端使用
#define DATA_CONTENT_BMS_CONF_GET_BREAKOUT_ROOMS_LIST(OP)    \
    GROUP_ITEM(OP, uint32_t, confID);                        \
    GROUP_ITEM(OP, uint32_t, userID);
DefBMSCommand(BMS_CONF_GET_BREAKOUT_ROOMS_LIST)

#define DATA_CONTENT_BMS_CONF_GET_BREAKOUT_ROOMS_LIST_NOTIFY(OP)    \
    GROUP_ITEM(OP, uint32_t, statusCode);                           \
    GROUP_ITEM(OP, uint32_t, confID);                               \
    GROUP_ITEM(OP, uint32_t, userID);                               \
    GROUP_ITEM(OP, string, extend);                                 \
    GROUP_ITEM(OP, vector<BREAKOUT_ROOM_INFO>, roomInfos);
DefBMSCommand(BMS_CONF_GET_BREAKOUT_ROOMS_LIST_NOTIFY)
```

+ 加入分组/切换分组/退出分组 (用户加入某个分组默认就订阅此分组的声音)
会中客户端拿到分组信息后发送设置分组请求到 bms (roomid: 退出分组->0，加入分组/切换分组->分组id)
bms 找到对应客户端用户对象，设置分组信息
bms 发送用户设置分组通知给 audioserver
bms 广播设置分组成功应答

```cpp
客户端使用
#define DATA_CONTENT_BMS_CONF_SET_USER_BREAKOUT_ROOM(OP)     \
    GROUP_ITEM(OP, uint32_t, confID);                        \
    GROUP_ITEM(OP, uint32_t, operatorID);                    \
    GROUP_ITEM(OP, BREAKOUT_ROOM_USER_ITEM, destItem)
DefBMSCommand(BMS_CONF_SET_USER_BREAKOUT_ROOM)

#define DATA_CONTENT_BMS_CONF_SET_USER_BREAKOUT_ROOM_NOTIFY(OP)         \
    GROUP_ITEM(OP, uint32_t, statusCode);                               \
    GROUP_ITEM(OP, uint32_t, confID);                                   \
    GROUP_ITEM(OP, uint32_t, operatorID);                               \
    GROUP_ITEM(OP, BREAKOUT_ROOM_USER_ITEM, destItem)
DefBMSCommand(BMS_CONF_SET_USER_BREAKOUT_ROOM_NOTIFY)
```

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
客户端使用
#define DATA_CONTENT_BMS_CONF_BREAKOUT_ROOMS_STOP(OP)    \
    GROUP_ITEM(OP, uint32_t, confID);                    \
    GROUP_ITEM(OP, uint32_t, userID);                    \
    /* 关闭倒计时时间(秒）*/                             \
    GROUP_ITEM(OP, uint32_t, delayTime);
DefBMSCommand(BMS_CONF_BREAKOUT_ROOMS_STOP)

#define DATA_CONTENT_BMS_CONF_BREAKOUT_ROOMS_STOP_NOTIFY(OP)    \
    GROUP_ITEM(OP, uint32_t, statusCode);                       \
    GROUP_ITEM(OP, uint32_t, confID);                           \
    GROUP_ITEM(OP, uint32_t, userID);                           \
    GROUP_ITEM(OP, uint32_t, delayTime);
DefBMSCommand(BMS_CONF_BREAKOUT_ROOMS_STOP_NOTIFY)
```

+ 客户端通知录制哪个分组的信令
```cpp
客户端使用
#define DATA_CONTENT_AUDIO_RECORD_BREAKOUT_ROOM(OP)      \
    GROUP_ITEM(OP, uint32_t, confID);                    \
    GROUP_ITEM(OP, uint32_t, roomID);
DefAudioCommand(AUDIO_RECORD_BREAKOUT_ROOM)

#define DATA_CONTENT_AUDIO_RECORD_BREAKOUT_ROOM_NOTIFY(OP)      \
    GROUP_ITEM(OP, uint32_t, statusCode);                       \
    GROUP_ITEM(OP, uint32_t, confID);                           \
    GROUP_ITEM(OP, uint32_t, roomID);
DefAudioCommand(AUDIO_RECORD_BREAKOUT_ROOM_NOTIFY)
```

## 用户退会
当用户退会时，server需要更新下 roomUsers，如果是有userUmsId的用户则，把userCurrentRoomId设置成0，如果是userId的用户，则删除该条记录。
这个修改不需要通知到客户端，客户端本身会根据用户退会，做相同的处理。
umsUserID为0则把用户从分组列表删除，否则只设置userCurrentRoomId为0，不用通知客户端

## 特殊用户需要 mixer 混音的声

audioserver 将主分组里面说话的声音继续使用 `JOIN_MIXER` 通知到mixer
全体静音只处理主分组，其他分组的直接广播
16路限制需要对主分组起作用
主分组支持电话会议其他分组不支持

## audio

+ 打开/关闭分组
1. 服务器混音的 breakout rooms 需要给 cdts 和 mixer（通知 mixer 的用户是在 breakout room 中可说的用户列表，现阶段可能所有的用户都是可听可说的） 都通知
2. 客户端混音的 breakout rooms 只需要给 cdts 通知

```cpp
#define DATA_CONTENT_BreatoutRoomUserInfo(OP)                   \
    GROUP_ITEM(OP, uint32_t, userID);                           \
    /* cdts 来控制是否转发静音数据 */                           \
    GROUP_ITEM(OP, uint32_t, privilege);                        \
    GROUP_ITEM(OP, ChannelID, dtsChannelID);
DefData(BreakoutRoomUserInfo);

#define DATA_CONTENT_BreakoutRoomInfo(OP)                       \
    GROUP_ITEM(OP, uint32_t, roomID);                           \
    GROUP_ITEM(OP, uint32_t, mixerMode);                        \
    GROUP_ITEM(OP, vector<BreakoutRoomUserInfo>, userInfos);
DefData(BreakoutRoomInfo);

#define DATA_CONTENT_AUDIO_BREAKOUT_ROOM_STATE_TO_CDTS(OP)              \
    GROUP_ITEM(OP, ConfID, confID);                                     \
    /* 打开：1，关闭：0 */                                              \
    GROUP_ITEM(OP, uint32_t, status);                                   \
    GROUP_ITEM(OP, vector<BreakoutRoomInfo>, roomInfos);
DefPhoneCommand(AUDIO_BREAKOUT_ROOM_STATE_TO_CDTS);

#define DATA_CONTENT_AudioConfig_mixer_info(OP)                 \
    GROUP_ITEM(OP, UserID, user);                               \
    /* 发送到 mixer 的都是可说的用户，所以此字段可以不用 */     \
    GROUP_ITEM(OP, UINT32_t, privilege);                        \
    GROUP_ITEM(OP, ChannelID, dtsChannelID);                    \
    GROUP_ITEM(OP, AudioConfig, config);                        \
    GROUP_ITEM(OP, UINT16_t, clientType);                       \
    GROUP_ITEM(OP, UINT16_t, role);
DefData(AudioConfig_mixer_info);

#define DATA_CONTENT_BreakoutRoomUserInfoMixer(OP)              \
    GROUP_ITEM(OP, UINT32_t, roomID);                           \
    GROUP_ITEM(OP, vector<AudioConfig_mixer_info>, userInfos);
DefData(BreakoutRoomUserInfoMixer);

发送给 mixer
#define DATA_CONTENT_AUDIO_BREAKOUT_ROOM_STATE_TO_MIXER(OP)             \
    GROUP_ITEM(OP, uint32_t, confID);                                   \
    /* 打开：1，关闭：0 */                                              \
    GROUP_ITEM(OP, uint32_t, status);                                   \
    GROUP_ITEM(OP, vector<BreakoutRoomUserInfoMixer>, roomInfos);
DefAudioCommand(AUDIO_BREAKOUT_ROOM_STATE_TO_MIXER)
```

+ 用户单独订阅某些组的声音(老师在主分组的时候可以指定听某些分组的声音，后续要改变用户在目标组的权限也是用此接口通知 cdts)

1. 会中用户订阅新的语音的时候判断订阅的目标 breakout rooms 是服务器混音并且用户需要在目标 breakout rooms 中说话的时候通知 mixer，否则就只通知 cdts
```cpp
此接口客户端使用，支持同时订阅多个组，全量更新（用户所在的组不用订阅）
#define DATA_CONTENT_UserAudioSubscribeInfo(OP)                                 \
    GROUP_ITEM(OP, UserID, roomID);                                             \
    /* 对录制的服务器混音来控制此用户是否需要混音输出的数据，                   \
    可听或者可说（mixer 判断用户可说则加入混音引擎）*/                          \
    GROUP_ITEM(OP, UINT32_t, privilege);                                        \
DefData(BreakoutRoomSubscribeInfo);

客户端使用
#define DATA_CONTENT_AUDIO_USER_SUBSCRIBE_IN_BREAKOUT_ROOM(OP)                  \
    GROUP_ITEM(OP, uint32_t, confID);                                           \
    GROUP_ITEM(OP, UserID, user);                                               \
    GROUP_ITEM(OP, vector<BreakoutRoomSubscribeInfo>, subscribeInfos);
DefAudioCommand(AUDIO_USER_SUBSCRIBE_IN_BREAKOUT_ROOM)

#define DATA_CONTENT_AUDIO_USER_SUBSCRIBE_IN_BREAKOUT_ROOM_NOTIFY(OP)           \
    GROUP_ITEM(OP, uint32_t, statusCode);                                       \
    GROUP_ITEM(OP, uint32_t, confID);                                           \
    GROUP_ITEM(OP, UserID, user);                                               \
    GROUP_ITEM(OP, vector<BreakoutRoomSubscribeInfo>, subscribeInfos);
DefAuidoCommand(AUDIO_USER_SUBSCRIBE_IN_BREAKOUT_ROOM_NOTIFY)
// ----------------------------------------------------------------
#define DATA_CONTENT_UserAudioSubscribeInfo(OP)                                 \
    GROUP_ITEM(OP, UserID, user);                                               \
    GROUP_ITEM(OP, vector<BreakoutRoomSubscribeInfo>, subscribeInfos);
DefData(UserAudioSubscribeInfo);

发送给 cdts
#define DATA_CONTENT_AUDIO_BREAKOUT_SUBSCRIBE_BREAKOUT_ROOMS_TO_CDTS(OP)        \
    GROUP_ITEM(OP, uint32_t, confID);                                           \
    GROUP_ITEM(OP, uint32_t, groupID);                                          \
    GROUP_ITEM(OP, vector<UserAudioSubscribeInfo>, userSubscribeInfos);
DefAudioCommand(AUDIO_BREAKOUT_SUBSCRIBE_BREAKOUT_ROOMS_TO_CDTS)

发送给 mixer
#define DATA_CONTENT_UserAudioSubscribeInfoMixer(OP)                            \
    GROUP_ITEM(OP, uint32_t, roomID);                                           \
    GROUP_ITEM(OP, AudioConfig_mixer_info, info);
DefData(UserAudioSubscribeInfoMixer);

#define DATA_CONTENT_AUDIO_BREAKOUT_SUBSCRIBE_BREAKOUT_ROOMS_TO_MIXER(OP)       \
    GROUP_ITEM(OP, uint32_t, confID);                                           \
    GROUP_ITEM(OP, vector<UserAudioSubscribeInfoMixer>, roomInfos);
DefAudioCommand(AUDIO_BREAKOUT_SUBSCRIBE_BREAKOUT_ROOMS_TO_MIXER)
```

+ audioserver 还少一组获取分组音频信息的信令

## cdts

+ 切换
cdts 切换的时候需要从 redis 加载用户分组列表（或者从 audioserver 请求最新的用户分组列表）

## 注意

+ 用户的分组信息和用户的音频订阅信息需要分开存储
+ 用户的分组信息 bms 来存储，用户的音频订阅信息 audioserver 来存储
+ 用户的分组信息需要独立存储而且不能删除（因为主持人再次开启分组的时候需要编辑老的列表）
+ 800 用户需要跟随主持人进去的分组，需要客户端使用 `AUDIO_USER_SUBSCRIBE_IN_BREAKOUT_ROOM` 来控制
+ 老的 mixer join 使用新的接口发给 mixer，信令中只有一个分组，分组中包含了所有的需要混音的用户
+ 关闭分组的时候需要重新通知给 mixer 当前的分组信息
+ 用户的 audioState 和 用户在每个分组的 privilege 共同决定了用户在此分组的传输权限
+ 静音接口的 mode 添加两个模式：组内全体静音和解除静音，此两种模式下 groupID 赋值 roomID
+ 用户解除静音或者打开音频的时候判断当前分组上行人数，达到限制的话就静音，否则打开
+ 用户非静音加入一个分组的话客户端去判断目标分组当前上行人数，达到限制的话就静音，否则继续非静音

## 问题

## 编码测试计划
+ bms
会议用户添加相关字段，添加分组结构添加新的分组信令 -- 4天
+ business
添加分组对应信息 -- 1天
+ audioserver
添加分组结构，调整现有的静音接口，添加分组对应的逻辑，添加和mixer的接口 -- 5天
+ tang-cache
添加分组对应的数据结构和接口 -- 3天
+ libacctrans
添加分组对应的接口和切换接口 -- 2天

纯编码14天，联调时间3月23日
