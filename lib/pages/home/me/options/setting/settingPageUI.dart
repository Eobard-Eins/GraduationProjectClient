import 'package:client_application/components/button/horizontalButton.dart';
import 'package:client_application/components/display/shortHeadBar.dart';
import 'package:client_application/components/img/imgFromLocal.dart';
import 'package:client_application/components/img/imgPicker.dart';
import 'package:client_application/pages/home/me/options/setting/settingPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  final SettingPageController _spc=Get.put(SettingPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("设置"),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
          child: Column(children: [
            HorizontalButton(text: "设置用户名", onTap: _ShowSetUsernameDialog),
            HorizontalButton(text: "设置密码", onTap: _spc.gotoSetPassword),
            HorizontalButton(text: "设置头像",  onTap: _ShowSetAvatarDialog,needDivider: false,),
          ],),
        ),
        const Spacer(),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 50),child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: 180,
          child:TextButton(
            onPressed: _spc.logout,
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Coloors.main),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            ), 
            child: const Text("退出登录",style: TextStyle(fontSize: 18),)
          ),),)
      ],),
    );
  }

  void _ShowSetUsernameDialog(){
    Get.bottomSheet(
      Container(
        height: 200,//???
        padding: const EdgeInsets.only(top:10,left: 20,right: 20,bottom: 5),
        child: Column(children: [
          const ShortHeadBar(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          
          Container(padding: const EdgeInsets.only(top:15,left: 20,right: 20,bottom: 5),
            child: TextField(
              controller: _spc.usernameController.value,
              cursorColor: Coloors.main,
              maxLines: 1,
              maxLength: 8,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "请输入用户名",
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
            
          Row(children: [
            Padding(padding: const EdgeInsets.only(left: 5),child:TextButton(
              onPressed: Get.back,
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                foregroundColor: const MaterialStatePropertyAll(Coloors.greyDeep),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ), 
              child: const Text("取消",style: TextStyle(fontSize:18),)
            )),
            const Spacer(),
            Padding(padding: const EdgeInsets.only(right: 5),child:TextButton(
              onPressed: _spc.setUsername,
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                foregroundColor: const MaterialStatePropertyAll(Coloors.main),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ), 
              child: const Text("确认",style: TextStyle(fontSize:18),)
            )),
          ],)
        ]),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    ).whenComplete(() => _spc.usernameController.value.clear());
  }

  void _ShowSetAvatarDialog(){
    ImgPacker.single(_spc.imgPath,whenComplete: (){
      Get.defaultDialog(
        backgroundColor: Colors.white,
        content: Column(children:[
          Padding(padding: const EdgeInsets.only(left: 40,right: 40,bottom: 30),child:ImgFromLocal(image: _spc.imgPath.value,boxShape: BoxShape.circle,)),
          const Divider(height: 0.1)
        ],),
        confirm: InkWell(
          onTap:_spc.setAvatar,
          highlightColor: Colors.transparent, // 透明色
          splashColor: Colors.transparent,
          child:Container(
            width: 120,
            height: 30,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text("完成",style: TextStyle(fontFamily: 'SmileySans',fontSize: 18,letterSpacing: 1),),
          ),
        ),
        cancel: InkWell(
            onTap: (){
              _spc.imgPath=Rx(null);
              Get.back();
            },
            highlightColor: Colors.transparent, // 透明色
            splashColor: Colors.transparent,
            child:Container(
              width: 120,
              height: 30,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text("取消",style: TextStyle(fontFamily: 'SmileySans',fontSize: 18,letterSpacing: 1),),
            ),
        ),
        title:"",
        titleStyle: const TextStyle(
          letterSpacing: 2,
          fontSize: 30,
        )
      );
    },);
  }
}