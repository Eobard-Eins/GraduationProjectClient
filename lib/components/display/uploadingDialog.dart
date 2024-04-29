import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadingDialog {
  static show() {
    Get.dialog(
        Center(child: Container(
          decoration: BoxDecoration(
              color: Coloors.greyLight,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(30),
          width: 100,
          height: 100,
          child: const CircularProgressIndicator(
            color: Coloors.main,
          ),
        ),),
        barrierDismissible: false,
        );
  }

  static hide() {
    Get.back();
  }
}
