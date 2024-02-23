
import 'package:client_application/components/common/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/task/taskItem.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskPageController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<TaskItemInfo> tasks=[TaskItemInfo.bottom()].obs;
  final ScrollController scrollController=ScrollController();
  @override
  void onInit() {
    super.onInit();
    for(var i=0;i<10;i++){
      tasks.insert(tasks.length-1, TaskItemInfo(id: 1, title: "title", point: 1025.5, time: "time", location: "location", labels: "labels", hotValue: 114514));
      
    }
    searchController.value.clear();
    searchController.refresh();
  }
  Widget TaskCard(context,TaskItemInfo ti){
    printInfo(info:"TaskItem Created");
    if (ti.id==-1) {
      return Container(
        width: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 20),
        child: TextButtonWithNoSplash(
          onTap: refreshh, 
          text: "---到底了，点击刷新---",
          textStyle: const TextStyle(
            fontSize: 10,
            color: Coloors.greyDeep,
            fontFamily: 'SmileySans',
            letterSpacing: 2
          ),
        )
      );
    } else {
      return TaskItem(
        ontap: (){},
        title: ti.title,
        point: ti.point,
        time: ti.time,
        location: ti.location,
        labels: ti.labels,
        hotValue: ti.hotValue,
      );
    }
  }
  Future<void> refreshh()async{
    printInfo(info:"refreshh");
    await UserNetService().TimeTestModel(3);
  }
  void addNewTask() {
  }
  void search() {
  }
  void filter(){

  }
  void tapTask(){
    
  }
}