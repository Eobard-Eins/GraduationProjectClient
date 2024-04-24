import 'package:client_application/components/display/footerAndHeader.dart';
import 'package:client_application/components/item/taskItemBriefly.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/pages/home/me/options/myAccess/myAccessPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class MyAccessPage extends StatelessWidget{
  final MyAccessPageController _mppc=Get.put(MyAccessPageController());

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _mppc.initStateNum,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: TabBar(
            isScrollable: T,
            indicatorColor: Coloors.main,
            labelColor: Coloors.main,  //选中时颜色
            unselectedLabelColor: Coloors.greyDeep, //未选中时颜色
            tabAlignment: TabAlignment.center,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            tabs: const [
              Tab(text: ' 所有 '),
              //Tab(text: '申请接取'),
              Tab(text: '正在处理'),
              Tab(text: '处理完成'),
              Tab(text: '已逾期'),
            ],
          ),
        ),
        body:TabBarView(
          children: [
            ScrollableList(_mppc.allTasks,Status.getAll,allTasks),
            ScrollableList(_mppc.allTasksOfDoing,Status.taskBeAccessed,allTasksOfDoing),
            ScrollableList(_mppc.allTasksOfDone,Status.taskDone,allTasksOfDone),
            ScrollableList(_mppc.allTasksOfTimeout,Status.taskTimeout,allTasksOfTimeout),
            //ScrollableList(_mppc.allTasks,Status.getAll,allTasks),
          ],
        ),
      ),
    );
  }

  Widget ScrollableList(RxList ls,int status, Function(int) build){
    return EasyRefresh(
          header: FootAndHeader.header,
          footer: FootAndHeader.footer,
          //canLoadAfterNoMore: true,
          canRefreshAfterNoMore: true,
          refreshOnStart: true,
          controller: _mppc.refreshController,
          onRefresh: ()async{
            await _mppc.loadData(ls ,status,refresh: true);
          },
          onLoad: ()async{
            _mppc.refreshController.finishLoad(IndicatorResult.noMore);
          },
          child:Obx(() => MasonryGridView.builder(
              // 展示几列
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,),
              // 元素总个数
              itemCount: ls.length,
              // 单个子元素
              itemBuilder: (BuildContext context, int index)=>build(index),
              //shrinkWrap: true, //收缩，让元素宽度自适应
            ))
      );
  }

  Widget allTasks(int index){
    TaskItemInfo item=_mppc.allTasks[index];
    return baseTaskCard([
        TaskItemBriefly.actionButtion("查看详情", () => _mppc.gotoTaskInfoPage(item.id))
      ], item);
  }
  Widget allTasksOfDoing(int index){
    TaskItemInfo item=_mppc.allTasks[index];
    return baseTaskCard([
        TaskItemBriefly.actionButtion("完成", () => _mppc.finishTask(item.id))
      ], item);
  }
  Widget allTasksOfDone(int index){
    TaskItemInfo item=_mppc.allTasks[index];
    return baseTaskCard([
        TaskItemBriefly.actionButtion("查看详情", () => _mppc.gotoTaskInfoPage(item.id))
      ], item);
  }
  Widget allTasksOfTimeout(int index){
    TaskItemInfo item=_mppc.allTasks[index];
    return baseTaskCard([
        TaskItemBriefly.actionButtion("查看详情", () => _mppc.gotoTaskInfoPage(item.id))
      ], item);
  }
  
  Widget baseTaskCard(List<Widget> children, TaskItemInfo item){
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: TaskItemBriefly(
      title: item.title,
      addressName: item.addressName,
      time: item.time,
      point: item.point,
      actions:children,
      onTap: () => _mppc.gotoTaskInfoPage(item.id),
    ),);
  }
}