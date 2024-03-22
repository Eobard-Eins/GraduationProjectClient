import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/services/UserNetService.dart';
import 'package:client_application/services/utils/userNetUtils.dart';
import 'package:client_application/utils/res/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  void changeObscure(){
    obscure.value=!obscure.value;
  }
  
  //判断是否可用登录按钮
  Function()? canLogin(){
    return mailController.value.text.isNotEmpty&&passwordController.value.text.isNotEmpty?onTapLogin:null;
  }

  void forgetPassword(){
    printInfo(info: "跳转忘记密码页");
    Get.toNamed(RouteConfig.verifyEmailPage,arguments: {'newUser':false});
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLoginByCaptcha() {
    printInfo(info: "跳转验证码登录页");
    Get.offNamed(RouteConfig.loginWithCaptchaPage);
    //Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithCaptchaPage);
  }

  void onTapRegister() {
    printInfo(info: "跳转注册页");
    Get.toNamed(RouteConfig.verifyEmailPage);//,arguments: {'newUser':true});
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin(){
    printInfo(info: "登录按钮触发");
    UserNetUtils.loginWithPassword(mailController,passwordController,(){
      //TODO: 前往首页
      Get.offAllNamed(RouteConfig.homePage);
    });
    UserNetService().loginWithPassword(mailController.value.text,passwordController.value.text).then((value) {
      switch (value.statusCode){
        case Status.mailFormatError:
          snackbar.error("登录失败", "请输入正确的邮箱", value.statusCode);
          passwordController.value.clear();//密码框清空
          passwordController.refresh();
          break;
        
        case Status.netError:
          snackbar.error("登录失败", "请检查网络设置", value.statusCode);
          passwordController.value.clear();//密码框清空
          passwordController.refresh();
          break;

        case Status.userNotExist:
          snackbar.error("登录失败", "账号不存在，请确保输入的邮箱正确", value.statusCode);
          passwordController.value.clear();//密码框清空
          passwordController.refresh();
          break;

        case Status.passwordError:
          snackbar.error("登录失败", "请输入正确的密码", value.statusCode);
          passwordController.value.clear();//密码框清空
          passwordController.refresh();
          break;
        
        case Status.success:
          printInfo(info: "登录成功,code:${value.statusCode},User:${value.data}");
          //TODO: 前往首页
          Get.offAllNamed(RouteConfig.homePage);
          break;

        default:
          snackbar.error("登录失败", "请检查网络设置", value.statusCode, exception: true);
          onInit();
          break;
      }
    });    
  }

  void onTapAgreement(){
    printInfo(info: "跳转协议页");
    Get.toNamed(RouteConfig.agreementInfoPage);
    //Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }
}