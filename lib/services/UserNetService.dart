

import 'dart:async';

import 'package:client_application/utils/localStorage.dart';
import 'package:get/get.dart';

class UserNetService extends GetConnect{
  UserNetService._internal();

  factory UserNetService() => _instance;

  static final UserNetService _instance = UserNetService._internal();

  static UserNetService getInstance(){
    return _instance;
  }


  Future TimeTestModel(int init)async{//模拟网络请求延时
    //模拟延时
    return Future.delayed(Duration(seconds: init),(){
      return 'Net delay test';
    });
  }

  Future<bool> loginWithPasswordPage(String account, String password) async{
    await TimeTestModel(3);
    //get("www.baidu.com");
    printInfo(info:"NET TEST");

    bool res=true;
    SpUtils.setBool("isLogin", res);
    SpUtils.setString("account", account);
    SpUtils.setString("password", password);
    return res;
  }
  bool loginWithCaptcha(String captcha) {
    return true;
  }
  bool sendCaptcha() {
    return true;
  }
  
  bool isNewUser(String value) {
    return false;
  }

  bool verifyPassword(String value) {
    return true;
  }
  
}