import 'dart:async';

import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  TextEditingController mailController=TextEditingController();
  TextEditingController captchaController=TextEditingController();

  Rx<String> mailControllerText= "".obs;
  Rx<String> captchaControllerText= "".obs;

  Rx<bool> checkAgreement = false.obs;
  Rx<bool> hasGetCaptcha = false.obs;

  Rx<String> captchaHintText= "获取验证码".obs;

  @override
  void onInit(){
    super.onInit();
    mailController.clear(); captchaController.clear();
    mailControllerText.value="";
    captchaControllerText.value="";
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
    return checkAgreement.value&&mailControllerText.value.isNotEmpty&&captchaControllerText.value.length>=6?onTapLogin:null;
  }

  //发送验证码
  void onTapCaptcha() {
    printInfo(info: "验证码发送按钮触发");
    int initSec=60;

    hasGetCaptcha.value=true;
    captchaHintText.value="已获取($initSec)";
    timeDown(initSec);

    printInfo(info: "发送验证码");
    UserNetService().sendCaptcha(mailControllerText.value).then((value){
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

  void onTapLoginByPassword() {
    printInfo(info: "跳转密码登录页");
    Get.offNamed(RouteConfig.loginWithPasswordPage);
    //Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithPasswordPage);
  }

  void onTapRegister() {
    printInfo(info: "跳转注册的验证手机号页");
    Get.toNamed(RouteConfig.verifyPhonePage);//,arguments: {'newUser':true});
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin() {
    printInfo(info: "登录事件按钮触发");

    UserNetService().loginWithCaptcha(mailControllerText.value,captchaControllerText.value).then((value){
      switch (value.statusCode){
        case Status.mailFormatError:
          snackbar.error("验证失败", "请输入正确的邮箱", value.statusCode);
          captchaController.text=captchaControllerText.value="";//验证码框清空
          break;
        
        case Status.netError:
          snackbar.error("验证失败", "请检查网络设置", value.statusCode);
          captchaController.text=captchaControllerText.value="";//验证码框清空
          break;
        
        case Status.captchaError:
          snackbar.error("验证失败", "请输入正确的验证码", value.statusCode);
          captchaController.text=captchaControllerText.value="";//验证码框清空
          break;

        case Status.captchaExpiration:
          snackbar.error("验证码超时", "请重新发送验证码", value.statusCode);
          captchaController.text=captchaControllerText.value="";//验证码框清空
          break;

        case Status.successButUserNotExist:
          printInfo(info: "跳转设置密码页,code:${value.statusCode}");
          //TODO: 跳转设置密码页
          Get.toNamed(RouteConfig.setPasswordPage,arguments:{'needSetInfo':true,'account':mailControllerText.value});
          break;
        
        case Status.success:
          printInfo(info: "登录成功,code:${value.statusCode}");
          //TODO: 前往首页
          Get.offAllNamed(RouteConfig.homePage);
          break;
        
        default:
          snackbar.error("验证失败", "请检查网络设置", value.statusCode, exception:true);
          onInit();
          break;
      }
    });
  }

  void onTapAgreement() {
    printInfo(info: "跳转协议页");
    Get.toNamed(RouteConfig.agreementInfoPage);
    //Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }

}