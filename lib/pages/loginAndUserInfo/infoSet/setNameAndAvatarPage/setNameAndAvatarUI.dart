
import 'package:client_application/components/common/button/squareTextButton.dart';
import 'package:client_application/components/common/display/bottomSheet.dart';
import 'package:client_application/components/common/input/textField.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setNameAndAvatarPage/setNameAndAvatarController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//设置头像和用户名，注册时用
class SetNameAndAvatarPage extends StatelessWidget {
  final SetNameAndAvatarController _saac=Get.put(SetNameAndAvatarController());
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 300.w, vertical: 20.h),
            child: const Text(
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
            onTap: ImagePickerTypeBottomSheet(context: context,openGallery: _saac.openGallery,takePhoto: _saac.takePhoto).create,
            child: Obx(()=>_saac.imageView()),
          ),




          SizedBox(height: 60.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 200.w, vertical: 10.h),
            child: Obx(()=>UserTextFieldWidget(
              controller: _saac.usernameController.value,
              onChanged: (value) {
                _saac.usernameController.value.text = value;
                _saac.usernameController.refresh();
              },
              readOnly: false,
              keyboardType: TextInputType.name,
              obscureText: true,
              maxLength: 16,
              textInputAction: TextInputAction.done,
              //TODO:
              onEditingComplete:
                  _saac.canNext(),
              hintText: "请输入用户名",
              suffixIconConstraints: BoxConstraints(minHeight: 22.h),
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
            padding: EdgeInsets.symmetric(horizontal: 200.w, vertical: 30.h),
            child: Obx(()=>SquareTextButton(
                text: "下一步",
                onTap:
                    _saac.canNext()))));
  }

  
}
