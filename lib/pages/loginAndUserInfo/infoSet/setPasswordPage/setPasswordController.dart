
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/utils/user/userInfoUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPasswordController extends GetxController{

  Rx<TextEditingController> passwordController=TextEditingController().obs;
  Rx<TextEditingController> passwordAgainController=TextEditingController().obs;

  Rx<bool> obscure = true.obs;

  @override
  void onInit(){
    super.onInit();
    passwordController.value.clear();
    passwordAgainController.value.clear();
    passwordController.refresh();
    passwordAgainController.refresh();
    obscure.value=true;
  }

  Function()? canNext()=>(passwordController.value.text.isEmpty ||
                    passwordAgainController.value.text.isEmpty)
                ? null
                : onTapNext;

  void onTapNext() {
    printInfo(info:"点击下一步");
    bool needSetInfo=Get.arguments["needSetInfo"] as bool;
    String account=Get.arguments["account"] as String;
    UserInfoUtils.setPassword(
      password: passwordController.value.text,
      passwordAgain: passwordAgainController.value.text,
      account: account,
      onSuccess: () {
        SpUtils.setBool("isLogin", true);
        SpUtils.setInt("lastLoginTime",DateTime.now().millisecondsSinceEpoch);
        SpUtils.setString("account", account);
        needSetInfo?
          Get.offNamed(RouteConfig.setNameAndAvatarPage,arguments: {'needSetInfo':true,'account':account}):
          Get.back();
      },
      onError: (){
        passwordController.value.clear();
        passwordAgainController.value.clear();
        passwordController.refresh();
        passwordAgainController.refresh();
      }
    );
    
    //Navigator.of(context).pushReplacementNamed(RouteConfig.setNameAndAvatarPage);
  }
}