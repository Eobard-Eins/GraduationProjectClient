import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/tool/timeUtils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPublishPageController extends GetxController{
  RxList<TaskItemInfo> allTasks=RxList<TaskItemInfo>();

  final refreshController=EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int initStateNum=0;
  @override
  void onInit(){
    super.onInit();
    initStateNum=Get.arguments["initialIndex"] as int;
    for(var i=0;i<10;i++){
      allTasks.add(TaskItemInfo(id: i+1000, title: "title", point: 1025.5, time: "2024-12-31 11:55", location: "location", labels: "labels", hotValue: 114514));
    }
  }

  Future<int> loadData({bool refresh=false})async{
    //isLoading.value=true;
    printInfo(info:"loadData");
    List<TaskItemInfo> newTasks=[];

    //TODO: 测试网络请求
    await TimeUtils.TimeTestModel(3);
    for(var i=0;i<5;i++){
      newTasks.add(TaskItemInfo(id: i+1000, title: "title", point: 1025.5, time: "time", location: "location", labels: "labels", hotValue: 114514));
    }

    if (newTasks.isEmpty){
      refreshController.finishRefresh(IndicatorResult.noMore);
      refreshController.finishLoad(IndicatorResult.noMore);
    }else{
      refreshController.finishRefresh();
      refreshController.finishLoad();
      if (refresh){
        allTasks.clear();
      }
      allTasks.addAll(newTasks);
    }
    //isLoading.value=false;
    return newTasks.length;
  }
  void gotoTaskInfoPage(int id)=>Get.toNamed(RouteConfig.taskInfoPage,arguments:{'id':id});
}