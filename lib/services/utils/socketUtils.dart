import 'dart:io';

import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/models/chatMessageModel.dart';
import 'package:client_application/models/chatUsersModel.dart';
import 'package:client_application/pages/home/chat/chatDetailPageController.dart';
import 'package:client_application/pages/home/chat/chatPageController.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/services/utils/chat/chatUtils.dart';
import 'package:client_application/services/utils/user/userInfoUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
class SocketUtils extends GetConnect{
  SocketUtils._internal();

  factory SocketUtils() => _instance;

  static final SocketUtils _instance = SocketUtils._internal();

  late WebSocket _webSocket;
  bool inRoom=false;
  ChatDetailPageController? _ctrl;
  ChatPageController? _cpc;

  void intoRoom(){
    inRoom=true;
    _ctrl=Get.find<ChatDetailPageController>();
  }
  void closeRoom(){
    inRoom=false;
    _ctrl = null;
  }

  void chatReady()=>_cpc=Get.find<ChatPageController>();

  //连接wensocket并且监听
  void connect(String userName) {
    Future<WebSocket> futureWebSocket =
        WebSocket.connect("${staticValue.socketUrl}/$userName"); //socket地址
    futureWebSocket.then((WebSocket ws) {
      printInfo(info:"connect success");
      _webSocket = ws;
      _webSocket.readyState;

      _webSocket.listen(onData,
          onError: (a) => printError(info:"socket error: $a"), onDone: () => printInfo(info: "connect close"));
    }).onError((error, stackTrace){
      snackbar.error("连接失败", "socket connect error", 0);
    });
  }

  void closeSocket() {
    _webSocket.close();
  }

  // 向服务器发送消息
  void sendMessage(String sender, String receiver, String msg) {
    ChatUtils.save(//现存入数据库，避免数据丢失，再发送
      sender: sender,
      receiver: receiver,
      msg: msg,
      time: DateTime.now(),
      onSuccess: (data){
        //Map<String, dynamic> mp = convert.jsonDecode(data);
        String sender=data["sender"];
        String receiver=data["receiver"];
        int id=data["id"] as int;
        String msg=data["msg"];
        String t=data['time'];
        DateTime dt=DateTime.parse(t);
        
        Map mp={
          "sender":sender,
          "receiver":receiver,
          "status":Status.newMessage,
          "msg":msg,
          "id":id,//消息id
          "time":dt.millisecondsSinceEpoch
        };
        printInfo(info:"send message: ${convert.jsonEncode(mp)}");
        _webSocket.add(convert.jsonEncode(mp));
    });
  }

  void onData(dynamic content){//此时发出去的消息已经送出，接到回信
    Map<String, dynamic> mp = convert.jsonDecode(content);
    printInfo(info: "receive message: $mp");
    String sender=mp["sender"];
    String receiver=mp["receiver"];
    int status=mp["status"] as int;
    //int id=mp["id"] as int;
    String msg=mp["msg"];
    String t=mp['time'];
    DateTime dt=DateTime.parse(t);
    
    String me=SpUtils.getString("account");

    bool isread=(status==Status.read);
    if(sender==me) isread=true;

    //处理聊天房间
    if(inRoom){//在房间中时
      String u=_ctrl!.email.value;
      if(sender==me && receiver==u){//由我发送，对方接收
        _ctrl!.messages.insert(0,ChatMessage(messageContent: msg, messageType: Status.sender));
        _ctrl!.scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
        _ctrl!.controller.clear();//若在此处存数据库，可能双方都收到消息但数据库中没有
      }else if(sender==u && receiver==me){//由对方发送，我接收
        _ctrl!.messages.insert(0,ChatMessage(messageContent: msg, messageType: Status.receiver));
        _ctrl!.scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
        // 标为已读
        ChatUtils.read(me:me,him:u,onSuccess: ()=>isread=true);
      }else{//其余情况
        snackbar.error("未知错误", "消息发送方或接收方uid出错", 0);
      }
    }

    //处理消息列表
    if(sender==me || receiver==me){
      String him=(sender==me)?receiver:sender;
      updateMsgConv(him, dt, msg,isread);
    }
  }

  void updateMsgConv(String him,DateTime dt,String msg,bool isRead){
    if(_cpc==null) return ;
    UserInfoUtils.getUserInfo(mail: him, onSuccess: (u){
      int i=0;
      for(i=0;i<_cpc!.chatUsers.length;i++){
        if(_cpc!.chatUsers[i].email==him){
          _cpc!.chatUsers.removeAt(i);
          break;
        }
      }
      
      _cpc!.chatUsers.insert(0, ChatUsers(
        name: u.username!, 
        messageText: msg, 
        imageURL: u.avatar, 
        isRead: isRead,
        email: him, 
        time: "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}"
      ));
    }); 
  }
}