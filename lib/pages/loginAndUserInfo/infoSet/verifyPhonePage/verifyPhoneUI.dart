
import 'package:client_application/components/common/button/squareTextButton.dart';
import 'package:client_application/components/common/button/textButtonWithNoSplash.dart';
import 'package:client_application/components/login/checkAgreement.dart';
import 'package:client_application/components/common/input/textField.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/verifyPhonePage/verifyPhoneController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//用于修改密码前、注册账号前验证手机号
class VerifyPhonePage extends StatelessWidget {
  final VerifyPhoneController _vpc=Get.put(VerifyPhoneController());
  final int captchaLenth=6;
  @override
  Widget build(BuildContext context) {
    _vpc.init();
    //print(Get.arguments);
    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "验证手机号",
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
              height: 30,
            ),
            //账号输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Obx(()=>UserTextFieldWidget(
                controller: _vpc.phoneController.value,
                onChanged: (value){
                  _vpc.phoneController.value.text = InputFilter.FilterNum(value); 
                  _vpc.phoneController.refresh();
                },
                readOnly: false,
                keyboardType: TextInputType.phone,
                //textInputAction: TextInputAction.next,
                hintText: "请输入手机号码",
                suffixIcon: _vpc.phoneController.value.text.isEmpty?null:IconButton(
                        onPressed: () {
                          //清空输入框
                          _vpc.phoneController.value.clear();
                          _vpc.phoneController.refresh();
                        },
                        icon: const Icon(Icons.clear,color: Colors.grey,),
                      ),
              ),)
            ),
            //验证码输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
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
                    fontSize: 14,
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
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          child: Obx(()=>SquareTextButton(text: "下一步", onTap: _vpc.canNext()))
        )
      );
  }
}