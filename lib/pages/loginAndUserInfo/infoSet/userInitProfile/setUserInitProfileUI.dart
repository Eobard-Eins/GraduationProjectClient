
import 'package:client_application/pages/loginAndUserInfo/infoSet/userInitProfile/setUserInitProfileController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetUserInitProfilePage extends StatelessWidget {
  final SetUserInitProfileController _suipc=Get.find<SetUserInitProfileController>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "验证手机号",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Coloors.main,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Text("111")
     );
  }
}