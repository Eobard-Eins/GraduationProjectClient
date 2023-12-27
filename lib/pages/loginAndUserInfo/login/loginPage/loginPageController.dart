import 'dart:async';

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/discriminator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  TextEditingController phoneController=TextEditingController();
  TextEditingController captchaController=TextEditingController();

  Rx<String> phoneControllerText= "".obs;
  Rx<String> captchaControllerText= "".obs;

  Rx<bool> checkAgreement = false.obs;
  Rx<bool> hasGetCaptcha = false.obs;

  Rx<String> captchaHintText= "获取验证码".obs;

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

  void onTapCaptcha() {
    printInfo(info: "验证码发送按钮触发");
    int initSec=60;

    hasGetCaptcha.value=true;
    captchaHintText.value="已获取($initSec)";
    timeDown(initSec);

    //发送验证码
    if(!Discriminator.accountOk(phoneControllerText.value)){
      printInfo(info: "手机号格式不匹配");
      Get.snackbar("登录失败", "请输入正确的手机号",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
    }else{
      printInfo(info: "发送验证码");
      UserNetService().sendCaptcha();
    }
  }

  void onTapLoginByPassword() {
    printInfo(info: "跳转密码登录页");
    Get.offNamed(RouteConfig.loginWithPasswordPage);
    //Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithPasswordPage);
  }

  void onTapRegister() {
    printInfo(info: "跳转注册的验证手机号页");
    Get.toNamed(RouteConfig.verifyPhonePage);
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin() {
    printInfo(info: "登录事件按钮触发");

    if(!Discriminator.accountOk(phoneControllerText.value)){
      printInfo(info: "手机号格式不匹配");
      Get.snackbar("登录失败", "请输入正确的手机号",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
    }
    else if(!UserNetService().loginWithCaptcha(captchaControllerText.value)){//格式不对或验证码输入错误
      printInfo(info: "验证码错误");
      Get.snackbar("登录失败", "请输入正确的验证码",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
    }
    else{
      //是新用户
      if(UserNetService().isNewUser(phoneControllerText.value)){
        printInfo(info: "跳转设置密码页");
        Get.toNamed(RouteConfig.setPasswordPage);
      }else{
        printInfo(info: "跳转首页");
        //TODO: 
      }
    }
    //print(_phoneController.text);
  }

  void onTapAgreement() {
    printInfo(info: "跳转协议页");
    Get.toNamed(RouteConfig.agreementInfoPage);
    //Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }

}