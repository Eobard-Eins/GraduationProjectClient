import 'package:client_application/services/services/UserNetService.dart';
import 'package:client_application/utils/res/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserNetUtils{
  static get snackbar => null;


  static void loginWithPassword(Rx<TextEditingController> mailController,Rx<TextEditingController> passwordController,Function() success){
    UserNetService().loginWithPassword(mailController.value.text,passwordController.value.text).then((value) {
      switch (value.statusCode){
        case Status.mailFormatError:
          snackbar.error("登录失败", "请输入正确的邮箱", value.statusCode);
          passwordController.value.clear();//密码框清空
          passwordController.refresh();
          break;
        
        case Status.netError:
          snackbar.error("登录失败", "请检查网络设置", value.statusCode);
          passwordController.value.clear();//密码框清空
          passwordController.refresh();
          break;

        case Status.userNotExist:
          snackbar.error("登录失败", "账号不存在，请确保输入的邮箱正确", value.statusCode);
          passwordController.value.clear();//密码框清空
          passwordController.refresh();
          break;

        case Status.passwordError:
          snackbar.error("登录失败", "请输入正确的密码", value.statusCode);
          passwordController.value.clear();//密码框清空
          passwordController.refresh();
          break;
        
        case Status.success:
          success();
          break;

        default:
          snackbar.error("登录失败", "请检查网络设置", value.statusCode, exception: true);
          mailController.value.clear(); passwordController.value.clear();
          mailController.refresh(); passwordController.refresh();
          break;
      }
    });    
  }
}