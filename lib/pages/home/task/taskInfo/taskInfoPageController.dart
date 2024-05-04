import 'dart:convert';

import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/services/utils/task/taskUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class TaskInfoPageController extends GetxController {
  Rx<String> title="".obs;
  Rx<String> description="".obs;
  Rx<String> date="".obs;
  Rx<double> distance=0.0.obs;
  Rx<int> hotValue=0.obs;
  RxList<String> imgs=RxList();
  Rx<String> avatar=staticValue.defaultAvatar.obs;
  Rx<String> username="".obs;
  Rx<String> account="".obs;
  Rx<String> loc="".obs;
  Rx<String> locDetail="".obs;
  RxList<String> labels=RxList();

  Rx<bool> like=false.obs;
  Rx<bool> dislike=false.obs;
  Rx<bool> requested=false.obs;
  late int id;
  Rx<bool> needHead=F.obs;
  Rx<bool> needFoot=F.obs;

  bool canChat=false;
  @override
  void onInit() {
    super.onInit();
    id = Get.arguments["id"] as int; 
    getInfo();
  }

  void getInfo(){
    TaskUtils.getTask(id: id,account: SpUtils.getString("account"), onSuccess: (data){
      //printInfo(info:data.toString());
      title.value=data['title'];
      description.value=data['content'];
      loc.value=data['address_name'];
      locDetail.value=bool.parse(data['onLine'])?"线上委托":data['address'];
      avatar.value=data['avatar'];
      username.value=data['username'];
      account.value=data['account'];
      like.value=bool.parse(data["like"]);
      dislike.value=bool.parse(data["dislike"]);
      requested.value=bool.parse(data["request"]);

      needHead.value = SpUtils.getString("account")!=data['account'];
      needFoot.value = SpUtils.getString("account")!=data['account'];

      String t=data['time'];
      DateTime dt=DateTime.parse(t.substring(0,t.indexOf('.')));
      date.value="截止至${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}前";    

      List<dynamic> tags=jsonDecode(data["tags"]);
      List<dynamic> igs=jsonDecode(data["imgs"]);
      
      for (var element in tags) {labels.add(element);}
      for (var element in igs) {imgs.add(element);}

      canChat=T;
    });
  }

  void tapLike(){   
    TaskUtils.like(id: id, account: SpUtils.getString("account"),onSuccess: (){
      like.value=!like.value;
      if(like.value&&dislike.value) dislike.value=false;
    });
  }
  void tapDislike(){
    TaskUtils.dislike(id: id, account: SpUtils.getString("account"),onSuccess: (){
      dislike.value=!dislike.value;
      if(like.value&&dislike.value) like.value=false;
    });
    
  }
  void onTapChat(){
    if (!canChat) snackbar.error("对象错误", "对象信息未初始化完毕", 0);
    else Get.toNamed(RouteConfig.chatDetailPage,arguments:{'name':username.value,'avatar':avatar.value,'email':account.value});
  }

  void access(){
    TaskUtils.requestTask(id: id, account: SpUtils.getString("account"), onSuccess: (){
      requested.value=true;
      snackbar.success("申请成功", "请等待发布者确认");
    });
  }
}