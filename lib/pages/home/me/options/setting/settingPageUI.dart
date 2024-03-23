import 'package:client_application/pages/home/me/options/setting/settingPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  final SettingPageController _spc=Get.put(SettingPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Center(
        child: Text("设置"),
      ),
    );
  }
}