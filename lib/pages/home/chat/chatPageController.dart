import 'dart:io';

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/chatMessageModel.dart';
import 'package:client_application/models/chatUsersModel.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/services/utils/chat/chatUtils.dart';
import 'package:client_application/services/utils/socketUtils.dart';
import 'package:client_application/services/utils/user/userInfoUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

import 'package:get/get_connect/http/src/utils/utils.dart';

class ChatPageController extends GetxController{
  RxList<ChatUsers> chatUsers=RxList();
  Rx<int> num=0.obs;
  final TextEditingController controller = TextEditingController();
  final refreshController=EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  bool allGet=false;
  int nowIndex=0;

  
  Future load({bool refresh=false})async{
    List<ChatUsers> ls=[];
    if(refresh){
      nowIndex=0;
      allGet=false;
    }

    if(allGet){
      refreshController.finishRefresh(IndicatorResult.noMore);
      refreshController.finishLoad(IndicatorResult.noMore);
      return ;
    }

    ChatUtils.getConv(u: SpUtils.getString("account"), page:nowIndex, size:20, onSuccess: (data){
      //printInfo(info: data.toString());
      nowIndex++;
      List<dynamic> content=data["content"];
      int pageNumber=data["pageable"]["pageNumber"];
      int totalPages=data["totalPages"];

      //printInfo(info: content.toString());
      printInfo(info: "conv data, page ${pageNumber+1}/$totalPages");

      for(Map<String,dynamic> item in content){
        bool isSender=bool.parse(item["isSender"]);
        bool read=bool.parse(item["read"]);
        String email=item["email"];
        String avatar=item["avatar"];
        String name=item["name"];
        String msg=item["msg"];
        String t=item['time'];
        DateTime dt=DateTime.parse(t.substring(0,t.indexOf('.')));

        if(isSender) read=true;
        ls.add(ChatUsers(
          name: name, 
          messageText: msg, 
          imageURL: avatar, 
          time: "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}", 
          email: email,
          isRead: read
        ));           
      }
      if (ls.isEmpty){
        refreshController.finishRefresh(IndicatorResult.noMore);
        refreshController.finishLoad(IndicatorResult.noMore);
      }else{
        refreshController.finishRefresh();
        refreshController.finishLoad();
        if (refresh){
          chatUsers.clear();
        }
        chatUsers.addAll(ls);
      }        
    });
  }

  @override
  void onReady(){
    super.onReady();
    SocketUtils().chatReady();
  }

  void onTap(String name,String avatar,String email){
    Get.toNamed(RouteConfig.chatDetailPage,arguments:{'name':name,'avatar':avatar,'email':email});
  }
}