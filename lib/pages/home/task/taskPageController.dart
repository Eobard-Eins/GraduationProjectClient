

import 'package:client_application/components/common/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/task/taskItem.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:client_application/utils/locationUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskPageController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<TaskItemInfo> tasks=RxList<TaskItemInfo>();
  Rx<double> distance=10.0.obs;
  Rx<String> location="- - -".obs;
  Rx<bool> isLoading=false.obs;
  Rx<bool> allLoaded=false.obs;
  Rx<bool> pull=false.obs;
  Rx<bool> gettingLocation=false.obs;
  
  final ScrollController scrollController=ScrollController();
  double distanceInSearch=10.0;
  @override
  void onInit() {
    super.onInit();

    tasks.clear();
    distance.value=SpUtils.getDouble('distance',defaultValue: 10.0);
    distanceInSearch=distance.value;
    location.value="- - -";
    allLoaded.value=false;
    isLoading.value=false;
    gettingLocation.value=false;
    pull.value=false;
    searchController.value.clear();
    searchController.refresh();

    getLocation();
    loadData(10);
    scrollController.addListener(_scrollListener);
  }
  Widget TaskCard(context,int index){
    //printInfo(info:"TaskItem $index Created");
    if (index==tasks.length) {
      if(isLoading.value){
        if(pull.value){
          return const Padding(padding: EdgeInsets.only(bottom: 20));
        }
        return Container(
          padding: const EdgeInsets.only(bottom: 10,top:12),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: Coloors.main,
          )
        );
      }
      return Container(
          width: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 20,top:12),
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
      var ti=tasks[index];
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
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoading.value && !allLoaded.value) {
      loadData(5);
      printInfo(info:"to the down");
    }
  }
  Future<void> refreshh()async{
    printInfo(info:"refreshh");
    moveToTop();
    tasks.clear();
    await loadData(10);
    printInfo(info:"refreshh end");
  }
  Future<void> refreshByPull()async{
    pull.value=true;
    await refreshh();
    pull.value=false;
  }
  Future<void> loadData(int n)async{
    isLoading.value=true;
    printInfo(info:"loadData");
    List<TaskItemInfo> newTasks=[];

    //TODO: 测试网络请求
    await UserNetService().TimeTestModel(3);
    for(var i=0;i<n;i++){
      newTasks.add(TaskItemInfo(id: 1, title: "title", point: 1025.5, time: "time", location: "location", labels: "labels", hotValue: 114514));
    }

    if (newTasks.isEmpty){
      allLoaded.value=true;
      Get.snackbar("暂无更多", "暂时没有更多数据",icon: const Icon(Icons.feedback_outlined,color: Coloors.gold,),shouldIconPulse:false);
    }else{
      tasks.addAll(newTasks);
      if(tasks.length<3){
        allLoaded.value=true;
      }else{
        allLoaded.value=false;
      }
    }
    isLoading.value=false;
  }
  void moveToTop(){
    printInfo(info:"moveToTop");
    scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
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
    printInfo(info:"distance change to ${SpUtils.getDouble('distance')}");
    Get.back();
  }
  void getLocation(){
    gettingLocation.value=true;
    int count=0;
    printInfo(info:"开始定位");
    LocationUtils.getLocation((result){
      printInfo(info:result.toString());
      if(result['latitude']!=null&&result['longitude']!=null){
        SpUtils.setDouble('longitude', result['longitude']);
        SpUtils.setDouble('latitude', result['latitude']);
        printInfo(info:'已存储经纬度:${SpUtils.getDouble('latitude')},${SpUtils.getDouble('longitude')}');
      }
      if(result['district'].toString()!=""){
        location.value=result['district'].toString();
        LocationUtils.stopLocation();
        gettingLocation.value=false;
        printInfo(info:'定位结束');
      }
      if(count==5){
        Get.snackbar("获取失败", "请稍后重试",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
        LocationUtils.stopLocation();
        gettingLocation.value=false;
        printInfo(info:'定位结束');
      }
      count++;
      //TimeUntils.TimeTestModel(1);
      
    });
  }
  void stopLocation(){
    LocationUtils.stopLocation();
    gettingLocation.value=false;
  }
}