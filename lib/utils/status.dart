/// 为了快速确定前后端通信结果，使用int类型的状态码来确定当前状态。
/// 为确保前后端状态码一致，将该类中定义的状态码统一应用，通信数据以状态码+数据的形式传输
/// 为区分网络状态码，使用 1+各分类状态总码 开头的四位数

class Status{
  //正常登录
  static const int success=1000;
  
  //手机号、验证码、密码
  static const int phoneFormatError=1100;
  static const int passwordFormatError=1101;
  static const int passwordError=1102;
  static const int captchaError=1103;

  //用户
  static const int userNotExist=1200;

  //网络
  static const int netError=1300;

  //不存在状态码
  static const int noStatusCode=0000;
}