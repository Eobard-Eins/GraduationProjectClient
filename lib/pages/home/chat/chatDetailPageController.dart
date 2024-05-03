import 'package:client_application/models/chatMessageModel.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/services/utils/socketUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:client_application/tool/timeUtils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailPageController extends GetxController{
  Rx<String> name="".obs;
  Rx<String> userImageUrl="".obs;
  Rx<String> email="".obs;
  RxList<ChatMessage> messages=RxList();
  int newMsg=0;
  int nowIndex=0;

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController=ScrollController();
  final EasyRefreshController refreshController=EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  @override
  void onInit() {
    name.value = Get.arguments["name"] as String; 
    userImageUrl.value = Get.arguments["avatar"] as String; 
    email.value = Get.arguments["email"] as String; 
    
    init();
    super.onInit();
  }

  @override
  void onReady(){
    SocketUtils().intoRoom();
    super.onReady();
  }

  @override
  void onClose(){
    SocketUtils().closeRoom();
    super.onClose();
  }

  void send(){
    if(controller.value.text.isEmpty || controller.value.text.length>100) return ;
    SocketUtils().sendMessage(
      SpUtils.getString("account"),
      email.value,
      Status.newMessage,
      controller.value.text
    );
    //controller.clear();
  }

  void init(){
    
    getHistory(nowIndex,nowIndex+10);//获取记录的消息全部标为已读
  }

  Future getHistory(int begin,int end)async{
    await TimeUtils.TimeTestModel(2);
    refreshController.finishRefresh();
  }
}