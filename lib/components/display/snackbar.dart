import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class snackbar{
  snackbar.error(String title, String message, int? code, {bool exception=false}){
    printInfo(info: "${exception?"未知错误":title},code:$code");
    Get.snackbar(title, message,icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
  }
  snackbar.warnning(String title, String message,{bool exception=false}){
    Get.snackbar(title, message,icon: const Icon(Icons.warning_amber_rounded,color: Color.fromARGB(255, 255, 251, 0),),shouldIconPulse:false);
  }
}