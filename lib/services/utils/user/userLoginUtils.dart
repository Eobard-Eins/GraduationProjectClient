import 'package:client_application/components/display/uploadingDialog.dart';
import 'package:client_application/models/User.dart';
import 'package:client_application/services/connect/UserNetService.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_application/components/display/snackbar.dart';
class UserLoginUtils extends GetConnect{


  static loginWithPassword({
    required String mail,
    required String password,
    required Function() onSuccess,
    required Function() onError,
  }){
    UploadingDialog.show();
    UserNetService().loginWithPassword(mail,password).then((value) {
      UploadingDialog.hide();
      if(value.isError()){
        onError();
        snackbar.error("登录失败", value.message!, value.statusCode);
      }else{
        User u=User.fromJson(value.data);
        /*本地缓存*/ 
        SpUtils.setBool("isLogin", true);
        SpUtils.setInt("lastLoginTime",DateTime.now().millisecondsSinceEpoch);
        SpUtils.setString("account", u.mailAddress);
        // SpUtils.setString("username", u.username??"用户${u.mailAddress.split('@')[0]}");
        // SpUtils.setString("gender", u.gender??"未知");
        // SpUtils.setString("avatar", u.avatar);//存头像的网络url
        // SpUtils.setDouble("point", u.point);
        onSuccess();
      }
    });    
  }

  static sendCaptcha({required Rx<TextEditingController> mailController,required Function() onSuccess}){
    UserNetService().sendCaptcha(mailController.value.text).then((value){
      if(value.isError()){
        snackbar.error("获取验证码失败", value.message!, value.statusCode);
      }else{
        onSuccess();
      }
    });
  }

  static loginWithCaptcha({
    required String mail,
    required String captcha,
    required Function() onSuccess,
    required Function() onSuccessButUserNotExist,
    required Function() onError,
  }){
    UploadingDialog.show();
    UserNetService().loginWithCaptcha(mail,captcha).then((value){
      UploadingDialog.hide();
      if(value.isError()){
        onError();
        snackbar.error("验证失败", value.message!, value.statusCode);
      }else{
        if(value.statusCode==Status.successButUserNotExist){
          SpUtils.setBool("isLogin", false);
          onSuccessButUserNotExist();

        }else if(value.statusCode==Status.success){
          User u=User.fromJson(value.data);
          /*本地缓存*/ 
          SpUtils.setBool("isLogin", true);
          SpUtils.setInt("lastLoginTime",DateTime.now().millisecondsSinceEpoch);
          SpUtils.setString("account", u.mailAddress);
          // SpUtils.setString("username", u.username??"用户${u.mailAddress.split('@')[0]}");
          // SpUtils.setString("gender", u.gender??"未知");
          // SpUtils.setString("avatar", u.avatar);//存头像的网络url
          // SpUtils.setDouble("point", u.point);
          onSuccess();
        }
      }
    });
  }
}