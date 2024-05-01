import 'dart:io';

import 'package:client_application/res/staticValue.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
class SocketUtils extends GetConnect{
  SocketUtils._internal();

  factory SocketUtils() => _instance;

  static final SocketUtils _instance = SocketUtils._internal();

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
}