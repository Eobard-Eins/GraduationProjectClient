
import 'package:client_application/components/button/squareTextButton.dart';
import 'package:client_application/components/img/avatarFromLocal.dart';
import 'package:client_application/components/img/imgPicker.dart';
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
            onTap: ()=>ImgPacker(_saac.imgPath),
            child: Obx(()=>imageView()),
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
  //头像
  Widget imageView() {
    if (_saac.imgPath.value == null) {
      return Container(
        padding: const EdgeInsets.all(26),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Coloors.greyLight,
        ),
        child: const Padding(
            padding: EdgeInsets.only(bottom: 3, right: 3),
            child: Icon(
              Icons.add_a_photo_rounded,
              color: Coloors.grey,
              size: 48,
            )),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          //设置描边
          border: Border.all(color: Coloors.greyLight, width: 1),
          color: Colors.transparent,
        ),
        child: avatarFromLocal(image: _saac.imgPath.value,size: 50,)
      );
    }
  }
}
