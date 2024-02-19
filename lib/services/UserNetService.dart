

import 'dart:async';

import 'package:client_application/services/Dio.dart';
import 'package:client_application/models/User.dart';
import 'package:client_application/utils/discriminator.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:client_application/utils/result.dart';
import 'package:client_application/utils/staticValue.dart';
import 'package:client_application/utils/status.dart';
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


  Future TimeTestModel(int init)async{//模拟网络请求延时
    //模拟延时
    return Future.delayed(Duration(seconds: init),(){
      return 'Net delay test';
    });
  }

  Future<Result> loginWithPassword(String account, String password) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.phoneFormatError);
    }
    //TODO:
    final Result res=await get("$_baseUrl/userLogin/loginWithPassword",query:{"phone":account,"password":password}).then((value){
      //value.printInfo();
      //printError(info:value.body.toString());
      if(value.isOk){
        printInfo(info:"网络正常,${value.body.toString()}");
        if(value.body['statusCode']!=Status.success){
          printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
          return Result.error(statusCode:value.body['statusCode']);
        }
        
        User u=User.fromJson(value.body['data']);
        printInfo(info:"解析User：${u.phone}");
        /*本地缓存*/ 
        SpUtils.setBool("isLogin", true);
        SpUtils.setInt("lastLoginTime",DateTime.now().millisecondsSinceEpoch);
        SpUtils.setString("account", u.phone);
        SpUtils.setString("username", u.username??"用户${u.phone}");
        SpUtils.setString("gender", u.gender??"未知");
        SpUtils.setDouble("longitude", u.longitude??116.397128);
        SpUtils.setDouble("latitude", u.latitude??39.916527);
        SpUtils.setString("avatar", u.avatar);//存头像的网络url
        SpUtils.setDouble("point", u.point);
        return Result.success(data: u);
      }else{
        printInfo(info:"网络异常，不能连接服务器");
        return Result.error(statusCode: Status.netError);
      }
      
    }).onError((error, stackTrace){
      printInfo(info:"网络异常且未知错误");
      return Result.error(statusCode: Status.netError);
    });
    return res;
  }

  //综合已有账号和新账号的验证，前端接口分三种api
  Future<Result> loginWithCaptcha(String account,String captcha) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.phoneFormatError);
    }
    //TODO:
    await TimeTestModel(3);


    return Result.success(data: true);
  }

  //用于已有账号的验证码验证
  Future<Result> loginWithCaptchaByUserExist(String account,String captcha) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.phoneFormatError);
    }
    //TODO:
    await TimeTestModel(3);


    return Result.success(data: true);
  }

  //用于新账号的验证码验证
  Future<Result> loginWithCaptchaByUserNotExist(String account,String captcha) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.phoneFormatError);
    }
    //TODO:
    await TimeTestModel(3);


    return Result.success(data: true);
  }
  

  Future<Result> sendCaptcha(String account) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(statusCode:Status.phoneFormatError);
    }
    //TODO:
    await TimeTestModel(3);


    return Result.success(data: true);
  }
  
  Future<Result> setPassword(String account,String password,String passwordAgain) async{
    if(password!=passwordAgain){
      return Result.error(statusCode:Status.passwordInconsistent);
    }
    if(!Discriminator.passwordOk(password)){
      return Result.error(statusCode:Status.phoneFormatError);
    }
    printInfo(info:'开始设置密码:{"phone":"$account","password":"$password"}');
    final Result res=await put("$_baseUrl/userInfo/setPassword", '{"phone":"$account","password":"$password"}').then((value){
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
    final Result res=await put("$_baseUrl/userInfo/setName", '{"phone":"$account","username":"$username"}').then((value){
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
    });
    return res;
  }
}