import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/components/img/imgFromLocal.dart';
import 'package:client_application/components/img/imgPicker.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/pages/home/me/mePageController.dart';
import 'package:client_application/services/connect/UserNetService.dart';
import 'package:client_application/services/utils/user/userInfoUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class SettingPageController extends GetxController{
  Rx<XFile?> imgPath=Rx(null);
  Rx<TextEditingController> usernameController=TextEditingController().obs;

  @override
  void onInit() {
    imgPath=Rx(null);
    usernameController.value.clear();
    usernameController.refresh();
    super.onInit();
  }

  void setUsername(){
    if(usernameController.value.text.isNotEmpty){
      Get.back();
      UserInfoUtils.setUsername(usernameController: usernameController, account: SpUtils.getString("account"), 
        onSuccess: (){
          snackbar.success("设置成功","用户名设置成功");
          Get.find<MePageController>().loadData();
      });
    }else{
      snackbar.error("用户名设置失败", "用户名不能为空",null);
    }
  }
  void gotoSetPassword()=>Get.toNamed(RouteConfig.verifyEmailPage,arguments: {'canGotoWhenUserExist':T,'canGotoWhenUserNotExist':F});

  void setAvatar(){
    Get.back();
    UserInfoUtils.setAvatar(account: SpUtils.getString("account"), imgPath: imgPath, 
      onSuccess: (){
        snackbar.success("设置成功","头像设置成功");
        Get.find<MePageController>().loadData();
    });
  }
  void loginDown(){
    SpUtils.clear();
    Get.offAllNamed(RouteConfig.loginWithCaptchaPage);
  }

}