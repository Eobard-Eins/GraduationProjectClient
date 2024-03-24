import 'package:client_application/pages/home/me/options/myPublish/myPublishPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPublishPage extends StatelessWidget{
  final MyPublishPageController _mppc=Get.put(MyPublishPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我发布的"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("发布"),
      ),
    );
  }
}