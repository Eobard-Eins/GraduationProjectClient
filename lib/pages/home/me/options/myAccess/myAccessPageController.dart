import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/services/utils/task/taskUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

class MyAccessPageController extends GetxController{
  RxList<TaskItemInfo> allTasks=RxList<TaskItemInfo>();
  RxList<TaskItemInfo> allTasksOfDoing=RxList<TaskItemInfo>();
  RxList<TaskItemInfo> allTasksOfDone=RxList<TaskItemInfo>();
  RxList<TaskItemInfo> allTasksOfTimeout=RxList<TaskItemInfo>();
  
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

  Future<RxList> loadData(RxList nt, int status, {bool refresh=false})async{
    //isLoading.value=true;
    printInfo(info:"loadData");
    List<TaskItemInfo> newTasks=[];

    TaskUtils.getTasksByAccessUser(
      account: SpUtils.getString("account"),
      status: status,
      onError: () {
        refreshController.finishRefresh(IndicatorResult.noMore);
        refreshController.finishLoad(IndicatorResult.noMore);
      },
      onSuccess: (items){
        for(Map<String,dynamic> item in items){
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
            nt.clear();
          }
          nt.addAll(newTasks);
        }        
      }
    );
    return nt;
  }
  void finishTask(int id){
    TaskUtils.setStatus(id: id, status: Status.taskDone, onSuccess: (){
      snackbar.success("操作成功", "委托已完成");
    });
  }
  void gotoTaskInfoPage(int id)=>Get.toNamed(RouteConfig.taskInfoPage,arguments:{'id':id,"needFoot":false,"needHeader":true});
}