import 'package:client_application/components/common/input/searchBar.dart';
import 'package:client_application/components/task/taskItem.dart';
import 'package:client_application/pages/home/task/taskPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: TaskItem(
                  ontap: _tpc.tapTask,
                  title: "星穹铁道：银狼问问啊里那些有趣的细节！和崩坏我梦幻联动，电玩音游",
                  point: 25.0,
                  time: "2022-01-01\n12:00",
                  location: "2km以内",
                  labels: "崩坏：星穹铁道 | 崩坏：星穹铁道 | 崩坏：星穹铁道 | 崩坏：星穹铁道 | 崩坏：星穹铁道",
                  hotValue: 114514,
                ),
              )
            ],
          )
        )
      );
  }
}
