import 'package:client_application/components/display/footerAndHeader.dart';
import 'package:client_application/components/display/shortHeadBar.dart';
import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/components/item/taskItemBriefly.dart';
import 'package:client_application/models/Task.dart';
import 'package:client_application/pages/home/me/options/myPublish/myPublishPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class MyPublishPage extends StatelessWidget{
  final MyPublishPageController _mppc=Get.put(MyPublishPageController());

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _mppc.initStateNum,
      length: 5,
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
              Tab(text: '待被接取'),
              Tab(text: '正被处理'),
              Tab(text: '处理完成'),
              Tab(text: '已过期'),
            ],
          ),
        ),
        body:TabBarView(
          children: [
            ScrollableList(_mppc.allTasks, Status.getAll,allTasks),
            ScrollableList(_mppc.allTasksOfRequestButNotAccess, Status.taskPublic ,allTasksOfRequestButNotAccess),
            ScrollableList(_mppc.allTasksOfDoing,Status.taskBeAccessed,allTasksOfDoing),
            ScrollableList(_mppc.allTasksOfDone,Status.taskDone,allTasksOfDone),
            ScrollableList(_mppc.allTasksOfTimeout,Status.taskTimeout,allTasksOfTimeout),
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
            await _mppc.loadData(ls ,status, refresh: true);
          },
          onLoad: ()async{
            //_mppc.refreshController.finishLoad(IndicatorResult.noMore);
            await _mppc.loadData(ls ,status);
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
  Widget allTasksOfRequestButNotAccess(int index){
    TaskItemInfo item=_mppc.allTasksOfRequestButNotAccess[index];
    return baseTaskCard([
        TaskItemBriefly.actionButtion("查看所有申请", () => _getAllRequest(item.id))
      ], item);
  }
  Widget allTasksOfDoing(int index){
    TaskItemInfo item=_mppc.allTasksOfDoing[index];
    return baseTaskCard([
        TaskItemBriefly.actionButtion("联系", () => _mppc.tapChat(item.id)),
        TaskItemBriefly.actionButtion("查看详情", () => _mppc.gotoTaskInfoPage(item.id))
      ], item);
  }
  Widget allTasksOfDone(int index){
    TaskItemInfo item=_mppc.allTasksOfDone[index];
    return baseTaskCard([
        TaskItemBriefly.actionButtion("联系", () => _mppc.tapChat(item.id)),
        TaskItemBriefly.actionButtion("查看详情", () => _mppc.gotoTaskInfoPage(item.id))
      ], item);
  }
  Widget allTasksOfTimeout(int index){
    TaskItemInfo item=_mppc.allTasksOfTimeout[index];
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
  void _getAllRequest(int id)async{
    await _mppc.getAllRequestWithTask(id);
    Get.bottomSheet(
      Obx(() => Container(
        padding: const EdgeInsets.only(top:10,left: 20,right: 20),
        child: Column(children: [
          const ShortHeadBar(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          
          Expanded(child: _mppc.us.isEmpty? const Center(child: Text("没有申请"),): MasonryGridView.builder(
            // 展示几列
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,

            ),
            // 元素总个数
            itemCount: _mppc.us.length,
            // 单个子元素
            itemBuilder: (BuildContext context, int index){
              String mail=_mppc.us[index].mailAddress;
              String username=_mppc.us[index].username!;
              String avatar=_mppc.us[index].avatar;
              return Column(children: [
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    Row(
                    children: [
                      Padding(padding: const EdgeInsets.only(left: 7,right: 10),
                        child: ImgFromNet(imageUrl: avatar,boxShape: BoxShape.circle,width: 40,height: 40,),
                      ),
                      Text(username,style: const TextStyle(
                            fontSize: 20,
                          ),),
                      const Spacer(),
                      Padding(padding: const EdgeInsets.only(left: 5,right: 10),
                        child: InkWell(
                          onTap: ()async{await _mppc.accessTaskRequest(mail,id,username);},
                          highlightColor: Colors.transparent, // 透明色
                          splashColor: Colors.transparent,
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border.fromBorderSide(
                                BorderSide(width: 1.0, color: Coloors.main), // 描边颜色和宽度
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              // color: Colors.transparent,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
                            child: const Text("接受申请", style: TextStyle(fontSize: 12,color: Coloors.main)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  index==_mppc.us.length-1?const Padding(padding: EdgeInsets.only(top: 10)):
                    const Padding(padding: EdgeInsets.only(top: 10),child:Divider(height:0.2,indent:15,endIndent: 15,color: Coloors.greyLight,),),
                ],);
            },
            // // 纵向元素间距MasonryGridView
            //mainAxisSpacing: 25,
            // // 横向元素间距
            // crossAxisSpacing: 10,
            //本身不滚动，让外面的singlescrollview来滚动
            //physics:const NeverScrollableScrollPhysics(), 
            shrinkWrap: true, //收缩，让元素宽度自适应
            
          ),),
        ]),
      ),),
      backgroundColor: Colors.white,
    ).whenComplete((){
      printInfo(info:"弹窗结束");
    });
  }
}