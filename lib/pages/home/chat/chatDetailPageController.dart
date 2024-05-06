import 'package:client_application/components/display/uploadingDialog.dart';
import 'package:client_application/models/chatMessageModel.dart';
import 'package:client_application/services/utils/chat/chatUtils.dart';
import 'package:client_application/services/utils/socketUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailPageController extends GetxController{
  Rx<String> name="".obs;
  Rx<String> userImageUrl="".obs;
  Rx<String> email="".obs;
  RxList<ChatMessage> messages=RxList();
  bool allGet=false;
  int nowIndex=0;
  String me = SpUtils.getString("account");

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
    
    //设置所有与该用户的消息为已读
    ChatUtils.read(him: email.value, me: me,onSuccess: (){});
    super.onInit();
  }

  @override
  void onReady()async{
    SocketUtils().intoRoom();
    
    UploadingDialog.show();
    await getHistory(10);
    UploadingDialog.hide();
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
      me,
      email.value,
      controller.value.text
    );
    //controller.clear();
  }


  Future getHistory(int size)async{
    List<ChatMessage> ls=[];
    //await TimeUtils.TimeTestModel(1);
    if(allGet){
      refreshController.finishRefresh(IndicatorResult.noMore);
      refreshController.finishLoad(IndicatorResult.noMore);
      return ;
    }
    ChatUtils.history(me: me, him: email.value, page: nowIndex,size: size, onSuccess: (data){
      nowIndex++;
      List<dynamic> content=data["content"];
      int pageNumber=data["pageable"]["pageNumber"];
      int totalPages=data["totalPages"];

      
      printInfo(info: "chat history, page ${pageNumber+1}/$totalPages");
      if(totalPages==pageNumber+1) {
        allGet=true;//此批数据为最后一页
      }

      for(Map<String, dynamic> item in content){
        String msg=item["msg"];
        String sender=item["sender"];

        int t;
        if(sender==me) {
          t=Status.sender;
        } else {
          t=Status.receiver;
        }

        ls.add(ChatMessage(messageContent: msg, messageType: t));         
      }
      if (ls.isEmpty){
        refreshController.finishRefresh(IndicatorResult.noMore);
        refreshController.finishLoad(IndicatorResult.noMore);
      }else{
        refreshController.finishRefresh();
        refreshController.finishLoad();

        messages.addAll(ls);
      }
    },onSuccessBut: (){
      refreshController.finishRefresh(IndicatorResult.noMore);
      refreshController.finishLoad(IndicatorResult.noMore);
    });
  }
}