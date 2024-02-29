import 'package:client_application/pages/home/task/taskInfo/taskInfoPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskInfoPage extends StatelessWidget{
  final TaskInfoPageController _tipc=Get.put<TaskInfoPageController>(TaskInfoPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("任务详情"),
      ),
      body: Container(
        child: Text(_tipc.id.value),
      ),
    );
  }
}