
import 'package:client_application/components/button/squareTextButton.dart';
import 'package:client_application/components/text/textField.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setPasswordPage/setPasswordController.dart';
import 'package:client_application/tool/input/filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SetPasswordPage extends StatelessWidget {
  final SetPasswordController _spc=Get.put<SetPasswordController>(SetPasswordController());
  final passwordMaxLength=16;
  final bool needSetInfo=true;//Get.arguments["needSetInfo"] as bool;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30,),
              child:const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding:EdgeInsets.only(bottom: 10),child:Text("设置密码",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),),
                  Padding(padding:EdgeInsets.only(bottom: 5),child:Text("密码长度应在4~16位，可使用字母、数字、符号组合",style: TextStyle(fontSize: 13),))
                ],)
            ),
            
            //密码第一次输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Obx(()=>UserTextFieldWidget(
                controller: _spc.passwordController.value,
                onChanged: (value) {
                  _spc.passwordController.value.text = InputFilter.FilterPassword(value);
                  _spc.passwordController.refresh();
                },
                readOnly: false,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                maxLength: passwordMaxLength,
                //textInputAction: TextInputAction.next,
                hintText: "请输入密码",
                suffixIconConstraints: const BoxConstraints(minHeight: 22),
                suffixIcon: _spc.passwordController.value.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          //清空输入框
                          _spc.passwordController.value.clear();
                          _spc.passwordController.refresh();
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      ),
              ),)
            ),
            //密码第二次输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Obx(() => UserTextFieldWidget(
                controller: _spc.passwordAgainController.value,
                onChanged: (value) {
                  
                  _spc.passwordAgainController.value.text = InputFilter.FilterPassword(value);
                  _spc.passwordAgainController.refresh();
                },
                readOnly: false,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _spc.obscure.value,
                maxLength: passwordMaxLength,
                textInputAction: TextInputAction.done,
                //TODO:
                onEditingComplete: _spc.canNext(),
                hintText: "请重复输入密码",
                suffixIconConstraints: const BoxConstraints(minHeight: 22),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _spc.passwordAgainController.value.text.isEmpty
                          ? null
                          : () {
                              //显示密码
                              _spc.obscure.value=!_spc.obscure.value;
                            },
                      icon: Icon(
                        _spc.obscure.value ? Icons.visibility_off : Icons.visibility,
                        color: _spc.passwordAgainController.value.text.isEmpty
                            ? Colors.transparent
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),)
            ),
          ],
        ),

        //下一步
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          child:Obx(()=>SquareTextButton(
            text: needSetInfo?"下一步":"完成" , 
            onTap: _spc.canNext()))
        )
      );
  }

  
}
