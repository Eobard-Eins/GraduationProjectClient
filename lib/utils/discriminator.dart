import 'package:get/get.dart';

class Discriminator{
  static bool accountOk(String account){
    if(account.length!=11) return false;//长度不为11位，不是手机号
    if(!account.isNum) return false;//账号中存在非数字字符
    return true;
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