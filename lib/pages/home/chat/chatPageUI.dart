import 'package:client_application/pages/home/chat/chatPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget{
  final ChatPageController _cpc=Get.put(ChatPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("信息"),
        centerTitle: true,
        shadowColor: Coloors.greyLight,
        backgroundColor: const Color.fromARGB(255, 255, 251, 254),
        surfaceTintColor: const Color.fromARGB(255, 255, 251, 254),
      ),
      body: Container(
      ),
    );
  }

}