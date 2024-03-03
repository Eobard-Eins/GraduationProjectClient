
import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:client_application/utils/status.dart';
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

  Function()? canNext(){
    return (passwordController.value.text.isEmpty ||
                    passwordAgainController.value.text.isEmpty)
                ? null
                : onTapNext;
  }

  void onTapNext() {
    printInfo(info:"点击下一步");
    bool needSetInfo=Get.arguments["needSetInfo"] as bool;
    String account=Get.arguments["account"] as String;
    UserNetService().setPassword(account,passwordController.value.text, passwordAgainController.value.text).then((value){
      switch(value.statusCode){
        case Status.passwordInconsistent:
          snackbar.error("设置失败", "请确保两次密码一致", value.statusCode);
          onInit();
          break;

        case Status.passwordFormatError:
          snackbar.error("设置失败", "请检查密码格式", value.statusCode);
          onInit();
          break;

        case Status.netError||Status.setPasswordError:
          snackbar.error("设置失败", "请检查网络设置", value.statusCode);
          onInit();
          break;

        case Status.infoMiss:
          snackbar.error("设置失败", "请检查输入是否正确", value.statusCode);
          onInit();
          break;

        case Status.success:
          if(value.data==true){
            SpUtils.setBool("isLogin", true);
            SpUtils.setInt("lastLoginTime",DateTime.now().millisecondsSinceEpoch);
            SpUtils.setString("account", account);
            needSetInfo?
              Get.offNamed(RouteConfig.setNameAndAvatarPage,arguments: {'needSetInfo':true,'account':account}):
              Get.back();
          }else{
            snackbar.error("设置失败", "请稍后重试", value.statusCode);
          }
          break;

        default:
          snackbar.error("设置失败", "请检查网络设置", value.statusCode, exception: true);
          onInit();
          break;
      }
    });
    //Navigator.of(context).pushReplacementNamed(RouteConfig.setNameAndAvatarPage);
  }
}