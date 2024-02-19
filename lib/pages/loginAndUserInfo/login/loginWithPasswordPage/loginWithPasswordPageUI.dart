
import 'package:client_application/components/common/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/login/loginButton.dart';
import 'package:client_application/components/common/input/textField.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginWithPasswordPage/loginWithPasswordPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//登录页面，使用密码登录
class LoginWithPasswordPage extends StatelessWidget {
  final LoginWithPasswordPageController _lwppc=Get.put(LoginWithPasswordPageController());

  @override
  Widget build(BuildContext context) {
    _lwppc.init();
    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "使用密码登录",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Coloors.main,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            //账号输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Obx(()=>UserTextFieldWidget(
                controller: _lwppc.phoneController,
                onChanged: (value){_lwppc.phoneControllerText.value=_lwppc.phoneController.text = InputFilter.FilterNum(value);},
                readOnly: false,
                keyboardType: TextInputType.phone,
                //textInputAction: TextInputAction.next,
                hintText: "请输入手机号码",
                suffixIcon: _lwppc.phoneControllerText.value.isEmpty?null:IconButton(
                        onPressed: () {
                          //清空输入框
                          _lwppc.phoneController.clear();
                          _lwppc.passwordControllerText.value="";
                        },
                        icon: Icon(Icons.clear,color: Colors.grey,),
                      ),
              ),)
            ),
            //密码输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
              child: Obx(()=>UserTextFieldWidget(
                controller: _lwppc.passwordController,
                onChanged: (value){_lwppc.passwordControllerText.value=_lwppc.passwordController.text = InputFilter.FilterPassword(value);},
                readOnly: false,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _lwppc.obscure.value,
                maxLength: 16,
                textInputAction: TextInputAction.done,
                //TODO: 
                onEditingComplete: _lwppc.canLogin(),
                hintText: "请输入密码",
                suffixIconConstraints: BoxConstraints(minHeight: 22),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      IconButton(
                        onPressed: _lwppc.phoneControllerText.value.isEmpty?null:_lwppc.changeObscure,
                        icon: Icon(_lwppc.obscure.value?Icons.visibility_off:Icons.visibility,color:_lwppc.passwordControllerText.value.isEmpty?Colors.transparent: Colors.grey,),
                      ),
                    TextButtonWithNoSplash(onTap: _lwppc.forgetPassword,text: "忘记密码",fontSize: 14,color: Coloors.main,),
                ],),
              ),)
            ),
            
            //文字按钮，链接到验证码登录页和注册页
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10), 
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
        
      );
        
  }
  

}
