import 'dart:convert';

import 'package:client_application/res/staticValue.dart';
import 'package:client_application/services/utils/task/taskUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/tool/timeUtils.dart';
import 'package:get/get.dart';

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
  late int id;
  @override
  void onInit() {
    super.onInit();
    id = Get.arguments["id"] as int;
    getInfo();
  }

  void getInfo() async{
    TaskUtils.getTask(id: id,account: SpUtils.getString("account"), onSuccess: (data){
      printError(info:data.toString());
      title.value=data['title'];
      description.value=data['content'];
      loc.value=data['address_name'];
      locDetail.value=bool.parse(data['onLine'])?"线上委托":data['address'];
      avatar.value=data['avatar'];
      username.value=data['username'];
      account.value=data['account'];

      String t=data['time'];
      DateTime dt=DateTime.parse(t.substring(0,t.indexOf('.')));
      date.value="截止至${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}前";    

      List<dynamic> tags=jsonDecode(data["tags"]);
      List<dynamic> igs=jsonDecode(data["imgs"]);
      
      for (var element in tags) {labels.add(element);}
      for (var element in igs) {imgs.add(element);}
    });
  }

  void tapLike(){
    like.value=!like.value;
    if(like.value&&dislike.value) dislike.value=false;
    TaskUtils.like(id: id, account: SpUtils.getString("account"));
  }
  void tapDislike(){
    dislike.value=!dislike.value;
    if(like.value&&dislike.value) like.value=false;
    TaskUtils.dislike(id: id, account: SpUtils.getString("account"));
    
  }
  void tapChat(){}

  void access(){}
}