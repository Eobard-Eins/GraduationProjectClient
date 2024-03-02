
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageController.dart';
import 'package:get/get.dart';
import 'package:client_application/components/common/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/login/checkAgreement.dart';
import 'package:client_application/components/login/loginButton.dart';
import 'package:client_application/components/common/input/textField.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/filter.dart';
import 'package:flutter/material.dart';

//登录页面，使用验证码登录
class LoginPage extends StatelessWidget {
  final int captchaLenth=6;
  final LoginPageController _lpc = Get.put<LoginPageController>(LoginPageController());
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [ Color.fromARGB(255, 252, 235, 178),Color.fromARGB(255, 186, 178, 215), Color.fromARGB(255, 181, 210, 197)],
        ), 
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          //标题
          title: const Padding(padding: EdgeInsets.only(top:30),child: Text(
            "使用验证码登录",
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
                controller: _lpc.mailController,
                onChanged: (value){_lpc.mailControllerText.value = _lpc.mailController.text = InputFilter.FilterEmail(value);},
                readOnly: false,
                keyboardType: TextInputType.emailAddress,
                //textInputAction: TextInputAction.next,
                hintText: "请输入邮箱",
                suffixIcon: _lpc.mailControllerText.value.isEmpty?null:IconButton(
                        onPressed: () {
                          //清空输入框
                          _lpc.mailController.clear();
                          _lpc.mailControllerText.value="";
                        },
                        icon: const Icon(Icons.clear,color: Colors.grey,),
                      ),
              ),)
            ),
            //验证码输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 0),
              child: Obx(()=>UserTextFieldWidget(
                controller: _lpc.captchaController,
                maxLength: 6,
                textInputAction: TextInputAction.done,
                hintText: "请输入验证码",
                onChanged: (value){_lpc.captchaControllerText.value=_lpc.captchaController.text = InputFilter.FilterNum(value);},
                //TODO: 键盘done操作
                onEditingComplete: _lpc.canLogin(),
                keyboardType: TextInputType.number,
                suffixIconConstraints: const BoxConstraints(minHeight: 22),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _lpc.captchaControllerText.value.isEmpty?null:() {
                        //清空输入框
                        _lpc.captchaController.clear();
                        _lpc.captchaControllerText.value="";
                      },
                      icon: Icon(Icons.clear,color:_lpc.captchaControllerText.value.isEmpty?Colors.transparent: Colors.grey,),
                    ),
                    TextButtonWithNoSplash(
                      onTap: _lpc.hasGetCaptcha.value?null:_lpc.onTapCaptcha,
                      text: _lpc.hasGetCaptcha.value?_lpc.captchaHintText.value:"获取验证码",
                      fontSize: 16,
                      color: _lpc.hasGetCaptcha.value?Colors.grey:Coloors.main,
                    ),
                ],),
              ),)
            ),

            //文字按钮，链接到账号密码登录页和注册页
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButtonWithNoSplash(onTap: _lpc.onTapLoginByPassword,text: "账号密码登录"),
                  TextButtonWithNoSplash(onTap: _lpc.onTapRegister, text: "注册"),
                ]
              ),
            ),

            Obx(()=>LoginButton(onPressed: _lpc.canLogin()),)
            //_lpc.checkAgreement.value&&_lpc.mailControllerText.value.isNotEmpty&&_lpc.captchaControllerText.value.length>=captchaLenth?_lpc.onTapLogin:null
          ],
        ),

        //协议勾选框
        bottomNavigationBar: Obx(()=>CheckAgreement(
          onChanged: _lpc.changeAgreement,
          init: _lpc.checkAgreement.value, 
          onTapAgreeMent: _lpc.onTapAgreement),
        )
      ),
    );
  }

  
}
