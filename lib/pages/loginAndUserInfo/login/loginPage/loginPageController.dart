import 'dart:async';

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/utils/user/userLoginUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  Rx<TextEditingController> mailController=TextEditingController().obs;
  Rx<TextEditingController> captchaController=TextEditingController().obs;

  Rx<bool> checkAgreement = false.obs;
  Rx<bool> hasGetCaptcha = false.obs;

  Rx<String> captchaHintText= "获取验证码".obs;

  @override
  void onInit(){
    super.onInit();
    mailController.value.clear(); captchaController.value.clear();
    mailController.refresh(); captchaController.refresh();
    checkAgreement.value=false;
    hasGetCaptcha.value=false;
    captchaHintText.value="获取验证码";
  }

  //倒计时
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

  //判断是否可以使用登录按钮
  Function()? canLogin(){
    return checkAgreement.value&&mailController.value.text.isNotEmpty&&captchaController.value.text.length>=6?onTapLogin:null;
  }

  //发送验证码
  void onTapCaptcha() {
    printInfo(info: "验证码发送按钮触发");
    int initSec=60;

    hasGetCaptcha.value=true;
    captchaHintText.value="已获取($initSec)";
    timeDown(initSec);

    printInfo(info: "发送验证码");
    UserLoginUtils.sendCaptcha(mailController:mailController, onSuccess: () => printInfo(info: "验证码发送成功"));
  }

  void onTapLoginByPassword() {
    printInfo(info: "跳转密码登录页");
    Get.offNamed(RouteConfig.loginWithPasswordPage);
    //Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithPasswordPage);
  }

  void onTapRegister() {
    printInfo(info: "跳转注册的验证手机号页");
    Get.toNamed(RouteConfig.verifyEmailPage);//,arguments: {'newUser':true});
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin() {
    printInfo(info: "登录事件按钮触发");
    UserLoginUtils.loginWithCaptcha(mailController:mailController, captchaController:captchaController, onSuccess:(){
      printInfo(info: "登录成功");
      //TODO: 前往首页
      Get.offAllNamed(RouteConfig.homePage);
    },onSuccessButUserNotExist:(){
      printInfo(info: "跳转设置密码页");
      //TODO: 跳转设置密码页
      Get.toNamed(RouteConfig.setPasswordPage,arguments:{'needSetInfo':true,'account':mailController.value.text});
    });
  }

  void onTapAgreement() {
    printInfo(info: "跳转协议页");
    Get.toNamed(RouteConfig.agreementInfoPage);
    //Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }

}