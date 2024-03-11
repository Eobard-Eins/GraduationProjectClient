import 'dart:async';

import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/res/status.dart';
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
    UserNetService().sendCaptcha(mailController.value.text).then((value){
      switch (value.statusCode){
        case Status.mailFormatError:
          snackbar.error("获取验证码失败", "请输入正确的邮箱", value.statusCode);
          break;

        case Status.netError||Status.mailServiceError:
          snackbar.error("获取验证码失败", "请检查网络设置", value.statusCode);
          break;

        case Status.success:
          printInfo(info: "验证码发送成功:${value.data},code:${value.statusCode}");
          break;

        default:
          snackbar.error("获取验证码失败", "请检查网络设置", value.statusCode, exception: true);
          break;
      }
    });
  }

  void onTapNext() {
    printInfo(info: "跳转设置密码页");
    //print(Get.arguments);
    //bool newUser=Get.arguments["newUser"] as bool;
    UserNetService().loginWithCaptcha(mailController.value.text,captchaController.value.text).then((value){
      switch (value.statusCode){
        case Status.mailFormatError:
          snackbar.error("验证失败", "请输入正确的邮箱", value.statusCode);
          captchaController.value.clear();//验证码框清空
          captchaController.refresh();
          break;
        
        case Status.netError:
          snackbar.error("验证失败", "请检查网络设置", value.statusCode);
          captchaController.value.clear();//验证码框清空
          captchaController.refresh();
          break;
        
        case Status.captchaError:
          snackbar.error("验证失败", "请输入正确的验证码", value.statusCode);
          captchaController.value.clear();//验证码框清空
          captchaController.refresh();
          break;  

        case Status.captchaExpiration:
          snackbar.error("验证码超时", "请重新发送验证码", value.statusCode);
          captchaController.value.clear();//验证码框清空
          captchaController.refresh();
          break;
        
        case Status.successButUserNotExist||Status.success:
          printInfo(info: "跳转设置密码页,code:${value.statusCode}");
          //TODO: 跳转设置密码页
          Get.offNamed(RouteConfig.setPasswordPage,arguments:{'needSetInfo':value.statusCode!=Status.success,'account':mailController.value.text});
          break;
        
        default:
          snackbar.error("验证失败", "请检查网络设置", value.statusCode,exception: true);
          onInit();
          break;
      }
    });
  }

  void onTapAgreement() {
    printInfo(info: "跳转协议页");
    Get.toNamed(RouteConfig.agreementInfoPage);
  }
}