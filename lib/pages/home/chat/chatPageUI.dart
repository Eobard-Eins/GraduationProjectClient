import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/components/item/conversationList.dart';
import 'package:client_application/pages/home/chat/chatPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ChatPage extends StatelessWidget{
  final ChatPageController _cpc=Get.put(ChatPageController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          toolbarHeight: 15,
          shadowColor: Colors.white,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
      body: Column(children: [
        Container(
            padding: const EdgeInsets.only(left: 20,right:20,bottom: 10),
            decoration: const BoxDecoration(color: Colors.white),
            child: const Row(children: [
              Text(
                '聊天',
                style: TextStyle(
                    fontFamily: 'SmileySans',
                    fontSize: 40,),
              ),
              Spacer(),
            ])),
        Expanded(child: ListView.builder(
          itemCount: _cpc.chatUsers.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 5),
          itemBuilder: (context, index){
            String name= _cpc.chatUsers[index].name;
            String email= _cpc.chatUsers[index].email;
            String imageUrl= _cpc.chatUsers[index].imageURL;
            return ConversationList(
              onTap: ()=>_cpc.onTap(name,imageUrl,email),
              name: name,
              messageText: _cpc.chatUsers[index].messageText,
              imageUrl: imageUrl,
              time: _cpc.chatUsers[index].time,
              isMessageRead: (index == 0 || index == 3)?true:false, email: '',
            );
          },
        ),)
      ],)
    );
  }

}
