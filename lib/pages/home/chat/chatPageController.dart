import 'dart:io';

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/models/chatMessageModel.dart';
import 'package:client_application/models/chatUsersModel.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/services/utils/socketUtils.dart';
import 'package:client_application/services/utils/user/userInfoUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

class ChatPageController extends GetxController{
  RxList<ChatUsers> chatUsers=RxList();
  Rx<int> num=0.obs;
  final TextEditingController controller = TextEditingController();
  

  @override
  void onInit(){
    initLoad();
    super.onInit();
  }

  void initLoad(){
    List<ChatUsers> ls=[];
    for(int i=0;i<20;i++)
      ls.add(ChatUsers(name: "Jane Russel", messageText: "Awesome Setup", imageURL: staticValue.defaultAvatar, time: "Now",email: "bf4ji50h5b@sfolkar.com"));
    chatUsers.addAll(ls);
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