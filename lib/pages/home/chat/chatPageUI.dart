import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/pages/home/chat/chatPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ChatPage extends StatelessWidget{
  final ChatPageController _cpc=Get.put(ChatPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 15,
          shadowColor: Colors.white,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
      body: Obx(() => Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20,right:20,bottom: 15),
            decoration: const BoxDecoration(color: Colors.white),
            child: const Row(children: [
              Text(
                '世界聊天',
                style: TextStyle(
                    fontFamily: 'SmileySans',
                    fontSize: 32,),
              ),
              Spacer(),
            ])),
          Expanded(child: ListView.builder(
            itemCount: _cpc.messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                    alignment:
                        (_cpc.messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                    child: Column(
                      crossAxisAlignment: _cpc.messages[index].messageType == "receiver"
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                      children: [
                        Padding(padding: const EdgeInsets.only(bottom: 5,right: 4),child: Text(_cpc.messages[index].username),),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (_cpc.messages[index].messageType ==
                                    "receiver"
                                ? Colors.grey.shade200
                                : Coloors.mainLight.withAlpha(140)),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            _cpc.messages[index].messageContent,
                            style: const TextStyle(fontSize: 15),
                          ))
                    ],)
                  ),
              );
            },
          ),),
          Container(
              padding: const EdgeInsets.only(left: 10, bottom: 20, top: 10),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(padding: const EdgeInsets.only(left: 15),child: Text("在线人数: ${_cpc.num}",style: const TextStyle(fontSize: 14)),),
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: "输入信息...",
                            hintStyle: const TextStyle(color: Colors.black54),
                            contentPadding: const EdgeInsets.only(top:0,bottom: 0,left: 15),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Coloors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Coloors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Coloors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        controller: _cpc.controller,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(padding: const EdgeInsets.only(top: 2,bottom: 1,right: 15),child: FloatingActionButton(
                      onPressed: _cpc.send,
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
              ],)
              
          ),
        ],
      )),
    );
  }

}