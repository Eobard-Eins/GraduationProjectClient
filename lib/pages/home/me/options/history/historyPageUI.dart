import 'package:client_application/components/display/footerAndHeader.dart';
import 'package:client_application/components/item/taskItemBriefly.dart';
import 'package:client_application/pages/home/me/options/history/historyPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  final HistoryPageController _hpc=Get.put(HistoryPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("历史记录"),
        centerTitle: true,
        shadowColor: Coloors.greyLight,
        backgroundColor: const Color.fromARGB(255, 255, 251, 254),
        surfaceTintColor: const Color.fromARGB(255, 255, 251, 254),
      ),
      body: Expanded(
        child: EasyRefresh(
          header: FootAndHeader.header,
          footer: FootAndHeader.footer,
          //canLoadAfterNoMore: true,
          canRefreshAfterNoMore: true,
          refreshOnStart: true,
          controller: _hpc.refreshController,
          onRefresh: ()async{
            await _hpc.getHistory(6,refresh:true);
          },
          onLoad: ()async{
            await _hpc.getHistory(6);
          },
          child:Obx(() => MasonryGridView.builder(
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              // 元素总个数
              itemCount: _hpc.tasks.length,
              // 单个子元素
              itemBuilder: (BuildContext context, int index) => TaskCardBriefly(context,index),
              // // 纵向元素间距MasonryGridView
              //mainAxisSpacing: 25,
              // // 横向元素间距
              // crossAxisSpacing: 10,
              //本身不滚动，让外面的singlescrollview来滚动
              //physics:physics, 
              //shrinkWrap: true, //收缩，让元素宽度自适应
              controller: _hpc.scrollController,
              
            )
          ))
      ),
    );
  }
  Widget TaskCardBriefly(context,int index){
    //printInfo(info:"TaskItem $index Created");
    var ti=_hpc.tasks[index];
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: TaskItemBriefly(
      onTap: (){
        _hpc.tapTask(ti.id);
      },
      title: ti.title,
      point: ti.point,
      time: ti.time,
      addressName: ti.addressName,
      actions: [
        TaskItemBriefly.actionButtion("查看详情", () => _hpc.tapTask(ti.id))
      ],
    ));
  }
}