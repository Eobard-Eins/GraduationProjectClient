
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPasswordController extends GetxController{

  Rx<TextEditingController> passwordController=TextEditingController().obs;
  Rx<TextEditingController> passwordAgainController=TextEditingController().obs;

  Rx<bool> obscure = true.obs;

  void init(){
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
          printInfo(info: "密码不一致错误,code:${value.statusCode}");
          Get.snackbar("设置失败", "请确保两次密码一致",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          init();
          break;

        case Status.passwordFormatError:
          printInfo(info: "密码格式错误,code:${value.statusCode}");
          Get.snackbar("设置失败", "请检查密码格式",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          init();
          break;

        case Status.netError:
          printInfo(info: "网络错误,code:${value.statusCode}");
          Get.snackbar("设置失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          init();
          break;

        case Status.setPasswordError:
          printInfo(info: "未知错误,code:${value.statusCode}");
          Get.snackbar("设置失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          init();
          break;

        case Status.success:
          if(needSetInfo){
            Get.offNamed(RouteConfig.setNameAndAvatarPage);
          }else{
            Get.back();
          }
          break;

        default:
          printInfo(info: "未知错误,code:${value.statusCode}");
          Get.snackbar("设置失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          init();
          break;
      }
    });
    //Navigator.of(context).pushReplacementNamed(RouteConfig.setNameAndAvatarPage);
  }
}