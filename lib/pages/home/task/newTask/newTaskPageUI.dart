
import 'package:client_application/components/button/horizontalButton.dart';
import 'package:client_application/components/button/littleButton.dart';
import 'package:client_application/components/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/display/shortHeadBar.dart';
import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/components/img/imgFromLocal.dart';
import 'package:client_application/components/img/imgPicker.dart';
import 'package:client_application/pages/home/task/newTask/newTaskPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class NewTaskPage extends StatelessWidget{
  final NewTaskPageController _ntpc=Get.put<NewTaskPageController>(NewTaskPageController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("发布",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),),
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
        ),
      body: Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal:40),
        alignment: Alignment.center,
        child: ListView(children: [
          TextFormField(
            controller: _ntpc.titleInputController.value,
            cursorColor: Coloors.main,
            onChanged: (value) {
              _ntpc.titleInputController.value.text = value;
              _ntpc.titleInputController.refresh();
            },
            maxLines: 1,
            maxLength: 30,
            decoration: InputDecoration(
              counterText: "",
              suffixText: "${_ntpc.titleInputController.value.text.length}/30",
              hintText: "标题",
              hintStyle: const TextStyle(color: Color.fromARGB(255, 115, 115, 115),fontSize: 16,fontWeight: FontWeight.normal,),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              suffixIcon: _ntpc.titleInputController.value.text.isEmpty?null: IconButton(
                  onPressed: () {
                    //清空输入框
                    _ntpc.titleInputController.value.clear();
                    _ntpc.titleInputController.refresh();
                  },
                  icon:const Icon(Icons.clear,color: Colors.grey,),
                ),
            ),
          ),

          const Padding(padding: EdgeInsets.symmetric(vertical: 10),child:Divider(height:0.2,indent:0,endIndent: 0,color: Coloors.greyLight,),),

          content(150, false, const EdgeInsets.only(bottom: 10),_ntpc.focusNodeOfNotFull),
          Row(children: [
            Padding(padding: const EdgeInsets.symmetric(),child:LittleButton(text: "标签", onTap: _ntpc.addTag, icon: Icons.tag,color: const Color.fromARGB(255, 245, 245, 245),),),
            const Spacer(),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child:Text("${_ntpc.contentInputController.value.text.length}/300"),),
            Padding(padding: const EdgeInsets.symmetric(),child:LittleButton(text: "", onTap: BottomSheetOfFullInput, icon: Icons.fullscreen,color: const Color.fromARGB(255, 245, 245, 245),),),
          ],),
          const Padding(padding: EdgeInsets.only(top: 20,bottom: 10),child:Divider(height:0.2,indent:0,endIndent: 0,color: Coloors.greyLight,),),
          HorizontalButton(text: _ntpc.locationName.value==""?"添加地点":_ntpc.locationName.value, icon: Icons.place_outlined, onTap: BottomSheetOfLocation),
          HorizontalButton(text: _ntpc.date.value==""?"添加截止时间":"${_ntpc.date.value}前", icon: Icons.schedule_outlined, onTap: ()=>BottomSheetOfTime(context)),
          Padding(padding: const EdgeInsets.symmetric(vertical:10),
            child:SizedBox(
              height: 100,
              child: MasonryGridView.builder(
                // 展示1行
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                // 元素总个数
                itemCount:  _ntpc.imgs.length>=9?_ntpc.imgs.length:_ntpc.imgs.length+1,
                // 单个子元素
                itemBuilder: (BuildContext context, int index) => index==_ntpc.imgs.length?
                    InkWell(
                      onTap: ()=>_ntpc.imgs.length>=9?
                          snackbar.warnning("警告", "超出上传图片最大数量"):
                          ImgPacker.all(_ntpc.imgs),
                      child:Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(color: Color.fromARGB(255, 192, 191, 191)),
                        alignment: Alignment.center,
                        child: const Icon(Icons.add,size: 60,color: Colors.white,),
                      )
                    ):
                    ImgFromLocal(image: _ntpc.imgs[index], size: 100,close: () {
                      _ntpc.imgs.remove(_ntpc.imgs[index]);
                      _ntpc.imgs.refresh();
                    },),
                
                mainAxisSpacing: 10,
                scrollDirection: Axis.horizontal,
              ),),
            ),
          Text("${_ntpc.imgs.length.toString()}/9",style: const TextStyle(fontSize: 14,color:Coloors.greyDeep),)
        ],)
      ),),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        height: 70,
        child:Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child:TextButton(
          onPressed: _ntpc.upload,
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Coloors.main),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
          ), 
          child: const Text("发布",style: TextStyle(fontSize: 20),)
        ),)
      )
    );
  }
  List<Widget> images(){
    List<Widget> res=[];
    for(XFile? i in _ntpc.imgs){
      res.add(Padding(padding: const EdgeInsets.symmetric(horizontal: 5),child: ImgFromLocal(image: i, size: 100,),));
    }
    return res;
  }

  Widget content(double? height,bool autfocus,EdgeInsetsGeometry padding,FocusNode? focusNode){
    return Container(
      height: height,
      padding: padding,
      child:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: TextFormField(
          controller: _ntpc.contentInputController.value,
          cursorColor: Coloors.main,
          autofocus: autfocus,
          focusNode: focusNode,
          onChanged: (value) {
            _ntpc.contentInputController.value.text = value;
            _ntpc.contentInputController.refresh();
          },
          style: const TextStyle(
            fontSize: 16,
            color: Coloors.greyDeep
          ),
          maxLines: null,
          maxLength: 300,
          decoration: const InputDecoration(
            counterText: "",
            hintText: "内容",
            hintStyle: TextStyle(color: Color.fromARGB(255, 115, 115, 115),fontSize: 16,fontWeight: FontWeight.normal,),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            
          ),
        ),
      )
    );
  }

  void BottomSheetOfFullInput(){
    _ntpc.isFull.value=T;
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(Get.context!).size.height * 0.53, // 设置高度为屏幕高度的0.53
    
        padding: const EdgeInsets.only(top:10,left: 20,right: 20,bottom: 15),
        child: Column(children: [
          const ShortHeadBar(),
          //const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Expanded(child: content(null, true, const EdgeInsets.symmetric(vertical: 10),_ntpc.focusNodeOfFull)),

          Row(children: [
            Padding(padding: const EdgeInsets.symmetric(),child:LittleButton(text: "标签", onTap: _ntpc.addTag, icon: Icons.tag, ),),
            const Spacer(),
            Obx(() => Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child:Text("${_ntpc.contentInputController.value.text.length}/300"),),),
            Padding(padding: const EdgeInsets.symmetric(),child:LittleButton(text: "", onTap: (){Get.back();FocusScope.of(Get.context!).requestFocus(FocusNode());}, icon: Icons.fullscreen_exit, ),),
          ],),
          const Padding(padding: EdgeInsets.only(top: 20,bottom: 10),child:Divider(height:0.2,indent:0,endIndent: 0,color: Coloors.greyLight,),),
          Row(children: [
            const Spacer(),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 5),child: TextButtonWithNoSplash(onTap: (){Get.back();FocusScope.of(Get.context!).requestFocus(FocusNode());}, text: "完成",fontSize: 16,color: Coloors.main,),)
          ],)

        ])
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    ).whenComplete(() {
      _ntpc.isFull.value=F;
    });
  }
  void BottomSheetOfTime(BuildContext context){
    var v=DateTime.now();
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top:10,left: 20,right: 20),
        child: Column(children: [
          const ShortHeadBar(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(children: [
            Padding(padding: const EdgeInsets.only(left: 0),child:TextButton(
              onPressed: (){Get.back();},
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Coloors.greyLight),
                foregroundColor: const MaterialStatePropertyAll(Colors.black),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ), 
              child: const Text("取消")
            )),
            const Spacer(),
            Padding(padding: const EdgeInsets.only(right: 0),child:TextButton(
              onPressed: (){
                _ntpc.date.value="截止至${v.year}-${v.month}-${v.day} ${v.hour}:${v.minute}";
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Coloors.main),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ), 
              child: const Text("完成")
            ))
          ],),

          Expanded(child: CupertinoDatePicker(
            initialDateTime: v,
            onDateTimeChanged: (value) => v=value,
            mode:CupertinoDatePickerMode.dateAndTime,
            use24hFormat: T,
            minimumDate: v.add(const Duration(days: -1)),
            maximumDate: DateTime(2100,12,31,23,59,59),
          ))
        ])
      ),
      backgroundColor: Colors.white,
    ).whenComplete((){
      printInfo(info:"time弹窗结束:${_ntpc.time.value.toString()}");
    });
  }
  void BottomSheetOfLocation(){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top:10,left: 20,right: 20),
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
              onPressed: (){_ntpc.searchAddress();FocusScope.of(Get.context!).requestFocus(FocusNode());},
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
                  _ntpc.locationName.value=_ntpc.POIS[index]['name'];
                  printInfo(info:"latitude:${_ntpc.latitude.value} longitude:${_ntpc.longitude.value}");
                  Get.back();
                },
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
                ],),
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
      printInfo(info:"location弹窗结束");
      _ntpc.POIS=RxList();
      _ntpc.cityInputController.value.clear();
      _ntpc.addressInputController.value.clear();
      _ntpc.cityInputController.refresh();
      _ntpc.addressInputController.refresh();
    });
  }
}