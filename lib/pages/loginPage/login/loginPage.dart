import 'dart:async';

import 'package:client_application/components/common/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/login/checkAgreement.dart';
import 'package:client_application/components/login/loginButton.dart';
import 'package:client_application/components/common/input/textField.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/filter.dart';
import 'package:flutter/material.dart';

//登录页面，使用验证码登录
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _phoneController;
  late TextEditingController _captchaController;

  bool _checkAgreement = false;

  bool _hasGetCaptcha = false;
  String _captchaHintText= "获取验证码";

  @override
  void initState() {
    _phoneController = TextEditingController();
    _captchaController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _captchaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "使用验证码登录",
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
            const SizedBox(
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
                        icon: const Icon(Icons.clear,color: Colors.grey,),
                      ),
              ),
            ),
            //验证码输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
              child: UserTextFieldWidget(
                controller: _captchaController,
                maxLength: 6,
                textInputAction: TextInputAction.done,
                hintText: "请输入验证码",
                onChanged: (value){setState(() {_captchaController.text = InputFilter.FilterNum(value);});},
                //TODO: 键盘done操作
                onEditingComplete: _checkAgreement&&_phoneController.text.isNotEmpty&&_captchaController.text.isNotEmpty?onTapLogin:null,
                keyboardType: TextInputType.number,
                suffixIconConstraints: const BoxConstraints(minHeight: 22),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      IconButton(
                        onPressed: _captchaController.text.isEmpty?null:() {
                          //清空输入框
                          _captchaController.clear();
                          setState(() {
                            _captchaController.clear();
                          });
                        },
                        icon: Icon(Icons.clear,color:_captchaController.text.isEmpty?Colors.transparent: Colors.grey,),
                      ),
                  TextButtonWithNoSplash(
                    onTap: _hasGetCaptcha?null:onTapCaptcha,
                    text: _hasGetCaptcha?_captchaHintText:"获取验证码",
                    fontSize: 14,
                    color: _hasGetCaptcha?Colors.grey:Coloors.purple,
                  ),
                ],),
              ),
            ),

            //文字按钮，链接到账号密码登录页和注册页
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButtonWithNoSplash(onTap: onTapLoginByPassword,text: "账号密码登录"),
                  TextButtonWithNoSplash(onTap: onTapRegister, text: "注册"),
                ]
              ),
            ),

            LoginButton(onPressed: _checkAgreement&&_phoneController.text.isNotEmpty&&_captchaController.text.isNotEmpty?onTapLogin:null),
          ],
        ),

        //协议勾选框
        bottomNavigationBar: CheckAgreement(
          onChanged: (value) {
              setState(() {
                _checkAgreement = !_checkAgreement;
              });
              print("checkbox changed");
            }, 
          init: _checkAgreement, 
          onTapAgreeMent: onTapAgreement),
        
      );
  }

  void timeDown(int init) async{
    int countdown = init;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      setState(() {
        _captchaHintText="已获取($countdown)";
      });
      if (countdown == 0) {
        _hasGetCaptcha=false;
        timer.cancel();
      }
    });
  }

  void onTapCaptcha() {
    print("getCaptcha");
    int initSec=60;
    setState(() {
      _hasGetCaptcha=true;
      _captchaHintText="已获取($initSec)";
      timeDown(initSec);
    });
    
    
    print("done");

  }

  void onTapLoginByPassword() {
    print("login by password");
    Navigator.of(context).pushReplacementNamed(RouteConfig.loginWithPasswordPage);
  }

  void onTapRegister() {
    print("register");
    Navigator.of(context).pushNamed(RouteConfig.verifyPhonePage);
  }

  void onTapLogin() {
    //print(_phoneController.text);
  }

  void onTapAgreement() {
    print("trunToAgreement");
    Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }
}
