
import 'package:client_application/components/button/squareTextButton.dart';
import 'package:client_application/components/display/shortHeadBar.dart';
import 'package:client_application/components/text/textField.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setNameAndAvatarPage/setNameAndAvatarController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//设置头像和用户名，注册时用
class SetNameAndAvatarPage extends StatelessWidget {
  final SetNameAndAvatarController _saac=Get.put<SetNameAndAvatarController>(SetNameAndAvatarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "设置头像与用户名",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Coloors.main,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),



        body: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Text(
              "设置头像和用户名，用户名应在3~16个字符之间",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),


          
          GestureDetector(
            onTap: ImagePickerTypeBottomSheet,
            child: Obx(()=>_saac.imageView()),
          ),




          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 0),
            child: Obx(()=>UserTextFieldWidget(
              controller: _saac.usernameController.value,
              onChanged: (value) {
                _saac.usernameController.value.text = value;
                _saac.usernameController.refresh();
              },
              readOnly: false,
              maxLength: 16,
              textInputAction: TextInputAction.done,
              //TODO:
              onEditingComplete:
                  _saac.canNext(),
              hintText: "请输入用户名",
              suffixIconConstraints: const BoxConstraints(minHeight: 22),
              suffixIcon: _saac.usernameController.value.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        //清空输入框
                        _saac.usernameController.value.clear();
                        _saac.usernameController.refresh();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
            ),)
          ),
        ]),
        //下一步
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            child: Obx(()=>SquareTextButton(
                text: "下一步",
                onTap:
                    _saac.canNext()))));
  }
  void ImagePickerTypeBottomSheet(){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top:10,left: 20,right: 20),
        height: 150,
        child: Column(children: [
          const ShortHeadBar(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          Row(children: [
            Expanded(child: InkWell(
              onTap: _saac.openGallery,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                
                child:const Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
                  Icon(
                    Icons.photo_library,
                    color: Coloors.main,
                    size: 50,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  Text("从相册选择")
                ]),
              ),)
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Container(
              height: 40,
              width: 1,
              decoration: const BoxDecoration(color: Color.fromARGB(255, 181, 181, 181)), 
            ),),
            Expanded(child: InkWell(
              onTap:_saac.takePhoto,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                alignment: Alignment.center,
                
                child: const Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
                  Icon(
                    Icons.camera_sharp,
                    color: Coloors.main,
                    size: 50,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  Text("拍照")
                ]),
              ),)
            )
          ],)
            
          ]
        ),
      ),
      backgroundColor: Colors.white
    );
  }
  
}
