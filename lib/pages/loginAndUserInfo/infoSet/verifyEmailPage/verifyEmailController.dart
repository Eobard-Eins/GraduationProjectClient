import 'dart:async';

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/utils/user/userLoginUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifymailController extends GetxController{
  Rx<TextEditingController> mailController=TextEditingController().obs;
  Rx<TextEditingController> captchaController=TextEditingController().obs;

  Rx<bool> checkAgreement = false.obs;

  Rx<bool> hasGetCaptcha = false.obs;
  Rx<String> captchaHintText= "获取验证码".obs;

  @override
  void onInit(){
    super.onInit();
    printInfo(info: "验证页信息初始化");
    mailController.value.clear();
    captchaController.value.clear();
    mailController.refresh();
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
    return checkAgreement.value&&mailController.value.text.isNotEmpty&&captchaController.value.text.isNotEmpty?onTapNext:null;
  }

  void onTapCaptcha() {
    printInfo(info: "验证码发送按钮触发");
    int initSec=60;

    hasGetCaptcha.value=true;
    captchaHintText.value="已获取($initSec)";
    timeDown(initSec);

    printInfo(info: "发送验证码");
    UserLoginUtils.sendCaptcha(mailController:mailController,onSuccess: ()=>printInfo(info: "验证码发送成功"));
  }

  void onTapNext() {
    printInfo(info: "跳转设置密码页");
    //print(Get.arguments);
    //bool newUser=Get.arguments["newUser"] as bool;
    UserLoginUtils.loginWithCaptcha(
      mailController: mailController,
      captchaController: captchaController,
      onSuccess: () {
        printInfo(info: "跳转设置密码页");
        //TODO: 跳转设置密码页
        Get.offNamed(RouteConfig.setPasswordPage,arguments:{'needSetInfo':true,'account':mailController.value.text});
      },
      onSuccessButUserNotExist: () {
        printInfo(info: "跳转设置密码页");
        //TODO: 跳转设置密码页
        Get.offNamed(RouteConfig.setPasswordPage,arguments:{'needSetInfo':false,'account':mailController.value.text});
      },
    );
  }

  void onTapAgreement() {
    printInfo(info: "跳转协议页");
    Get.toNamed(RouteConfig.agreementInfoPage);
  }
}