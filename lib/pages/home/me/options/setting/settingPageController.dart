import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/components/img/imgFromLocal.dart';
import 'package:client_application/components/img/imgPicker.dart';
import 'package:client_application/config/RouteConfig.dart';
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
      UserInfoUtils.setUsername(usernameController: usernameController, account: SpUtils.getString("account"), onSuccess: (){});
    }else{
      snackbar.error("用户名设置失败", "用户名不能为空",null);
    }
  }
  void gotoSetPassword()=>Get.toNamed(RouteConfig.verifyEmailPage);

  void setAvatar(){
    UserInfoUtils.setAvatar(account: SpUtils.getString("account"), imgPath: imgPath, onSuccess: (){});
  }
  void loginDown(){

  }

}