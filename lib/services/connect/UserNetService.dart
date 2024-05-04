

import 'dart:async';
import 'dart:io';

import 'package:client_application/tool/input/discriminator.dart';
import 'package:client_application/tool/res/result.dart';
import 'package:client_application/res/staticValue.dart';
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
    return await network(() => get("$_baseUrl/userInfo/getInfo",query:{"mailAddress":account}));
  }
  Future<Result> getUserInfoByTaskId(int tid) async{
    return await network(() => get("$_baseUrl/userInfo/getInfoByTaskId",query:{"taskId":tid.toString()}));
  }

  Future<Result> loginWithPassword(String account, String password) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(message: "密码格式错误");
    }
    return await network(() => get("$_baseUrl/userLogin/loginWithPassword",query:{"mailAddress":account,"password":password}));
  }

  Future<Result> loginWithCaptcha(String account,String captcha) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(message:"邮箱格式错误");
    }
    return await network(() => get("$_baseUrl/userLogin/loginWithCaptcha",query:{"mailAddress":account,"captcha":captcha}));
  }

  Future<Result> sendCaptcha(String account) async{
    if(!Discriminator.accountOk(account)){
      return Result.error(message:"邮箱格式错误");
    }
    return await network(() => get("$_baseUrl/userLogin/sendCaptcha",query:{"mailAddress":account}));
  }
  
  Future<Result> setPassword(String account,String password,String passwordAgain) async{
    if(password!=passwordAgain){
      return Result.error(message: "两次输入的密码不一致");
    }
    if(!Discriminator.passwordOk(password)){
      return Result.error(message: "密码格式错误");
    }
    return await network(() => put("$_baseUrl/userInfo/setPassword", '{"mailAddress":"$account","password":"$password"}'));
  }

  Future<Result> setAvatar(String account,XFile? avatar) async{
    if(avatar==null) return Result.error(message: "设置失败:avatar is null");
    final formData = FormData({
      'file': MultipartFile(File(avatar.path), filename: File(avatar.path).path),
      'pn':account
    });
// Get.defaultDialog(title: "",content:Container(decoration: BoxDecoration(color: Coloors.greyLight,borderRadius: BorderRadius.circular(10)),padding: const EdgeInsets.all(30), width: 100, height: 100, child: const CircularProgressIndicator(color: Coloors.main,),),barrierDismissible: false,backgroundColor: Colors.transparent);
    return await network(() => post("$_baseUrl/userInfo/setAvatar", formData));
  }

  Future<Result> setUsername(String account,String username) async{
    if(!Discriminator.usernameOk(username)) return Result.error(message: "用户名格式错误");
    return await network(() => put("$_baseUrl/userInfo/setName", '{"mailAddress":"$account","username":"$username"}'));
  }
  Future<Result> network(Future<Response> Function() func)async{
    final Result res=await func().then((value){
      if(!value.isOk){
        printInfo(info:"网络异常，不能连接服务器");
        return Result.error(message: "网络出现错误，请检查网络设置:Net error");
      }else{
        bool isSuccess=value.body['isSuccess'];
        if(!isSuccess){
          printInfo(info:"网络正常，服务器返回错误：${value.body['message']}");
          return Result.error(message: value.body['message']);
        }      
        return Result.success(data: value.body['data'],statusCode: value.body['statusCode']);
      }
    }).onError((error, stackTrace){
      printInfo(info:"网络异常且未知错误  ${error.toString()}");
      return Result.error(message: "网络出现错误，请检查网络设置:Net error");
    }).timeout(const Duration(seconds: 15),onTimeout: (){
      return Result.error(message: "网络超时，请检查网络设置:Time out");
    });
    return res;
  }
}