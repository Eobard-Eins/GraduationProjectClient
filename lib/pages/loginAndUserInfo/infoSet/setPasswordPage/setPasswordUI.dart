
import 'package:client_application/components/common/button/squareTextButton.dart';
import 'package:client_application/components/common/input/textField.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setPasswordPage/setPasswordController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class SetPasswordPage extends StatelessWidget {
  final SetPasswordController _spc=Get.put(SetPasswordController());
  final passwordMaxLength=16;
  final bool needSetInfo=Get.arguments["needSetInfo"] as bool;
  
  @override
  Widget build(BuildContext context) {
    _spc.init();

    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "设置密码",
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 300.w, vertical: 0.h),
              child:const Text(
                "密码长度应在4~16位，可使用字母、数字、符号组合",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            //密码第一次输入
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 200.w, vertical: 0.h),
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
                suffixIconConstraints:  BoxConstraints(minHeight: 22.h),
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
              padding: EdgeInsets.symmetric(horizontal: 200.w, vertical: 30.h),
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
                suffixIconConstraints: BoxConstraints(minHeight: 22.h),
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
          padding: EdgeInsets.symmetric(horizontal: 200.w, vertical: 30.h),
          child:Obx(()=>SquareTextButton(
            text: needSetInfo?"下一步":"完成" , 
            onTap: _spc.canNext()))
        )
      );
  }

  
}
