import 'package:client_application/pages/home/homePageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget{
  final HomePageController _hpc=Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
            "HOME",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Coloors.main,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
      ),
      body: Center(child: Text("Home Page"),)
    );
  }
}