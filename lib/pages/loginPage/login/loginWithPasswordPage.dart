// ignore_for_file: prefer_const_constructors

import 'package:client_application/components/common/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/login/loginButton.dart';
import 'package:client_application/components/common/input/textField.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/filter.dart';
import 'package:flutter/material.dart';

//登录页面，使用密码登录
class LoginWithPasswordPage extends StatefulWidget {

  const LoginWithPasswordPage({super.key});

  @override
  State<LoginWithPasswordPage> createState() => _LoginWithPasswordPageState();
}

class _LoginWithPasswordPageState extends State<LoginWithPasswordPage> {

  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  bool _obscure=true;

  @override
  void initState() {
    
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "使用密码登录",
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
            SizedBox(
              height: 30,
            ),
            //账号输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: UserTextFieldWidget(
                controller: _phoneController,
                onChanged: (value){setState(() {_phoneController.text = InputFilter.FilterNum(value);});},
                readOnly: false,
                keyboardType: TextInputType.phone,
                //textInputAction: TextInputAction.next,
                hintText: "请输入手机号码",
                suffixIcon: _phoneController.text.isEmpty?null:IconButton(
                        onPressed: () {
                          //清空输入框
                          _phoneController.clear();
                          setState(() {_phoneController.clear();});
                        },
                        icon: Icon(Icons.clear,color: Colors.grey,),
                      ),
              ),
            ),
            //密码输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
              child: UserTextFieldWidget(
                controller: _passwordController,
                onChanged: (value){setState(() {_passwordController.text = InputFilter.FilterPassword(value);});},
                readOnly: false,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscure,
                maxLength: 16,
                textInputAction: TextInputAction.done,
                //TODO: 
                onEditingComplete: _phoneController.text.isNotEmpty&&_passwordController.text.isNotEmpty?onTapLogin:null,
                hintText: "请输入密码",
                suffixIconConstraints: BoxConstraints(minHeight: 22),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      IconButton(
                        onPressed: _passwordController.text.isEmpty?null:() {
                          //显示密码
                          setState(() {
                            _obscure=!_obscure;
                          });
                        },
                        icon: Icon(_obscure?Icons.visibility_off:Icons.visibility,color:_passwordController.text.isEmpty?Colors.transparent: Colors.grey,),
                      ),
                    TextButtonWithNoSplash(onTap: forgetPassword,text: "忘记密码",fontSize: 14,color: Coloors.purple,),
                ],),
              ),
            ),
            
            //文字按钮，链接到验证码登录页和注册页
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButtonWithNoSplash(onTap: onTapLoginByCaptcha,text: "验证码登录"),
                  TextButtonWithNoSplash(onTap: onTapRegister, text: "注册"),
                ]
              ),
            ),
            
            
            LoginButton(onPressed: _phoneController.text.isNotEmpty&&_passwordController.text.isNotEmpty?onTapLogin:null),

            
          ],
        ),
        
      );
        
  }
  

  void forgetPassword(){
    print("forget password");
    Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLoginByCaptcha() {
    print("login by password");
    Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithCaptchaPage);
  }

  void onTapRegister() {
    print("register");
    Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin(){
    print("login");
  }

  void onTapAgreement(){
    print("trunToAgreement");
    Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }
}
