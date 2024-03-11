import 'package:get/get.dart';

class Discriminator{
  static bool accountOk(String account){
    // 定义电子邮件地址的正则表达式
    const String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

    // 创建一个正则表达式实例
    RegExp regex = RegExp(emailPattern);

    // 使用正则表达式进行匹配
    return regex.hasMatch(account);
  }

  static bool captchaOk(String captcha){
    if(captcha.length!=6) return false;//验证码长度不对
    if(!captcha.isNum) return false;//密码中存在非数字字符
    return true;
  }

  static bool passwordOk(String password){
    //TODO: 
    return true;
  }
}