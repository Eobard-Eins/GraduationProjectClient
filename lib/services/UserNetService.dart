

import 'dart:async';

import 'package:client_application/utils/localStorage.dart';

class UserNetService{
  static Future TimeTestModel(int init)async{//模拟网络请求延时
    //模拟延时
    return Future.delayed(Duration(seconds: init),(){
      return 'Net delay test';
    });
  }

  static Future<bool> loginWithPasswordPage(String account, String password) async{
    await TimeTestModel(3);

    bool res=true;
    SpUtils.setBool("isLogin", res);
    SpUtils.setString("account", account);
    SpUtils.setString("password", password);
    return res;
  }
  static bool loginWithCaptcha(String captcha) {
    return true;
  }
  static bool sendCaptcha() {
    return true;
  }
  
  static bool isNewUser(String value) {
    return false;
  }

  static bool verifyPassword(String value) {
    return true;
  }
  
}