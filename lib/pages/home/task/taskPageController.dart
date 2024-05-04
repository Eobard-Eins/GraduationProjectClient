
import 'dart:convert';

import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/utils/task/taskUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/services/utils/locationUtils.dart';
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

  String searchWord="";
  @override
  void onInit() {
    super.onInit();

    tasks.clear();
    searchWord="";
    distance.value=SpUtils.getDouble('distance',defaultValue: 10.0);
    location.value=" - - - ";
    //isLoading.value=false;
    gettingLocation.value=false;
    searchController.value.clear();
    searchController.refresh();
    
    SpUtils.setDouble("distance",distance.value);
    getLocation();
  }
  
  Future loadData(int n,{bool refresh=false})async{
    //isLoading.value=true;
    printInfo(info:"loadData");
    List<TaskItemInfo> newTasks=[];

    TaskUtils.getTaskList(
      account: SpUtils.getString("account"),
      k: n,
      search: searchWord, 
      distance: SpUtils.getDouble("distance"), 
      lat: SpUtils.getDouble("latitude"), 
      lon: SpUtils.getDouble("longitude"), 
      onError: () {
        refreshController.finishRefresh(IndicatorResult.noMore);
        refreshController.finishLoad(IndicatorResult.noMore);
      },
      onSuccess: (items){
        for(Map<String,dynamic> item in items){
          double s=double.parse(item['distance']);
          bool ol=bool.parse(item['online']);
          String location=ol?"在线":"${s.toStringAsFixed(2)}km内";
          String labels="";
          bool flag=T;
          List<dynamic> ls=jsonDecode(item["tags"]);
          String t=item['time'];
          DateTime dt=DateTime.parse(t.substring(0,t.indexOf('.')));
          for(String s in ls){
            if(flag){
              labels=labels+s;
              flag=F;
            }else{
              labels="$labels/$s";
            }
          }
          newTasks.add(TaskItemInfo(
            id: int.parse(item['id']), 
            title: item['title'], 
            point: double.parse(item['point']), 
            time: "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}\n${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}前", 
            location: location, 
            labels: labels, 
            hotValue: int.parse(item['hot']), 
            avatar: item['avatar']
          ));             
        }
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
        
      }
    );
  }
  void moveToTop(){
    printInfo(info:"moveToTop");
    scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
  }
  void gotoAddNewTask()=> Get.toNamed(RouteConfig.newTaskPage);

  void search(){
    searchWord=searchController.value.text;
    loadData(6,refresh: T);
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