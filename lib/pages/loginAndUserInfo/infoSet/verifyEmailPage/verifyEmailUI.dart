
import 'package:client_application/components/button/squareTextButton.dart';
import 'package:client_application/components/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/display/checkAgreement.dart';
import 'package:client_application/components/text/textField.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/verifyEmailPage/verifyEmailController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/tool/input/filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//用于修改密码前、注册账号前验证手机号
class VerifyEmailPage extends StatelessWidget {
  final VerifymailController _vpc=Get.put<VerifymailController>(VerifymailController());
  final int captchaLenth=6;
  @override
  Widget build(BuildContext context) {

    //print(Get.arguments);
    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "邮箱验证",
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
            const SizedBox(
              height: 60,
            ),
            //账号输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: Obx(()=>UserTextFieldWidget(
                controller: _vpc.mailController.value,
                onChanged: (value){
                  _vpc.mailController.value.text = InputFilter.FilterEmail(value); 
                  _vpc.mailController.refresh();
                },
                readOnly: false,
                keyboardType: TextInputType.emailAddress,
                //textInputAction: TextInputAction.next,
                hintText: "请输入邮箱",
                suffixIcon: _vpc.mailController.value.text.isEmpty?null:IconButton(
                        onPressed: () {
                          //清空输入框
                          _vpc.mailController.value.clear();
                          _vpc.mailController.refresh();
                        },
                        icon: const Icon(Icons.clear,color: Colors.grey,),
                      ),
              ),)
            ),
            //验证码输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 0),
              child: Obx(()=>UserTextFieldWidget(
                controller: _vpc.captchaController.value,
                maxLength: captchaLenth,
                textInputAction: TextInputAction.done,
                hintText: "请输入验证码",
                onChanged: (value){
                  _vpc.captchaController.value.text = InputFilter.FilterNum(value);
                  _vpc.captchaController.refresh();
                },
                //TODO: 键盘done操作
                onEditingComplete: _vpc.canNext(),
                keyboardType: TextInputType.number,
                suffixIconConstraints: const BoxConstraints(minHeight: 22),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _vpc.captchaController.value.text.isEmpty?null:() {
                        //清空输入框
                        _vpc.captchaController.value.clear();
                        _vpc.captchaController.refresh();
                      },
                      icon: Icon(Icons.clear,color:_vpc.captchaController.value.text.isEmpty?Colors.transparent: Colors.grey,),
                    ),
                    TextButtonWithNoSplash(
                      onTap: _vpc.hasGetCaptcha.value?null:_vpc.onTapCaptcha,
                      text: _vpc.hasGetCaptcha.value?_vpc.captchaHintText.value:"获取验证码",
                      fontSize: 16,
                      color: _vpc.hasGetCaptcha.value?Colors.grey:Coloors.main,
                    ),
                ],),
              ),)
            ),

            //勾选协议框
            Obx(()=>CheckAgreement(
                onChanged: _vpc.changeAgreement, 
                init: _vpc.checkAgreement.value, 
                onTapAgreeMent: _vpc.onTapAgreement
              ),)

          ],
        ),

        //下一步
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          child: Obx(()=>SquareTextButton(text: "下一步", onTap: _vpc.canNext()))
        )
      );
  }
}
