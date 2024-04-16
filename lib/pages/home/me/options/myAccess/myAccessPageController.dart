import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/tool/timeUtils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccessPageController extends GetxController{
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
    }
  }

  Future<int> loadData({bool refresh=false})async{
    //isLoading.value=true;
    printInfo(info:"loadData");
    List<TaskItemInfo> newTasks=[];

    //TODO: 测试网络请求
    await TimeUtils.TimeTestModel(3);
    for(var i=0;i<5;i++){
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