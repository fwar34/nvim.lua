enum PHONE_CLIENT_ROLE_TYPE
{
    PHONE_CLIENT_ROLE_ATTENDEE = 0, // 参会人
    PHONE_CLIENT_ROLE_HOST = 4, // 主持人
    PHONE_CLIENT_ROLE_PRESENTER = 5, // 主讲人
    PHONE_CLIENT_ROLE_GUEST = 28 // 嘉宾
}

客户端设置电话用户角色为4 5 28的时候，转换为电话会议的主持人角色1
