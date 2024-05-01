import 'dart:io';

import 'package:client_application/models/chatMessageModel.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/services/utils/user/userInfoUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

class ChatPageController extends GetxController{
  RxList<ChatMessage> messages=RxList();
  Rx<int> num=0.obs;
  final TextEditingController controller = TextEditingController();
  late WebSocket _webSocket;

  //连接wensocket并且监听
  void connect(String userName) {
    Future<WebSocket> futureWebSocket =
        WebSocket.connect("${staticValue.socketUrl}/$userName"); //socket地址
    futureWebSocket.then((WebSocket ws) {
      printInfo(info:"connect success");
      _webSocket = ws;
      _webSocket.readyState;
      // 监听事件
      void onData(dynamic content) {
        List<String> ls=(content as String).split(":");
        if(ls[0]=="update"){
          num.value=int.parse(ls[1]);
        }
        
        printInfo(info: '收到消息 ${ls[0]}: ${ls[1]}');
        String mt=SpUtils.getString("account")==ls[0]?"sender":"receiver";
        String avatar;
        String username;
        UserInfoUtils.getUserInfo(mail: ls[0], onSuccess: (u){
          avatar=u.avatar;
          username=u.username??"";
          messages.add(
            ChatMessage(
              avatar: avatar,
              username: username,
              messageContent: ls[1],
              messageType: mt),
          );
          if(messages.length>100) messages.remove(messages[0]);
        });
        
      }

      _webSocket.listen(onData,
          onError: (a) => printError(info:"socket error: $a"), onDone: () => printError(info: "socket done"));
    });
  }

  void closeSocket() {
    _webSocket.close();
  }

  // 向服务器发送消息
  void sendMessage(dynamic message) {
    if(message["msg"]=="") return ;
    printInfo(info:convert.jsonEncode(message));
    _webSocket.add(convert.jsonEncode(message));
  }

  @override
  void onInit(){
    connect(SpUtils.getString("account"));
    super.onInit();
  }
  @override
  void onClose(){
    closeSocket();
    super.onClose();
  }

  send() {
    var message = {
      "msg": controller.text,
      "fromUser": SpUtils.getString("account")
    };

    //传递信息
    sendMessage(message);
    
    controller.clear();
  }
}