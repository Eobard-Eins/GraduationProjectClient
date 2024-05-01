import 'dart:io';

import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/models/chatMessageModel.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/tool/socketUtils.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:get/get.dart';

class ChatDetailPage extends StatefulWidget {
  final String name;
  final String userImageUrl;
  final String email;

  const ChatDetailPage(
      {Key? key, required this.name, required this.userImageUrl, required this.email})
      : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();

  List<ChatMessage> messages=[];

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
        printInfo(info: '收到消息:' + content);
        
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
    printInfo(info:convert.jsonEncode(message));
    _webSocket.add(convert.jsonEncode(message));
  }
  @override
  void initState() {
    
    connect(SpUtils.getString("account"));
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    closeSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                ImgFromNet(imageUrl:widget.userImageUrl,height: 30,width: 30, boxShape: BoxShape.circle,),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                    alignment:
                        (messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType ==
                                  "receiver"
                              ? Colors.grey.shade200
                              : Coloors.mainLight.withAlpha(140)),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: const TextStyle(fontSize: 15),
                        ))),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 20, top: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                          hintText: "输入信息...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                      controller: _controller,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5,bottom: 5,right: 15),child: FloatingActionButton(
                    onPressed: () {
                      //TODO:
                      var message = {
                        "msg": _controller.text,
                        "toUser": widget.email,
                        "fromUser": SpUtils.getString("account")
                      };

                      ///传递信息
                      sendMessage(message);
                      setState(() {
                        messages.add(
                          ChatMessage(
                              messageContent: _controller.text,
                              messageType: "sender"),
                        );
                        _controller.clear();
                      });
                    },
                    backgroundColor: Coloors.main,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
