import 'package:client_application/config/RouteConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginWithPasswordPageController extends GetxController {
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  Rx<String> phoneControllerText= "".obs;
  Rx<String> passwordControllerText= "".obs;

  Rx<bool> obscure=true.obs;

  void changeObscure(){
    obscure.value=!obscure.value;
  }
  
  void forgetPassword(){
    print("forget password");
    Get.toNamed(RouteConfig.verifyPhonePage);
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLoginByCaptcha() {
    print("login by password");
    Get.offNamed(RouteConfig.loginWithCaptchaPage);
    //Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithCaptchaPage);
  }

  void onTapRegister() {
    print("register");
    Get.toNamed(RouteConfig.verifyPhonePage);
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin(){
    print("login");
  }

  void onTapAgreement(){
    print("trunToAgreement");
    Get.toNamed(RouteConfig.agreementInfoPage);
    //Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }
}