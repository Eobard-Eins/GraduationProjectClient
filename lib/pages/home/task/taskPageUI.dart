
import 'package:client_application/components/text/searchBar.dart';
import 'package:client_application/components/item/taskItem.dart';
import 'package:client_application/pages/home/task/taskPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:easy_refresh/easy_refresh.dart';

class TaskPage extends StatelessWidget {
  final TaskPageController _tpc = Get.put<TaskPageController>(TaskPageController());
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
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 20,right:20,bottom: 15),
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(children: [
                  const Text(
                    '首页',
                    style: TextStyle(
                        fontFamily: 'SmileySans',
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.only(top: 5,right: 10),
                    iconSize: 50,
                    highlightColor: Colors.transparent,
                    onPressed: _tpc.gotoAddNewTask,
                    icon: const Icon(
                      Icons.add_circle_outlined,
                      color: Coloors.main,
                    ))
                ])),
            //const Divider(height: 1,color: Coloors.greyLight,),
        
            //搜索栏
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // 阴影颜色
                    offset: const Offset(0.0, 4.0), // 阴影偏移量
                    blurRadius: 8.0, // 阴影模糊半径
                    spreadRadius: 2.0, // 阴影扩散半径
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right:15),
                    child: Obx(()=>InkWell(
                      onTap: _tpc.gettingLocation.value?_tpc.stopLocation:_tpc.getLocation,
                      highlightColor: Colors.transparent, // 透明色
                      splashColor: Colors.transparent,
                      child: _tpc.gettingLocation.value?const Row(
                        children: [
                          Padding(padding: EdgeInsets.only(right: 5)),
                          SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              color: Coloors.main,
                              strokeWidth: 3,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 5)),
                          Text("定位中",style: TextStyle(
                            fontSize: 16
                          ),)
                        ],
                      ):Row(children: [
                        const Icon(Icons.place,color: Coloors.main,),
                        Text(_tpc.location.value,style: const TextStyle(
                          fontSize: 16
                        ),)
                      ],),))
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(() => SearchInput(
                      controller: _tpc.searchController.value, 
                      height: 40, 
                      hintText: " 搜索",
                      onChanged: (value) {
                        _tpc.searchController.value.text=value;
                        _tpc.searchController.refresh();
                      },
                      prefixIconFunc: _tpc.search,
                      suffixIcon: _tpc.searchController.value.text.isEmpty?null:
                      IconButton(
                        onPressed: () {
                              //清空输入框
                              _tpc.searchController.value.clear();
                              _tpc.searchController.refresh();
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),
                          ),
                    )
                  ),),
                  
                  Container(
                    padding: const EdgeInsets.only(left: 5,right:5),
                    child: IconButton(
                      onPressed: dialog,
                      icon: const Icon(Icons.filter_alt,color: Coloors.greyDeep,),
                    )
                  )
                ],
              ),
            ),
            
            
            Expanded(
              child: EasyRefresh(
                  header: const ClassicHeader(
                    hitOver: true,
                    processedDuration: Duration(seconds: 1),
                    showMessage: false,
        
                    processingText: "正在刷新...",
                    readyText: "正在刷新...",
                    armedText: "释放以刷新",
                    dragText: "下拉刷新",
                    processedText: "刷新成功",
                    failedText: "刷新失败",
                    noMoreText: "没有更多了",
                  ),
                  footer: const ClassicFooter(
                    hitOver: true,
                    processedDuration: Duration(seconds: 1),
                    showMessage: false,
                    //文本配置
                    processingText: "正在刷新...",
                    readyText: "正在刷新...",
                    armedText: "释放以刷新",
                    dragText: "下拉刷新",
                    processedText: "刷新成功",
                    failedText: "刷新失败",
                    noMoreText: "没有更多了",            
                  ),
                  //canLoadAfterNoMore: true,
                  canRefreshAfterNoMore: true,
                  refreshOnStart: true,
                  controller: _tpc.refreshController,
                  onRefresh: ()async{
                    await _tpc.loadData(0,refresh:true);
                  },
                  onLoad: ()async{
                    await _tpc.loadData(0);
                  },
                  child:Obx(() => MasonryGridView.builder(
                      // 展示几列
                      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      // 元素总个数
                      itemCount: _tpc.tasks.length,
                      // 单个子元素
                      itemBuilder: (BuildContext context, int index) => TaskCard(context,index),
                      // // 纵向元素间距MasonryGridView
                      //mainAxisSpacing: 25,
                      // // 横向元素间距
                      // crossAxisSpacing: 10,
                      //本身不滚动，让外面的singlescrollview来滚动
                      //physics:physics, 
                      shrinkWrap: true, //收缩，让元素宽度自适应
                      controller: _tpc.scrollController,
                      
                    )
                  ))
            ),
          ],
        )
      );
  }
  Widget TaskCard(context,int index){
    //printInfo(info:"TaskItem $index Created");
    var ti=_tpc.tasks[index];
    return TaskItem(
      ontap: (){
        _tpc.tapTask(ti.id);
      },
      title: ti.title,
      point: ti.point,
      time: ti.time,
      location: ti.location,
      labels: ti.labels,
      hotValue: ti.hotValue,
    );
  }

  void dialog(){
    Get.defaultDialog(
      backgroundColor: Colors.white,
      content: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20,bottom: 25),
            child: const Text(
              "距离:",
              style: TextStyle(
                fontFamily: "SmileySans",
                fontSize: 20
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child:Row(
              children: [
                const Text("0Km",style: TextStyle(fontFamily: 'SmileySans',fontSize: 14,letterSpacing: 1),),
                Obx(()=>Slider(
                  //Slider的当前的值  0.0 ~ 1.0
                  value: _tpc.distance.value,
                  min: 0.0,
                  max: 50.0,
                  //平均分成的等分
                  divisions: 100,
                  //滚动时会回调
                  onChanged: (double value) {
                    _tpc.distance.value = value;
                  },
                  //滑块以及滑动左侧的滚动条颜色
                  activeColor: Coloors.mainLight,
                  thumbColor: Coloors.main,
                  //滑块右侧的滚动条颜色
                  inactiveColor: Coloors.grey,
                  //气泡
                  label: _tpc.distance.value==50?"无限制":(_tpc.distance.value==0?"<100m":"${_tpc.distance.value.toStringAsFixed(1)}Km"),
                )),
                const Text("无限制",style: TextStyle(fontFamily: 'SmileySans',fontSize: 14,letterSpacing: 1),),
              ],
            )
          
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Divider(height: 0.1)
        ],
      ),
      confirm: InkWell(
        onTap: _tpc.alterConfirm,
        highlightColor: Colors.transparent, // 透明色
        splashColor: Colors.transparent,
        child:Container(
          width: 130,
          height: 30,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: const Text("完成",style: TextStyle(fontFamily: 'SmileySans',fontSize: 18,letterSpacing: 1),),
        ),
      ),
      cancel: InkWell(
          onTap: (){
            Get.back();
          },
          highlightColor: Colors.transparent, // 透明色
          splashColor: Colors.transparent,
          child:Container(
            width: 130,
            height: 30,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text("取消",style: TextStyle(fontFamily: 'SmileySans',fontSize: 18,letterSpacing: 1),),
          ),
      ),
      title:"筛选",
      titleStyle: const TextStyle(
        
        letterSpacing: 2,
        fontSize: 30,
      )
    );
  }
}
