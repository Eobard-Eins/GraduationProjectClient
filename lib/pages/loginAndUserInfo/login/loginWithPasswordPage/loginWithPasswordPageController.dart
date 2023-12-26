import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/discriminator.dart';
import 'package:client_application/utils/localStorage.dart';
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
    printInfo(info: "跳转忘记密码页");
    Get.toNamed(RouteConfig.verifyPhonePage);
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLoginByCaptcha() {
    printInfo(info: "跳转验证码登录页");
    Get.offNamed(RouteConfig.loginWithCaptchaPage);
    //Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithCaptchaPage);
  }

  void onTapRegister() {
    printInfo(info: "跳转注册页");
    Get.toNamed(RouteConfig.verifyPhonePage);
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin(){
    printInfo(info: "登录按钮触发");
    if(!Discriminator.accountOk(phoneControllerText.value)){
      printInfo(info: "手机号格式不匹配");
      Get.snackbar("登录失败", "请输入正确的手机号",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
    }
    else if(UserNetService.isNewUser(passwordControllerText.value)){
      printInfo(info: "账号不存在");
      Get.snackbar("登录失败", "账号不存在，请确保输入的手机号正确",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
    }
    else if(!UserNetService.verifyPassword(passwordControllerText.value)){//格式不对或验证码输入错误
      printInfo(info: "密码错误");
      Get.snackbar("登录失败", "请输入正确的密码",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
    }
    else{
      UserNetService.loginWithPasswordPage(phoneControllerText.value,passwordControllerText.value).then((value) {
        if(value==true){
          printInfo(info: "登录成功");
          //TODO: 前往首页
          Get.offAllNamed(RouteConfig.TESTPAGE);
        }else{
          printInfo(info: "登录失败");
          Get.snackbar("登录失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          passwordController.text=passwordControllerText.value="";
          phoneController.text=phoneControllerText.value="";
        }
      }); 
    }
  }

  void onTapAgreement(){
    printInfo(info: "跳转协议页");
    Get.toNamed(RouteConfig.agreementInfoPage);
    //Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }
}