/// 为了快速确定前后端通信结果，使用int类型的状态码来确定当前状态。
/// 为确保前后端状态码一致，将该类中定义的状态码统一应用，通信数据以状态码+数据的形式传输
/// 为区分网络状态码，使用 1+各分类状态总码 开头的四位数

class Status{
  //正常
  static const int success=1000;//成功
  static const int successButUserNotExist=1001;//成功登录但是用户不存在
  
  //邮箱、验证码、密码
  static const int mailFormatError=1100;//格式错误
  static const int passwordFormatError=1101;//密码格式错误
  static const int passwordError=1102;//密码错误
  static const int captchaError=1103;//验证码错误
  static const int passwordInconsistent=1104;//密码不一致
  static const int setPasswordError=1105;//设置密码错误
  static const int captchaExpiration=1106;//验证码过期

  //用户
  static const int userNotExist=1200;//用户不存在
  static const int userExist=1201;//用户已存在
  static const int setUsernameError=1202;//通信数据库设置用户名时出现错误
  static const int setLongitudeAndLatitudeError=1203;//通信数据库设置经纬度时出现错误
  static const int setPointError=1204;//通信数据库设置积分时出现错误
  static const int setRegisteredError=1204;//通信数据库设置注册状态时出现错误
  static const int setAvatarError=1205;//通信数据库设置头像时出现错误
  static const int avatarMissing=1206;//头像路径为空
  static const int usernameFormatError=1207;

  //网络
  static const int netError=1300;//网络错误
  static const int ossError=1301;//Oss服务器错误
  static const int infoMiss=1302;//传输信息缺失
  static const int mailServiceError=1303;//邮箱验证码服务错误
  static const int pyServerError=1304;//Py服务器错误

  static const int taskAddError=1400;
  static const int taskGetError=1401;

  static const int click=1500;
  static const int like=1501;
  static const int chat=1502;
  static const int access=1503;
  static const int dislike=1504;
  static const int accessError=1505;
  static const int dislikeError=1506;
  static const int likeError=1507;

  //不存在状态码
  static const int noStatusCode=0000;//其他
}