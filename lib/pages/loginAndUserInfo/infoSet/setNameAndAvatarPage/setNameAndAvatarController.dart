
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/services/utils/user/userInfoUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetNameAndAvatarController extends GetxController{
  Rx<TextEditingController> usernameController=TextEditingController().obs;
  Rx<XFile?> imgPath=Rx(null);

  @override
  void onInit() {
    super.onInit();
    usernameController.value.clear();
    usernameController.refresh();
    imgPath.value=null;
  }

  Function()? canNext(){
    return usernameController.value.text.isNotEmpty&&imgPath.value!=null ? onTapNext : null;
  }
  
  void onTapNext() {
    printInfo(info:"点击下一步");
    bool needSetInfo=Get.arguments["needSetInfo"] as bool;
    String account=Get.arguments["account"] as String;
    UserInfoUtils.setAvatar(
      account: account,
      imgPath: imgPath.value,
      onSuccess: ()=>UserInfoUtils.setUsername(
          username: usernameController.value.text, 
          account: account,
          onSuccess: ()=>needSetInfo?
              Get.offNamed(RouteConfig.homePage,arguments:{'needSetInfo':true,'account':account}):
              Get.back(),
          onError: () {
            usernameController.value.clear();
            usernameController.refresh();
          },
        ),
      onError: () {
        imgPath.value=null;
      },
    );
  }
  

  
}