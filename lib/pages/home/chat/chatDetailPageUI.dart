
import 'package:client_application/components/display/footerAndHeader.dart';
import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/pages/home/chat/chatDetailPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ChatDetailPage extends StatelessWidget {
  final ChatDetailPageController _cdpc=Get.put(ChatDetailPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Coloors.greyLight,
        backgroundColor: const Color.fromARGB(255, 255, 251, 254),
        surfaceTintColor: const Color.fromARGB(255, 255, 251, 254),
        title: Obx(() => Row(children: [
            ImgFromNet(imageUrl: _cdpc.userImageUrl.value, height: 40, width: 40, boxShape: BoxShape.circle,color: Coloors.greyLight,),
            Padding(padding: const EdgeInsets.only(left:10,top:5),child:Text(_cdpc.name.value,style: const TextStyle(fontSize: 18),)),
            const Spacer(),
          ],
        )),
      ),
      body: Column(children: [
        Expanded(
        child: EasyRefresh(
          header: FootAndHeader.header,
          footer: const ClassicFooter(
            hitOver: true,
            showText: F,
            processedDuration: Duration(seconds: 1),
          ),
          canLoadAfterNoMore: true,
          //canRefreshAfterNoMore: true,
          controller: _cdpc.refreshController,
          onLoad: ()async{
            await _cdpc.getHistory(10);
          },
          child:Obx(() => MasonryGridView.builder(
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              // 元素总个数
              itemCount: _cdpc.messages.length>10?_cdpc.messages.length:10,
              reverse: T,
              // 单个子元素
              itemBuilder: (BuildContext context, int index) => message(context,index),
              // // 纵向元素间距MasonryGridView
              //mainAxisSpacing: 25,
              // // 横向元素间距
              // crossAxisSpacing: 10,
              //shrinkWrap: true, //收缩，让元素宽度自适应
              controller: _cdpc.scrollController,
              //physics: AlwaysScrollableScrollPhysics(),
            )
          ))
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, bottom: 20, top: 10),
          height: 80,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  maxLines: 1,
                  maxLength: 100,
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: "输入信息...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
                  controller: _cdpc.controller,
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 5,bottom: 5,right: 15,left: 15),child: FloatingActionButton(
                onPressed: _cdpc.send,
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
      ],)
    );
  }

  message(context, index) {
    int len=_cdpc.messages.length;
    if(index<10-len){//填充空白
      return const SizedBox(
        height: 65,
      );
    }
    if(len<10) index=index-10+len;
    return Container(
      padding: const EdgeInsets.only(
          left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
          alignment:
              (_cdpc.messages[index].messageType == Status.receiver
                  ? Alignment.topLeft
                  : Alignment.topRight),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (_cdpc.messages[index].messageType == Status.receiver
                    ? Colors.grey.shade200
                    : Coloors.mainLight.withAlpha(140)),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                _cdpc.messages[index].messageContent,
                style: const TextStyle(fontSize: 15),
              ))),
    );
  }
}
