

import 'dart:async';

import 'package:client_application/utils/discriminator.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:client_application/utils/result.dart';
import 'package:client_application/utils/status.dart';
import 'package:get/get.dart';

class UserNetService extends GetConnect{
  UserNetService._internal();
  factory UserNetService() => _instance;
  static final UserNetService _instance = UserNetService._internal();
  static UserNetService getInstance() => _instance;


  Future TimeTestModel(int init)async{//模拟网络请求延时
    //模拟延时
    return Future.delayed(Duration(seconds: init),(){
      return 'Net delay test';
    });
  }

  Future<Result<bool>> loginWithPasswordPage(String account, String password) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.phoneFormatError, data: false);
    }
    //TODO:
    await TimeTestModel(3);
    //var t=await get("www.baidu.com");

    printInfo(info:"NET TEST");

    bool res=true;
    SpUtils.setBool("isLogin", res);
    SpUtils.setString("account", account);
    SpUtils.setString("password", password);
    return Result.success(data: res);
  }

  Future<Result<bool>> loginWithCaptcha(String account,String captcha) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.phoneFormatError, data: false);
    }
    //TODO:
    await TimeTestModel(3);


    return Result.success(data: true);
  }

  Future<Result<bool>> sendCaptcha(String account) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.phoneFormatError, data: false);
    }
    //TODO:
    await TimeTestModel(3);


    return Result.success(data: true);
  }
  
  
}