/// 为了快速确定前后端通信结果，使用int类型的状态码来确定当前状态。
/// 为确保前后端状态码一致，将该类中定义的状态码统一应用，通信数据以状态码+数据的形式传输
/// 为区分网络状态码，使用 1+各分类状态总码 开头的四位数

class Status{
  //正常
  static const int success=1000;//成功
  static const int successButUserNotExist=1001;//成功登录但是用户不存在
  
  //手机号、验证码、密码
  static const int phoneFormatError=1100;//手机号格式错误
  static const int passwordFormatError=1101;//密码格式错误
  static const int passwordError=1102;//密码错误
  static const int captchaError=1103;//验证码错误
  static const int passwordInconsistent=1104;//密码不一致
  static const int setPasswordError=1105;//设置密码错误

  //用户
  static const int userNotExist=1200;//用户不存在
  static const int userExist=1201;//用户已存在

  //网络
  static const int netError=1300;//网络错误

  //不存在状态码
  static const int noStatusCode=0000;//其他
}