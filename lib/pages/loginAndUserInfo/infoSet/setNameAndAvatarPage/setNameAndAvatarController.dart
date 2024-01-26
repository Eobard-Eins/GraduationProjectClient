import 'dart:io';

import 'package:client_application/components/user/circleAvatar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetNameAndAvatarController extends GetxController{
  Rx<TextEditingController> usernameController=TextEditingController().obs;
  Rx<XFile?> imgPath=Rx(null);
  //设置图片挑选器
  final ImagePicker _picker = ImagePicker();

  openGallery() async {
    Get.back();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null) imgPath.value=image;
    imgPath.refresh();
  }
  takePhoto() async {
    Get.back();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image!=null) imgPath.value=image;
    imgPath.refresh();
  }
  //头像
  Widget imageView() {
    if (imgPath.value == null) {
      return Container(
        padding: const EdgeInsets.all(26),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Coloors.greyLight,
        ),
        child: const Padding(
            padding: EdgeInsets.only(bottom: 3, right: 3),
            child: Icon(
              Icons.add_a_photo_rounded,
              color: Coloors.greyDark,
              size: 48,
            )),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          //设置描边
          border: Border.all(color: Coloors.greyLight, width: 1),
          color: Colors.transparent,
        ),
        child: CircleAvatarOfUser(image: imgPath.value,size: 50,)
      );
    }
  }

  Function()? canNext(){
    return usernameController.value.text.isNotEmpty&&imgPath.value!=null ? onTapNext : null;
  }
  void onTapNext() {
    printInfo(info:"点击下一步");
    bool needSetInfo=Get.arguments["needSetInfo"] as bool;
    String account=Get.arguments["account"] as String;
    UserNetService().setAvatar(account,imgPath.value).then((value){
      switch(value.statusCode){
        case Status.setAvatarError:
          printInfo(info: "数据库写入错误,code:${value.statusCode}");
          Get.snackbar("设置失败", "请稍后重试",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          init();
          break;

        case Status.ossError:
          printInfo(info: "OSS服务器错误,code:${value.statusCode}");
          Get.snackbar("设置失败", "请稍后重试",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          init();
          break;

        case Status.netError:
          printInfo(info: "网络错误,code:${value.statusCode}");
          Get.snackbar("设置失败", "请检查网络设置",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          init();
          break;


        case Status.success:
          if(needSetInfo){
            Get.offNamed(RouteConfig.setUserInitProfilePage,arguments:{'needSetInfo':true,'account':account});
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
  }

  void init() {
    usernameController.value.clear();
    usernameController.refresh();
    imgPath.value=null;
  }
}