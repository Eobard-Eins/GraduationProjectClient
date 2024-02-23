
import 'package:client_application/components/common/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/task/taskItem.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskPageController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<TaskItemInfo> tasks=[TaskItemInfo.bottom()].obs;
  Rx<double> distance=10.0.obs;
  Rx<String> location="定位".obs;

  final ScrollController scrollController=ScrollController();
  double distanceInSearch=10.0;
  @override
  void onInit() {
    super.onInit();
    for(var i=0;i<10;i++){
      tasks.insert(tasks.length-1, TaskItemInfo(id: 1, title: "title", point: 1025.5, time: "time", location: "location", labels: "labels", hotValue: 114514));
      
    }
    tasks.value=[TaskItemInfo.bottom()];
    distance.value=SpUtils.getDouble('distance',defaultValue: 10.0);
    distanceInSearch=distance.value;
    location.value="定位";
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
  void alterConfirm(){
    if(distance.value==50){
      distanceInSearch=99999;
    } else if (distance.value==0){
      distanceInSearch=0.1;
    }else{
      distanceInSearch=distance.value;
    }
    SpUtils.setDouble("distance",distanceInSearch);
    printInfo(info:"distance change to $distanceInSearch");
    Get.back();
  }
  void getLocation(){
    location.value="北京";
  }
}