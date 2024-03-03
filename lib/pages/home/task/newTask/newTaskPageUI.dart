import 'package:client_application/components/display/shortHeadBar.dart';
import 'package:client_application/pages/home/task/newTask/newTaskPageController.dart';
import 'package:client_application/pages/home/task/taskInfo/taskInfoPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class NewTaskPage extends StatelessWidget{
  final NewTaskPageController _ntpc=Get.put<NewTaskPageController>(NewTaskPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        ),
      body: Container(
        padding: EdgeInsets.only(top:0),
        alignment: Alignment.center,
        child: TextButton(
          onPressed: BottomSheet,
          child: Text("搜索地址",style: TextStyle(color: Coloors.mainDark,fontSize: 20),),
        ),
      ),
    );
  }

  void BottomSheet(){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top:10,left: 20,right: 20),
        height: 600,
        child: Column(children: [
          const ShortHeadBar(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(children: [
            const Padding(padding: EdgeInsets.only(left: 10)),
            Expanded(
              flex: 80,
              child: TextField(
                controller: _ntpc.cityInputController.value,
                cursorColor: Coloors.main,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: "城市",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 115, 115, 115),fontSize: 16,fontWeight: FontWeight.normal,),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 115, 115, 115)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 115, 115, 115)),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Container(
              height: 20,
              width: 1,
              decoration: const BoxDecoration(color: Color.fromARGB(255, 181, 181, 181)), 
            ),),
          
            Expanded(
              flex: 220,
              child: TextField(
                controller: _ntpc.addressInputController.value,
                cursorColor: Coloors.main,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: "请输入详细地址",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 115, 115, 115),fontSize: 16,fontWeight: FontWeight.normal),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 115, 115, 115)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 115, 115, 115)),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 10),child:TextButton(
              onPressed: _ntpc.searchAddress,
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Coloors.main),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ), 
              child: const Text("搜索")
            ))
          ],),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Obx(() => Expanded(child: MasonryGridView.builder(
            // 展示几列
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,

            ),
            // 元素总个数
            itemCount: _ntpc.POIS.length,
            // 单个子元素
            itemBuilder: (BuildContext context, int index){
              return InkWell(
                highlightColor: Colors.transparent, // 透明色
                splashColor: Colors.transparent,
                onTap:(){
                  _ntpc.longitude.value=_ntpc.POIS[index]['longitude'];
                  _ntpc.latitude.value=_ntpc.POIS[index]['latitude'];
                  printInfo(info:"latitude:${_ntpc.latitude.value} longitude:${_ntpc.longitude.value}");
                  Get.back();
                },
                child: Container(
                  child: Column(children: [
                      const Padding(padding: EdgeInsets.only(bottom: 5)),
                      Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(right: 10),child: Icon(Icons.place_outlined,color: Coloors.grey,size:25),),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_ntpc.POIS[index]['name'],style: const TextStyle(
                              fontSize: 18,

                            ),),
                            Text(_ntpc.POIS[index]['address'],style: const TextStyle(
                              fontSize: 14,
                              color: Coloors.grey,
                            ),),
                          ],)),
                        const Padding(padding: EdgeInsets.only(left: 5,right: 5),child: Icon(Icons.near_me_outlined,color: Coloors.grey,size:20),),
                      ],
                    ),
                    index==_ntpc.POIS.length-1?const Padding(padding: EdgeInsets.only(top: 10)):
                      const Padding(padding: EdgeInsets.only(top: 10),child:Divider(height:0.2,indent:15,endIndent: 15,color: Coloors.greyLight,),),
                  ],)
                ),
              );
            },
            // // 纵向元素间距MasonryGridView
            //mainAxisSpacing: 25,
            // // 横向元素间距
            // crossAxisSpacing: 10,
            //本身不滚动，让外面的singlescrollview来滚动
            //physics:const NeverScrollableScrollPhysics(), 
            shrinkWrap: true, //收缩，让元素宽度自适应
            
          ),),)
        ]),
      ),
      backgroundColor: Colors.white,
    ).whenComplete((){
      printInfo(info:"弹窗结束");
      _ntpc.POIS=RxList();
      _ntpc.cityInputController.value.clear();
      _ntpc.addressInputController.value.clear();
      _ntpc.cityInputController.refresh();
      _ntpc.addressInputController.refresh();
    });
  }
}