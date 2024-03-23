import 'package:client_application/components/button/horizontalButton.dart';
import 'package:client_application/components/button/iconButtonWithText.dart';
import 'package:client_application/components/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/pages/home/me/mePageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class MePage extends StatelessWidget{
  final MePageController _mpc=Get.put(MePageController());
  final List<BoxShadow>? cardShaow=[
    BoxShadow(
      color: Coloors.greyDeep.withOpacity(0.1), // 阴影颜色
      blurRadius: 0.1, // 阴影模糊半径
      spreadRadius: 0.1, // 阴影扩散半径
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(padding: const EdgeInsets.only(top: 20,bottom: 15),
              child:Container(
                
                padding: const EdgeInsets.only(left:10,right: 20,top: 20,bottom: 20),
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    ImgFromNet(imageUrl: _mpc.avatarURL.value,boxShape: BoxShape.circle,width: 65,height: 65,),
                    Padding(padding: const EdgeInsets.only(left: 15),child:Text(_mpc.username.value,style: const TextStyle(fontSize: 24),)),
                    const Spacer(),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("114514",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Text("积分",style: TextStyle(fontSize: 14),)
                        ],
                      ),
                    )
                  ])
              ),
            ),
            const Divider(height: 0.1,color: Coloors.greyLight,indent: 20,endIndent: 20,),

            Padding(padding: const EdgeInsets.only(top: 10,bottom: 10),
              child:Container(
                
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: Column(children: [
                  Padding(padding: const EdgeInsets.only(bottom: 20,left: 5,right: 5),child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("我发布的",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      const Spacer(),
                      TextButtonWithNoSplash(onTap: (){}, text: "所有 >",textStyle: const TextStyle(color: Coloors.greyDeep,fontSize: 14),)
                  ],),),
                  
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButtonWithText(icon: Icons.ad_units, str: "待被接取",fontSize: 12,),
                      IconButtonWithText(icon: Icons.ad_units, str: "已被接取",fontSize: 12,),//确认接取环节
                      IconButtonWithText(icon: Icons.ad_units, str: "正被处理",fontSize: 12,),
                      IconButtonWithText(icon: Icons.ad_units, str: "处理完成",fontSize: 12,),//确认完成和评价环节
                    ],))
                ],)
              ),
            ),
            

            Padding(padding: const EdgeInsets.only(bottom: 20),
              child:Container(
                
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: Column(children: [
                  Padding(padding: const EdgeInsets.only(bottom: 20,left: 5,right: 5),child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("我接取的",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      const Spacer(),
                      TextButtonWithNoSplash(onTap: (){}, text: "所有 >",textStyle: const TextStyle(color: Coloors.greyDeep,fontSize: 14),)
                  ],),),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20),child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButtonWithText(icon: Icons.ad_units, str: "申请接取",fontSize: 12,),
                      IconButtonWithText(icon: Icons.ad_units, str: "正在处理",fontSize: 12,),//允许处理
                      IconButtonWithText(icon: Icons.ad_units, str: "处理完成",fontSize: 12,),
                    ],))
                ],)
              ),
            ),

            Padding(padding: const EdgeInsets.only(),child:Container(
              
              padding: const EdgeInsets.only(left: 20,right: 10,top: 20),
              child:Column(children: [
                HorizontalButton(text: "历史记录", icon: Icons.history, onTap: (){}),
                HorizontalButton(text: "设置", icon: Icons.settings_outlined, onTap: (){}),
                HorizontalButton(text: "关于", icon: Icons.info_outlined, onTap: _mpc.gotoAboutPage,needDivider: false,),
              ],)
            ))
          ],
        )
      )),
    );
  }

}