import 'package:client_application/components/display/footerAndHeader.dart';
import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/components/item/conversationList.dart';
import 'package:client_application/pages/home/chat/chatPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:easy_refresh/easy_refresh.dart';
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
      body: Obx(() => Column(children: [
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
        Expanded(child: EasyRefresh(
          header: FootAndHeader.header,
          footer: FootAndHeader.footer,
          //canLoadAfterNoMore: true,
          canRefreshAfterNoMore: true,
          refreshOnStart: true,
          controller: _cpc.refreshController,
          onRefresh: ()async{
            await _cpc.load(refresh: true);
          },
          onLoad: ()async{
            //_mppc.refreshController.finishLoad(IndicatorResult.noMore);
            await _cpc.load();
          },
          child:ListView.separated(
            itemCount: _cpc.chatUsers.length,
            //shrinkWrap: true,
            padding: const EdgeInsets.only(top: 5),
            separatorBuilder: (context, index) {
              return const Divider(height:0.2,indent:15,endIndent: 15,color: Coloors.greyLight,);
            },
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
                isMessageRead: _cpc.chatUsers[index].isRead, 
                email: _cpc.chatUsers[index].email,
              );
            },
          ),
      ))
      ],))
    );
  }

}
