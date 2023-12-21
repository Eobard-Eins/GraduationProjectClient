import 'dart:async';

import 'package:client_application/config/RouteConfig.dart';
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
    print("getCaptcha");
    int initSec=60;

    hasGetCaptcha.value=true;
    captchaHintText.value="已获取($initSec)";
    timeDown(initSec);
    
    print("done");
  }

  void onTapLoginByPassword() {
    print("login by password");
    Get.offNamed(RouteConfig.loginWithPasswordPage);
    //Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithPasswordPage);
  }

  void onTapRegister() {
    print("register");
    Get.toNamed(RouteConfig.verifyPhonePage);
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin() {
    //print(_phoneController.text);
  }

  void onTapAgreement() {
    print("trunToAgreement");
    Get.toNamed(RouteConfig.agreementInfoPage);
    //Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }

}