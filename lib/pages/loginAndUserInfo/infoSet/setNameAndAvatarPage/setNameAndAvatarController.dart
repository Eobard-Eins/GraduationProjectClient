import 'dart:io';

import 'package:client_application/components/user/circleAvatar.dart';
import 'package:client_application/res/color.dart';
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
    imgPath.value=image;
    imgPath.refresh();
  }
  takePhoto() async {
    Get.back();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    imgPath.value=image;
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
  }
}