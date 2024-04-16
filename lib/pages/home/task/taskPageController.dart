
import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/utils/task/taskUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/services/utils/locationUtils.dart';
import 'package:client_application/tool/timeUtils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class TaskPageController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<TaskItemInfo> tasks=RxList<TaskItemInfo>();
  Rx<double> distance=10.0.obs;
  Rx<String> location="- - -".obs;
  //Rx<bool> isLoading=false.obs;
  Rx<bool> gettingLocation=false.obs;
  
  final ScrollController scrollController=ScrollController();
  final EasyRefreshController refreshController=EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  @override
  void onInit() {
    super.onInit();

    tasks.clear();
    distance.value=SpUtils.getDouble('distance',defaultValue: 10.0);
    location.value=" - - - ";
    //isLoading.value=false;
    gettingLocation.value=false;
    searchController.value.clear();
    searchController.refresh();
    
    SpUtils.setDouble("distance",distance.value);
    getLocation();
  }
  
  Future<int> loadData(int n,{bool refresh=false})async{
    //isLoading.value=true;
    printInfo(info:"loadData");
    List<TaskItemInfo> newTasks=[];

    //TODO: 测试网络请求
    TaskUtils.getTaskList(
      account: SpUtils.getString("account"),
      k: 5,
      search: searchController.value.text, 
      distance: SpUtils.getDouble("distance"), 
      lat: SpUtils.getDouble("latitude"), 
      lon: SpUtils.getDouble("longitude"), 
      onSuccess: (items){
        for(var item in items){
          double s=item['distance'];
          String location="${s.toStringAsFixed(2)}km内";
          String labels="";
          bool flag=T;
          for(String s in item["tags"]){
            if(flag){
              labels=labels+s.substring(1);
              flag=F;
            }else{
              labels="$labels/${s.substring(1)}";
            }
          }
          TaskItemInfo ti=TaskItemInfo(id: item['id'], title: item['title'], point: item['point'], time: "time", location: location, labels: labels, hotValue: item['hot'], avatar: item['avatar']);
          newTasks.add(ti);
        }
      }
    );
    // await TimeUtils.TimeTestModel(3);
    // for(var i=0;i<n;i++){
    //   newTasks.add(TaskItemInfo(id: i+1000, title: "title", point: 1025.5, time: "2024-12-31\n12:45前", location: "3.5km内", labels: "label1/lebel2/label3/label4", hotValue: 114514));
    // }

    if (newTasks.isEmpty){
      refreshController.finishRefresh(IndicatorResult.noMore);
      refreshController.finishLoad(IndicatorResult.noMore);
    }else{
      refreshController.finishRefresh();
      refreshController.finishLoad();
      if (refresh){
        tasks.clear();
      }
      tasks.addAll(newTasks);
    }
    //isLoading.value=false;
    return newTasks.length;
  }
  void moveToTop(){
    printInfo(info:"moveToTop");
    scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
  }
  void gotoAddNewTask()=> Get.toNamed(RouteConfig.newTaskPage);

  void search() {
    printInfo(info:"search");
  }
  
  void tapTask(int id){
    printInfo(info:"tapTask${id}");
    Get.toNamed(RouteConfig.taskInfoPage,arguments:{'id':id});
  }
  void alterConfirm(){
    if(distance.value==50){
      SpUtils.setDouble("distance",99999);
    } else if (distance.value==0){
      SpUtils.setDouble("distance",0.1);
    }else{
      SpUtils.setDouble("distance",distance.value);
    }
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
        snackbar.success("定位成功", "当前位置信息已更新");
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