
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/services/utils/task/taskUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HistoryPageController extends GetxController{
  RxList<TaskItemInfo> tasks=RxList<TaskItemInfo>();
  final ScrollController scrollController=ScrollController();
  final EasyRefreshController refreshController=EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  @override
  void onInit() {
    super.onInit();
  }
  Future getHistory({bool refresh=false})async{
    List<TaskItemInfo> newTasks=[];

    TaskUtils.getHistory(account: SpUtils.getString("account"), onSuccess: (data){
      for(Map<String,dynamic> item in data){
        String t=item['time'];
        DateTime dt=DateTime.parse(t.substring(0,t.indexOf('.')));

        newTasks.add(TaskItemInfo.brief(
          id: int.parse(item['id']), 
          title: item['title'], 
          point: double.parse(item['point']), 
          time: "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}\n${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}前", 
          addressName: item["address_name"]
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
    });
  }
  void tapTask(int id){
    printInfo(info:"tapTask${id}");
    Get.toNamed(RouteConfig.taskInfoPage,arguments:{'id':id});
  }
}