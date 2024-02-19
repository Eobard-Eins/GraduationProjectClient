import 'dart:async';

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPhoneController extends GetxController{
  Rx<TextEditingController> phoneController=TextEditingController().obs;
  Rx<TextEditingController> captchaController=TextEditingController().obs;

  Rx<bool> checkAgreement = false.obs;

  Rx<bool> hasGetCaptcha = false.obs;
  Rx<String> captchaHintText= "获取验证码".obs;

  @override
  void onInit(){
    super.onInit();
    printInfo(info: "验证页信息初始化");
    phoneController.value.clear();
    captchaController.value.clear();
    phoneController.refresh();
    captchaController.refresh();
    checkAgreement.value=false;
    hasGetCaptcha.value = false;
    captchaHintText.value= "获取验证码";
  }

  void timeDown(int init) async{
    int countdown = init;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      
      captchaHintText.value="已获取($countdown)";
      
      if (countdown == 0) {
        hasGetCaptcha.value=false;
        timer.cancel();
      }
    });
  }

  //改变协议框勾选状态
  void changeAgreement(bool? value){
    checkAgreement.value = !checkAgreement.value;
  }

  Function()? canNext(){
    return checkAgreement.value&&phoneController.value.text.isNotEmpty&&captchaController.value.text.isNotEmpty?onTapNext:null;
  }

  void onTapCaptcha() {
    printInfo(info: "验证码发送按钮触发");
    int initSec=60;

    hasGetCaptcha.value=true;
    captchaHintText.value="已获取($initSec)";
    timeDown(initSec);

    //TODO: 
    printInfo(info: "发送验证码");
    UserNetService().sendCaptcha(phoneController.value.text).then((value){
      switch (value.statusCode){
        case Status.phoneFormatError:
          printInfo(info: "手机号格式不匹配,code:${value.statusCode}");
          Get.snackbar("获取验证码失败", "请输入正确的手机号",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          break;

        case Status.netError:
          printInfo(info: "网络错误,code:${value.statusCode}");
          Get.snackbar("获取验证码失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          break;

        case Status.success:
          printInfo(info: "验证码发送成功:${value.data},code:${value.statusCode}");
          break;

        default:
          printInfo(info: "未知错误,code:${value.statusCode}");
          Get.snackbar("获取验证码失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          break;
      }
    });
  }

  void onTapNext() {
    printInfo(info: "跳转设置密码页");
    //print(Get.arguments);
    bool newUser=Get.arguments["newUser"] as bool;
    if(newUser){
      UserNetService().loginWithCaptchaByUserNotExist(phoneController.value.text,captchaController.value.text).then((value){
        switch (value.statusCode){
          case Status.phoneFormatError:
            printInfo(info: "手机号格式不匹配,code:${value.statusCode}");
            Get.snackbar("验证失败", "请输入正确的手机号",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            captchaController.value.clear();//验证码框清空
            captchaController.refresh();
            break;
          
          case Status.netError:
            printInfo(info: "网络错误,code:${value.statusCode}");
            Get.snackbar("验证失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            captchaController.value.clear();//验证码框清空
            captchaController.refresh();
            break;

          case Status.userExist://用户存在
            printInfo(info: "用户已存在,code:${value.statusCode}");
            Get.snackbar("验证失败", "账号已存在",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            onInit();
            break;
          
          case Status.captchaError:
            printInfo(info: "验证码错误,code:${value.statusCode}");
            Get.snackbar("验证失败", "请输入正确的验证码",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            captchaController.value.clear();//验证码框清空
            captchaController.refresh();
            break;  
          
          case Status.success:
            printInfo(info: "跳转设置密码页,非新用户,code:${value.statusCode}");
            //TODO: 跳转设置密码页
            Get.offNamed(RouteConfig.setPasswordPage,arguments:{'needSetInfo':true,'account':phoneController.value.text});
            break;
          
          default:
            printInfo(info: "未知错误,code:${value.statusCode}");
            Get.snackbar("验证失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            onInit();
            break;
        }
      });
    }
    else{
      UserNetService().loginWithCaptchaByUserExist(phoneController.value.text,captchaController.value.text).then((value){
        switch (value.statusCode){
          case Status.phoneFormatError:
            printInfo(info: "手机号格式不匹配,code:${value.statusCode}");
            Get.snackbar("验证失败", "请输入正确的手机号",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            captchaController.value.clear();//验证码框清空
            captchaController.refresh();
            break;
          
          case Status.netError:
            printInfo(info: "网络错误,code:${value.statusCode}");
            Get.snackbar("验证失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            captchaController.value.clear();//验证码框清空
            captchaController.refresh();
            break;

          case Status.userNotExist://用户不存在
            printInfo(info: "用户不存在,code:${value.statusCode}");
            Get.snackbar("验证失败", "账号不存在",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            onInit();
            break;
          
          case Status.captchaError:
            printInfo(info: "验证码错误,code:${value.statusCode}");
            Get.snackbar("验证失败", "请输入正确的验证码",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            captchaController.value.clear();//验证码框清空
            captchaController.refresh();
            break;  
          
          case Status.success:
            printInfo(info: "跳转设置密码页,非新用户,code:${value.statusCode}");
            //TODO: 跳转设置密码页
            Get.offNamed(RouteConfig.setPasswordPage,arguments:{'needSetInfo':false,'account':phoneController.value.text});
            break;
          
          default:
            printInfo(info: "未知错误,code:${value.statusCode}");
            Get.snackbar("验证失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
            onInit();
            break;
        }
      });
    }
    

    // bool needSetInfo=Get.arguments["needSetInfo"] as bool??false;
    // Get.offNamed(RouteConfig.setPasswordPage,arguments: {"needSetInfo":needSetInfo});
    //Navigator.of(context).pushReplacementNamed(RouteConfig.setPasswordPage);
  }

  void onTapAgreement() {
    printInfo(info: "跳转协议页");
    Get.toNamed(RouteConfig.agreementInfoPage);
    //Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }
}