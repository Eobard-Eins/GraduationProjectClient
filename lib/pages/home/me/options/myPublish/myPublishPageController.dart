import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/models/User.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/services/utils/task/taskUtils.dart';
import 'package:client_application/services/utils/user/userInfoUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

class MyPublishPageController extends GetxController{
  RxList<TaskItemInfo> allTasks=RxList<TaskItemInfo>();
  RxList<TaskItemInfo> allTasksOfRequestButNotAccess=RxList<TaskItemInfo>();
  RxList<TaskItemInfo> allTasksOfDoing=RxList<TaskItemInfo>();
  RxList<TaskItemInfo> allTasksOfDone=RxList<TaskItemInfo>();
  RxList<TaskItemInfo> allTasksOfTimeout=RxList<TaskItemInfo>();

  RxList<User> us=RxList<User>();

  final refreshController=EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int initStateNum=0;
  bool allGet=false;
  int nowIndex=0;
  @override
  void onInit(){
    super.onInit();
    initStateNum=Get.arguments["initialIndex"] as int;

  }

  Future loadData(RxList nt, int status, {bool refresh=false})async{
    //isLoading.value=true;
    printInfo(info:"loadData");
    List<TaskItemInfo> newTasks=[];
    if(refresh){
      nowIndex=0;
      allGet=false;
    }

    if(allGet){
      refreshController.finishRefresh(IndicatorResult.noMore);
      refreshController.finishLoad(IndicatorResult.noMore);
      return ;
    }

    TaskUtils.getTasksByPublicUser(
      account: SpUtils.getString("account"),
      status: status, 
      page: nowIndex, 
      size:10,
      onError: () {
        refreshController.finishRefresh(IndicatorResult.noMore);
        refreshController.finishLoad(IndicatorResult.noMore);
      },
      onSuccess: (data){
        nowIndex++;
        List<dynamic> content=data["content"];
        int pageNumber=data["pageable"]["pageNumber"];
        int totalPages=data["totalPages"];

        //printInfo(info: content.toString());
        printInfo(info: "access task, page ${pageNumber+1}/$totalPages");
        if(totalPages==pageNumber+1) {
          allGet=true;//此批数据为最后一页
        }
        for(Map<String,dynamic> item in content){
          String t=item['time'];
          DateTime dt=DateTime.parse(t.substring(0,t.indexOf('.')));

          newTasks.add(TaskItemInfo.brief(
            id: int.parse(item['id']), 
            title: item['title'], 
            point: double.parse(item['point']), 
            time: "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}前", 
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

  Future<List<User>> getAllRequestWithTask(int id) async{
    us.clear();
    TaskUtils.getAllRequestWithTask(id: id, onSuccess: (data){
      for(Map<String, dynamic> item in data){
        String username=item["username"]??"Username";
        String mailAddress=item["uid"]??"";
        String avatar=item["avatar"]??staticValue.defaultAvatar;
        User u=User.briefly(username: username, mailAddress: mailAddress, avatar: avatar);
        us.add(u);
      }
    });
    return us;
  }

  Future accessTaskRequest(String user,int id,String username){
    printInfo(info: "user:$user access task id:$id");
    return TaskUtils.accessTask(id: id, account: user, onSuccess: (){
      Get.back();
      allTasksOfRequestButNotAccess.clear();
      refreshController.callRefresh();
      snackbar.success("接受成功", "已成功接受来自用户$username的申请");
    });
  }

  void gotoTaskInfoPage(int id)=>Get.toNamed(RouteConfig.taskInfoPage,arguments:{'id':id});

  tapChat(int id) {
    UserInfoUtils.getUserInfoByTaskId(tid: id, onSuccess: (u){
      Get.toNamed(RouteConfig.chatDetailPage,arguments:{'name':u.username,'avatar':u.avatar,'email':u.mailAddress});
    });
  }
}