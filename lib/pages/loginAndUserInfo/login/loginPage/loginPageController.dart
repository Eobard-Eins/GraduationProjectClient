import 'dart:async';

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/utils/user/userLoginUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
  void changeAgreement(bool? value)=>checkAgreement.value = !checkAgreement.value;

  //判断是否可以使用登录按钮
  Function()? canLogin()=>checkAgreement.value&&mailController.value.text.isNotEmpty&&captchaController.value.text.length>=6?onTapLogin:null;

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

  void gotoLoginByPassword()=>Get.offNamed(RouteConfig.loginWithPasswordPage);

  void gotoRegister()=>Get.toNamed(RouteConfig.verifyEmailPage,arguments: {'canGotoWhenUserExist':F,'canGotoWhenUserNotExist':T});

  void onTapLogin() {
    printInfo(info: "登录事件按钮触发");
    UserLoginUtils.loginWithCaptcha(mail:mailController.value.text, captcha:captchaController.value.text, onSuccess:(){
      Get.offAllNamed(RouteConfig.homePage);
    },onSuccessButUserNotExist:(){
      //跳转设置密码页
      Get.toNamed(RouteConfig.setPasswordPage,arguments:{'needSetInfo':true,'account':mailController.value.text});
    },onError: (){
      captchaController.value.clear();//验证码框清空
      captchaController.refresh();
    });
  }

  void gotoAgreement()=>Get.toNamed(RouteConfig.agreementInfoPage);

}