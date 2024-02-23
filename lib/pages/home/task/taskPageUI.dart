import 'package:client_application/components/common/input/searchBar.dart';
import 'package:client_application/components/task/taskItem.dart';
import 'package:client_application/pages/home/task/taskPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';


class TaskPage extends StatelessWidget {
  final TaskPageController _tpc = Get.put<TaskPageController>(TaskPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child:Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 45,left: 20,right:20,bottom: 15),
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
                    Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: IconButton(
                            onPressed: _tpc.addNewTask,
                            icon: const Icon(
                              Icons.add_circle_outlined,
                              size: 50,
                              color: Coloors.main,
                            )))
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
                      child: InkWell(
                        onTap: _tpc.search,
                        highlightColor: Colors.transparent, // 透明色
                        splashColor: Colors.transparent,
                        child: const Row(children: [
                          Icon(Icons.place,color: Coloors.main,),
                          Text("定位",style: TextStyle(
                            fontSize: 16
                          ),)
                        ],),)
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
                        onPressed: _tpc.search,
                        icon: const Icon(Icons.filter_alt,color: Coloors.greyDeep,),
                      )
                    )
                  ],
                ),
              ),
              
              //const Divider(height: 1,color: Coloors.greyLight,),
              Expanded(
                child: 
                  RefreshIndicator(
                    onRefresh: _tpc.refreshh,
                    color: Coloors.main,
                    displacement: 30,
                    
                    child: MasonryGridView.builder(
                      // 展示几列
                      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,

                      ),
                      // 元素总个数
                      itemCount: _tpc.tasks.length,
                      // 单个子元素
                      itemBuilder: (BuildContext context, int index) => _tpc.TaskCard(context,_tpc.tasks[index]),
                      // // 纵向元素间距MasonryGridView
                      mainAxisSpacing: 25,
                      // // 横向元素间距
                      // crossAxisSpacing: 10,
                      //本身不滚动，让外面的singlescrollview来滚动
                      //physics:const NeverScrollableScrollPhysics(), 
                      shrinkWrap: true, //收缩，让元素宽度自适应
                      controller: _tpc.scrollController
                    ),
                  )
              ),
            ],
          )
        )
      );
  }
}
