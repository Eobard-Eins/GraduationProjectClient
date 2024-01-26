import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginWithPasswordPageController extends GetxController {
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  Rx<String> phoneControllerText= "".obs;
  Rx<String> passwordControllerText= "".obs;

  Rx<bool> obscure=true.obs;

  void init(){
    phoneController.clear(); passwordController.clear();
    passwordControllerText.value="";
    phoneControllerText.value="";
    obscure.value=true;
  }

  //改变是否隐藏密码
  void changeObscure(){
    obscure.value=!obscure.value;
  }
  
  //判断是否可用登录按钮
  Function()? canLogin(){
    return phoneControllerText.value.isNotEmpty&&passwordControllerText.value.isNotEmpty?onTapLogin:null;
  }

  void forgetPassword(){
    printInfo(info: "跳转忘记密码页");
    Get.toNamed(RouteConfig.verifyPhonePage,arguments: {'newUser':false});
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLoginByCaptcha() {
    printInfo(info: "跳转验证码登录页");
    Get.offNamed(RouteConfig.loginWithCaptchaPage);
    //Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithCaptchaPage);
  }

  void onTapRegister() {
    printInfo(info: "跳转注册页");
    Get.toNamed(RouteConfig.verifyPhonePage,arguments: {'newUser':true});
    //Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin(){
    printInfo(info: "登录按钮触发");

    UserNetService().loginWithPassword(phoneControllerText.value,passwordControllerText.value).then((value) {
      switch (value.statusCode){
        case Status.phoneFormatError:
          printInfo(info: "手机号格式不匹配,code:${value.statusCode}");
          Get.snackbar("登录失败", "请输入正确的手机号",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          passwordController.text=passwordControllerText.value="";//密码框清空
          break;
        
        case Status.netError:
          printInfo(info: "网络错误,code:${value.statusCode}");
          Get.snackbar("登录失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          passwordController.text=passwordControllerText.value="";//密码框清空
          break;

        case Status.userNotExist:
          printInfo(info: "账号不存在,code:${value.statusCode}");
          Get.snackbar("登录失败", "账号不存在，请确保输入的手机号正确",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          passwordController.text=passwordControllerText.value="";//密码框清空
          break;

        case Status.passwordError:
          printInfo(info: "密码错误,code:${value.statusCode}");
          Get.snackbar("登录失败", "请输入正确的密码",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          passwordController.text=passwordControllerText.value="";//密码框清空
          break;
        
        case Status.success:
          printInfo(info: "登录成功,code:${value.statusCode},User:${value.data}");
          //TODO: 前往首页
          Get.offAllNamed(RouteConfig.homePage);
          break;

        default:
          printInfo(info: "未知错误,code:${value.statusCode}");
          Get.snackbar("登录失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          init();

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