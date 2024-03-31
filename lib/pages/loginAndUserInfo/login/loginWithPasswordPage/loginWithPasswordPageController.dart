
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/utils/user/userLoginUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class LoginWithPasswordPageController extends GetxController {
  Rx<TextEditingController> mailController=TextEditingController().obs;
  Rx<TextEditingController> passwordController=TextEditingController().obs;

  Rx<bool> obscure=true.obs;

  @override
  void onInit(){
    super.onInit();
    mailController.value.clear(); passwordController.value.clear();
    mailController.refresh(); passwordController.refresh();
    obscure.value=true;
  }

  //改变是否隐藏密码
  void changeObscure()=>obscure.value=!obscure.value;
  
  //判断是否可用登录按钮
  Function()? canLogin()=>mailController.value.text.isNotEmpty&&passwordController.value.text.isNotEmpty?onTapLogin:null;

  void gotoForgetPassword()=>Get.toNamed(RouteConfig.verifyEmailPage,arguments: {'canGotoWhenUserExist':T,'canGotoWhenUserNotExist':F});

  void gotoLoginByCaptcha()=>Get.offNamed(RouteConfig.loginWithCaptchaPage);
  
  void gotoRegister()=>Get.toNamed(RouteConfig.verifyEmailPage,arguments: {'canGotoWhenUserExist':F,'canGotoWhenUserNotExist':T});

  void onTapLogin(){
    printInfo(info: "登录按钮触发");
    UserLoginUtils.loginWithPassword(
      mailController:mailController,
      passwordController:passwordController,
      onSuccess:()=>Get.offAllNamed(RouteConfig.homePage)
    );
    
  }

  void gotoAgreement()=>Get.toNamed(RouteConfig.agreementInfoPage);

}