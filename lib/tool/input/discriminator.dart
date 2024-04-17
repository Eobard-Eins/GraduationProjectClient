import 'package:get/get.dart';

class Discriminator{
  static bool accountOk(String account){
    if(account.length>=30) return false;
    // 定义电子邮件地址的正则表达式
    const String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,30}$";

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
    if(password.length<6) return false;
    //正则表达式匹配只包含字母、数字、符号的密码
    final relaxedPasswordRegex = RegExp(r'^[A-Za-z\d!@#$%^&*.]{6,16}$');
    return relaxedPasswordRegex.hasMatch(password);
  }

  static List<String> getLabels(String content){
    // 正则表达式
    final pattern = RegExp(r'#[\u4e00-\u9fa5\w\d]+');
    
    // 提取所有匹配项
    final matches = pattern.allMatches(content);
    
    // 将匹配到的分隔符存入一个集合，避免重复处理
    List<String> separators = matches.map((match) => match[0]!).toSet().toList();   
    List<String> res=[];
    for(String s in separators){
      res.add(s.substring(1));
    }
    return res;
  }

  static bool usernameOk(String username) {
    if(username.length<3||username.length>8) return false;
    return true;
  }
}