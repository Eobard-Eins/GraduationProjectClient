
import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/components/img/imgOfNineSquareGrid.dart';
import 'package:client_application/pages/home/task/taskInfo/taskInfoPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskInfoPage extends StatelessWidget{
  final TaskInfoPageController _tipc=Get.put<TaskInfoPageController>(TaskInfoPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Coloors.greyLight,
        backgroundColor: const Color.fromARGB(255, 255, 251, 254),
        surfaceTintColor: const Color.fromARGB(255, 255, 251, 254),
        title: Obx(() => Row(children: [
            ImgFromNet(imageUrl: _tipc.avatar.value, height: 40, width: 40, boxShape: BoxShape.circle,color: Coloors.greyLight,),
            Padding(padding: const EdgeInsets.only(left:10,top:5),child:Text(_tipc.username.value==""?"加载中...":_tipc.username.value,style: const TextStyle(fontSize: 18),)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: InkWell(
                onTap: () {},
                highlightColor: Colors.transparent, // 透明色
                splashColor: Colors.transparent,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(width: 1.0, color: Coloors.main), // 描边颜色和宽度
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    // 如果需要，可以设置背景色填充
                    // color: Colors.transparent,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                  child: const Text("私信", style: TextStyle(fontSize: 14,color: Coloors.main)),
                ),
              ),
            )
          ],
        ),)
      ),
      body: Obx(() => Container(
        //decoration: BoxDecoration(color: Colors.red),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              padding: const EdgeInsets.only(top:10),
              child: _tipc.title.value!=""?Text(_tipc.title.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.start,
              ):Column(children: [
                Padding(padding: const EdgeInsets.only(top: 5),child: Container(height: 20, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),
                Padding(padding: const EdgeInsets.only(top: 10,right: 100),child: Container(height: 20, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),
              ],)
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child:Row(
                children: [
                  const Padding(padding: EdgeInsets.only(right: 10),child: Icon(Icons.schedule_outlined,color: Coloors.greyDeep,size:16),),
                  Expanded(child: 
                    _tipc.date.value.toString()!=""?Text("截止至${_tipc.date.value.toString()}前",style: const TextStyle(
                      fontSize: 12,
                    ),):Padding(padding: const EdgeInsets.only(top: 2,right: 200,bottom: 2),child: Container(height: 10, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),
                      
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding : EdgeInsets.only(top:3,right: 10),child: Icon(Icons.place_outlined,color: Coloors.greyDeep,size:16),),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _tipc.loc.value!=""?[
                      Text(_tipc.loc.value,style: const TextStyle(
                        fontSize: 12,
                      ),),
                      Text(_tipc.locDetail.value,style: const TextStyle(
                        fontSize: 10,
                        color: Coloors.greyDeep,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ]:[
                    Padding(padding: const EdgeInsets.only(top: 3,right: 200),child: Container(height: 10, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),
                    Padding(padding: const EdgeInsets.only(top: 5,right: 100,bottom: 3),child: Container(height: 10, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),
                  ]
                  )),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10,bottom: 10),child:Divider(height:0.1,color: Coloors.greyLight,)),
            Container(
              padding: const EdgeInsets.only(bottom:20,left: 5,right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _tipc.description.value!=""?[
                content()
              ]:[
                Padding(padding: const EdgeInsets.only(top: 8),child: Container(height: 12, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),
                Padding(padding: const EdgeInsets.only(top: 8),child: Container(height: 12, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),
                Padding(padding: const EdgeInsets.only(top: 8),child: Container(height: 12, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),
                Padding(padding: const EdgeInsets.only(top: 8),child: Container(height: 12, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),
                Padding(padding: const EdgeInsets.only(top: 8,right: 200),child: Container(height: 12, padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),decoration: const BoxDecoration(color:Coloors.greyLight),),),        
              ],),
            ),
            
            Padding(padding: const EdgeInsets.only(top:0, bottom: 30),child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ImgOfNineSquareGrid(imgs: _tipc.imgs, size: 330)],
            ),)
          ],
        ),
      ),),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(),
        height: 60,
        child:Column(children: [
            const Padding(padding: EdgeInsets.only(bottom: 5),child:Divider(height:0.1,color: Coloors.greyLight,)),
            Obx(()=>Row(
            children: [
              IconButton(onPressed: _tipc.tapLike, icon: Icon(_tipc.like.value?Icons.thumb_up:Icons.thumb_up_outlined,color:_tipc.like.value?Coloors.red:Coloors.greyDeep),iconSize: 26,),
              const Padding(padding: EdgeInsets.only(left: 2)),
              IconButton(onPressed: _tipc.tapDislike, icon: Icon(_tipc.dislike.value?Icons.thumb_down:Icons.thumb_down_outlined,color:_tipc.dislike.value?Coloors.main:Coloors.greyDeep),iconSize: 26),
              const Padding(padding: EdgeInsets.only(left: 2)),
              IconButton(onPressed: _tipc.tapChat, icon: const Icon(Icons.chat_outlined,color:Coloors.greyDeep),iconSize: 26),
              const Spacer(),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: 180,
                child:TextButton(
                  onPressed: ()=>_tipc.getInfo(1),
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(Coloors.main),
                    foregroundColor: const MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                  ), 
                  child: const Text("接取",style: TextStyle(fontSize: 20),)
                ),),)
            ],
          ))
        ],)
      )
    );
  }

  Widget content(){
    return Text.rich(
      TextSpan(children: SplitFromLabel(_tipc.description.value))
    );
  }

  List<InlineSpan> SplitFromLabel(String input) {
    List<InlineSpan> res=[];
    int start = 0;
    for (String separator in _tipc.labels) {
      var index = input.indexOf(separator, start)-1;
      if (index != -1) {
        if (index > start) {
          res.add(TextSpan(text:input.substring(start, index),style: const TextStyle(fontSize: 14)));
        }
        res.add(TextSpan(text:"#$separator#",style: const TextStyle(fontSize:14,color: Colors.blue)));
        start = index + separator.length+2;
      }
    }
    
    // 处理剩余部分（如果存在）
    if (start < input.length) {
      res.add(TextSpan(text:input.substring(start),style: const TextStyle(fontSize: 14)));
    }

    return res;
  }
}