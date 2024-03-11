import 'package:client_application/pages/home/task/taskInfo/taskInfoPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskInfoPage extends StatelessWidget{
  final TaskInfoPageController _tipc=Get.put<TaskInfoPageController>(TaskInfoPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "详情",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
      body: Container(
        child: Text(_tipc.account.value),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.red,
        height: 55,
        child:Text("111"),
      )
    );
  }
}