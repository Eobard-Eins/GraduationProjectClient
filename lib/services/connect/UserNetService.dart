

import 'dart:async';

import 'package:client_application/services/connect/Dio.dart';
import 'package:client_application/models/User.dart';
import 'package:client_application/tool/input/discriminator.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/tool/res/result.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserNetService extends GetConnect{
  UserNetService._internal();
  factory UserNetService() => _instance;
  static final UserNetService _instance = UserNetService._internal();
  static UserNetService getInstance() => _instance;

  final String _baseUrl=staticValue.URL;

  @override
  void onInit(){
    super.onInit();
  }
  Future<Result> getUserInfo(String account) async{

    final Result res=await get("$_baseUrl/userInfo/getInfo",query:{"mailAddress":account}).then((value){
      //value.printInfo();
      //printError(info:value.body.toString());
      if(!value.isOk){
        printInfo(info:"网络异常，不能连接服务器");
        return Result.error(statusCode: Status.netError);
      }else{
        printInfo(info:"网络正常,${value.body.toString()}");
        if(value.body['statusCode']!=Status.success){
          printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
          return Result.error(statusCode:value.body['statusCode']);
        }
        
        User u=User.fromJson(value.body['data']);
        return Result.success(data: u);
      }
    }).onError((error, stackTrace){
      printInfo(info:"网络异常且未知错误  ${error.toString()}");
      return Result.error(statusCode: Status.netError);
    }).timeout(const Duration(seconds: 3),onTimeout: (){
      return Result.error(statusCode: Status.netError);
    });
    return res;
  }

  Future<Result> loginWithPassword(String account, String password) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.mailFormatError);
    }

    final Result res=await get("$_baseUrl/userLogin/loginWithPassword",query:{"mailAddress":account,"password":password}).then((value){
      //value.printInfo();
      //printError(info:value.body.toString());
      if(!value.isOk){
        printInfo(info:"网络异常，不能连接服务器");
        return Result.error(statusCode: Status.netError);
      }else{
        printInfo(info:"网络正常,${value.body.toString()}");
        if(value.body['statusCode']!=Status.success){
          printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
          return Result.error(statusCode:value.body['statusCode']);
        }
        
        User u=User.fromJson(value.body['data']);
        printInfo(info:"解析User：${u.mailAddress}");
        /*本地缓存*/ 
        SpUtils.setBool("isLogin", true);
        SpUtils.setInt("lastLoginTime",DateTime.now().millisecondsSinceEpoch);
        SpUtils.setString("account", u.mailAddress);
        // SpUtils.setString("username", u.username??"用户${u.mailAddress.split('@')[0]}");
        // SpUtils.setString("gender", u.gender??"未知");
        // SpUtils.setString("avatar", u.avatar);//存头像的网络url
        // SpUtils.setDouble("point", u.point);
        return Result.success(data: u);
      }
    }).onError((error, stackTrace){
      printInfo(info:"网络异常且未知错误  ${error.toString()}");
      return Result.error(statusCode: Status.netError);
    }).timeout(const Duration(seconds: 3),onTimeout: (){
      return Result.error(statusCode: Status.netError);
    });
    return res;
  }

  Future<Result> loginWithCaptcha(String account,String captcha) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.mailFormatError);
    }
    final Result res=await get("$_baseUrl/userLogin/loginWithCaptcha",query:{"mailAddress":account,"captcha":captcha}).then((value){
      if(!value.isOk){
        printInfo(info:"网络异常，不能连接服务器");
        return Result.error(statusCode: Status.netError);
      }else{
        printInfo(info:"网络正常,${value.body.toString()}");
        if(value.body['statusCode']!=Status.success){
          if(value.body['statusCode']==Status.successButUserNotExist){
            SpUtils.setBool("isLogin", false);
          }
          printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
          return Result.error(statusCode:value.body['statusCode']);
        }
        
        User u=User.fromJson(value.body['data']);
        printInfo(info:"解析User：${u.mailAddress}");
        /*本地缓存*/ 
        SpUtils.setBool("isLogin", true);
        SpUtils.setInt("lastLoginTime",DateTime.now().millisecondsSinceEpoch);
        SpUtils.setString("account", u.mailAddress);
        // SpUtils.setString("username", u.username??"用户${u.mailAddress.split('@')[0]}");
        // SpUtils.setString("gender", u.gender??"未知");
        // SpUtils.setString("avatar", u.avatar);//存头像的网络url
        // SpUtils.setDouble("point", u.point);
        return Result.success(data: u);
      }
    }).onError((error, stackTrace){
      printInfo(info:"网络异常且未知错误");
      return Result.error(statusCode: Status.netError);
    }).timeout(const Duration(seconds: 3),onTimeout: (){
      return Result.error(statusCode: Status.netError);
    });

    return res;
  }

  Future<Result> sendCaptcha(String account) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.mailFormatError);
    }
    
    final Result res=await get("$_baseUrl/userLogin/sendCaptcha",query:{"mailAddress":account}).then((value){
      if(!value.isOk){
        printInfo(info:"网络异常，不能连接服务器:$_baseUrl/userLogin/sendCaptcha  ${value.statusCode}|${value.statusText}");
        return Result.error(statusCode: Status.netError);
      }else{
        printInfo(info:"网络正常,${value.body.toString()}");
        if(value.body['statusCode']!=Status.success){
          printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
          return Result.error(statusCode:value.body['statusCode']);
        }

        return Result.success(data: value.body['data']);
      }
    }).onError((error, stackTrace){
      printInfo(info:"网络异常且未知错误");
      return Result.error(statusCode: Status.netError);
    }).timeout(const Duration(seconds: 3),onTimeout: (){
      return Result.error(statusCode: Status.netError);
    });

    return res;
  }
  
  Future<Result> setPassword(String account,String password,String passwordAgain) async{
    if(password!=passwordAgain){
      return Result.error(statusCode:Status.passwordInconsistent);
    }
    if(!Discriminator.passwordOk(password)){
      return Result.error(statusCode:Status.passwordFormatError);
    }
    printInfo(info:'开始设置密码:{"mailAddress":"$account","password":"$password"}');
    final Result res=await put("$_baseUrl/userInfo/setPassword", '{"mailAddress":"$account","password":"$password"}').then((value){
      if(value.isOk){
        printInfo(info:"网络正常,${value.body.toString()}");
        if(value.body['statusCode']!=Status.success){
          printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
          return Result.error(statusCode:value.body['statusCode']);
        }
        
        bool t=value.body['data'];
        return Result.success(data: t);
      }else{
        printError(info:"网络异常，不能连接服务器");
        return Result.error(statusCode: Status.netError);
      }
    }).onError((error, stackTrace){
      printError(info:"网络异常且未知错误:${error.toString()}");
      return Result.error(statusCode: Status.netError);
    }).timeout(const Duration(seconds: 3),onTimeout: (){
      return Result.error(statusCode: Status.netError);
    });
    return res;
  }

  Future<Result> setAvatar(String account,XFile? avatar) async{
    if(avatar==null) return Result.error(statusCode: Status.avatarMissing);
    final Result res=await dioService().uploadAvatar(avatar, account, "$_baseUrl/userInfo/setAvatar");
    return res;

    //return Result.success(data: true);
  }

  Future<Result> setUsername(String account,String username) async{
    if(!Discriminator.usernameOk(username)) return Result.error(statusCode: Status.usernameFormatError);
    final Result res=await put("$_baseUrl/userInfo/setName", '{"mailAddress":"$account","username":"$username"}').then((value){
      if(value.isOk){
        printInfo(info:"网络正常,${value.body.toString()}");
        if(value.body['statusCode']!=Status.success){
          printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
          return Result.error(statusCode:value.body['statusCode']);
        }
        
        bool t=value.body['data'];
        return Result.success(data: t);
      }else{
        printError(info:"网络异常，不能连接服务器");
        return Result.error(statusCode: Status.netError);
      }
    }).onError((error, stackTrace){
      printError(info:"网络异常且未知错误:${error.toString()}");
      return Result.error(statusCode: Status.netError);
    }).timeout(const Duration(seconds: 3),onTimeout: (){
      return Result.error(statusCode: Status.netError);
    });
    return res;
  }
}