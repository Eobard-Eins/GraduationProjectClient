
import 'package:client_application/components/common/button/squareTextButton.dart';
import 'package:client_application/components/common/display/bottomSheet.dart';
import 'package:client_application/components/common/display/optionInSheet.dart';
import 'package:client_application/components/common/input/textField.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';

//设置头像和用户名，注册时用
class SetNameAndAvatarPage extends StatefulWidget {
  const SetNameAndAvatarPage({super.key});

  @override
  State<SetNameAndAvatarPage> createState() => _SetNameAndAvatarPageState();
}

class _SetNameAndAvatarPageState extends State<SetNameAndAvatarPage> {

  late TextEditingController _usernameController;

  //选取图片方式的弹窗触发函数
  imagePickerTypeBottomSheet(){
    return BottomSelectSheet(
      context: context,
      title: "选择图片", options: [
      OptionInSheet(text: "从相册选择", icon: const Icon(Icons.photo_library,color: Coloors.greryDeep,), onTap: ()=>imagePickerTypeBottomSheet()),
      OptionInSheet(text: "拍照", icon: const Icon(Icons.camera_sharp,color: Coloors.greryDeep,), onTap: ()=>imagePickerTypeBottomSheet()),
    ]).create();
  }
  
  @override
  void initState() {
    _usernameController=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

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
              color: Coloors.purple,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
      body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
              child:Text(
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
              onTap: imagePickerTypeBottomSheet,
              child:Container(
                padding: const EdgeInsets.all(26),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Coloors.greyLight,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(bottom:3,right:3),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    color: Coloors.greyDark,
                    size:48,
                  )
                )
              ),
            ),

            
            const SizedBox(height:30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
              child: UserTextFieldWidget(
                controller: _usernameController,
                onChanged: (value) {
                  setState(() {
                    _usernameController.text = value;
                  });
                },
                readOnly: false,
                keyboardType: TextInputType.name,
                obscureText: true,
                maxLength: 16,
                textInputAction: TextInputAction.done,
                //TODO: 
                onEditingComplete: _usernameController.text.isNotEmpty?onTapNext:null,
                hintText: "请输入用户名",
                suffixIconConstraints: const BoxConstraints(minHeight: 22),
                suffixIcon: _usernameController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          //清空输入框
                          _usernameController.clear();
                          setState(() {
                            _usernameController.clear();
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            

          ]
        ),
      //下一步
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          child:SquareTextButton(text: "下一步", onTap: _usernameController.text.isNotEmpty?onTapNext:null)
        )
    );
  }

  void onTapNext() {
    print("next");
  }
}