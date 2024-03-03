import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class snackbar{
  snackbar.error(String title, String message, int? code, {bool exception=false}){
    printInfo(info: "${exception?"未知错误":title},code:$code");
    Get.snackbar(title, message,icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
  }
}