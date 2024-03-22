
import 'package:client_application/components/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/button/loginButton.dart';
import 'package:client_application/components/text/textField.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginWithPasswordPage/loginWithPasswordPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/tool/input/filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//登录页面，使用密码登录
class LoginWithPasswordPage extends StatelessWidget {
  final LoginWithPasswordPageController _lwppc=Get.put<LoginWithPasswordPageController>(LoginWithPasswordPageController());

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [ Color.fromARGB(255, 245, 241, 226),Color.fromARGB(255, 228, 218, 245), Color.fromARGB(255, 225, 238, 244)],
        ), 
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          //标题
          title: const Padding(padding: EdgeInsets.only(top:30),child: Text(
            "使用密码登录",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 30,
              fontFamily: 'SmileySans',
              color: Coloors.main,
            ),
            textAlign: TextAlign.center,
          ),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            //账号输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: Obx(()=>UserTextFieldWidget(
                controller: _lwppc.mailController.value,
                onChanged: (value){_lwppc.mailController.value.text = InputFilter.FilterEmail(value);},
                readOnly: false,
                keyboardType: TextInputType.emailAddress,
                //textInputAction: TextInputAction.next,
                hintText: "请输入邮箱",
                suffixIcon: _lwppc.mailController.value.text.isEmpty?null:IconButton(
                        onPressed: () {
                          //清空输入框
                          _lwppc.mailController.value.clear();
                          _lwppc.mailController.refresh();
                        },
                        icon: const Icon(Icons.clear,color: Colors.grey,),
                      ),
              ),)
            ),
            //密码输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 0),
              child: Obx(()=>UserTextFieldWidget(
                controller: _lwppc.passwordController.value,
                onChanged: (value){_lwppc.passwordController.value.text = InputFilter.FilterPassword(value);},
                readOnly: false,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _lwppc.obscure.value,
                maxLength: 16,
                textInputAction: TextInputAction.done,
                //TODO: 
                onEditingComplete: _lwppc.canLogin(),
                hintText: "请输入密码",
                suffixIconConstraints: const BoxConstraints(minHeight: 22),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      IconButton(
                        onPressed: _lwppc.mailController.value.text.isEmpty?null:_lwppc.changeObscure,
                        icon: Icon(_lwppc.obscure.value?Icons.visibility_off:Icons.visibility,color:_lwppc.passwordController.value.text.isEmpty?Colors.transparent: Colors.grey,),
                      ),
                    TextButtonWithNoSplash(onTap: _lwppc.forgetPassword,text: "忘记密码",fontSize: 16,color: Coloors.main,),
                ],),
              ),)
            ),
            
            //文字按钮，链接到验证码登录页和注册页
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButtonWithNoSplash(onTap: _lwppc.onTapLoginByCaptcha,text: "验证码登录"),
                  TextButtonWithNoSplash(onTap: _lwppc.onTapRegister, text: "注册"),
                ]
              ),
            ),
            
            
            Obx(()=>LoginButton(onPressed: _lwppc.canLogin()),)

            
          ],
        ),
        
      ),
    );
    
        
  }
  

}
