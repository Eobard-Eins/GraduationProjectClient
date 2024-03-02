
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:client_application/utils/locationUtils.dart';
import 'package:client_application/utils/timeUtils.dart';
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
    await TimeUtils.TimeTestModel(3);
    for(var i=0;i<n;i++){
      newTasks.add(TaskItemInfo(id: i+1000, title: "title", point: 1025.5, time: "time", location: "location", labels: "labels", hotValue: 114514));
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
  void tapTask(int id){
    printInfo(info:"tapTask${id}");
    Get.toNamed(RouteConfig.taskInfoPage,arguments:{'id':id});
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


  Future<void> getLocation()async{
    
    int count=0;
    printInfo(info:"开始定位");
    LocationUtils.getLocation((result){
      gettingLocation.value=true;
      printInfo(info:result.toString());
      
      if(result['district'].toString()!=""){
        if(result['latitude']!=null&&result['longitude']!=null){
          SpUtils.setDouble('longitude', result['longitude']);
          SpUtils.setDouble('latitude', result['latitude']);
          printInfo(info:'已存储经纬度:${SpUtils.getDouble('latitude')},${SpUtils.getDouble('longitude')}');
        }
        location.value=result['district'].toString();
        
        stopLocation();
      }
      if(count==5){
        Get.snackbar("获取失败", "请稍后重试",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
        stopLocation();
      }
      count++;
      //TimeUntils.TimeTestModel(1);
      
    });
    printError(info:"getLocation end");
  }
  void stopLocation(){
    LocationUtils.stopLocation();
    gettingLocation.value=false;
    printInfo(info:'定位结束');
  }
}