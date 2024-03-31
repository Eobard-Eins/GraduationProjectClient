import 'package:client_application/services/connect/UserNetService.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_application/components/display/snackbar.dart';
class UserLoginUtils extends GetConnect{


  static loginWithPassword({
    required Rx<TextEditingController> mailController,
    required Rx<TextEditingController> passwordController,
    required Function() onSuccess
  }){
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
          onSuccess();
          break;

        default:
          snackbar.error("登录失败", "请检查网络设置", value.statusCode, exception: true);
          mailController.value.clear(); passwordController.value.clear();
          mailController.refresh(); passwordController.refresh();
          break;
      }
    });    
  }

  static sendCaptcha({required Rx<TextEditingController> mailController,required Function() onSuccess}){
    UserNetService().sendCaptcha(mailController.value.text).then((value){
      switch (value.statusCode){
        case Status.mailFormatError:
          snackbar.error("获取验证码失败", "请输入正确的邮箱", value.statusCode);
          break;

        case Status.netError||Status.mailServiceError:
          snackbar.error("获取验证码失败", "请检查网络设置", value.statusCode);
          break;

        case Status.success:
          onSuccess();
          break;

        default:
          snackbar.error("获取验证码失败", "请检查网络设置", value.statusCode, exception: true);
          break;
      }
    });
  }

  static loginWithCaptcha({
    required Rx<TextEditingController> mailController,
    required Rx<TextEditingController> captchaController,
    required Function() onSuccess,
    required Function() onSuccessButUserNotExist
  }){
    UserNetService().loginWithCaptcha(mailController.value.text,captchaController.value.text).then((value){
      switch (value.statusCode){
        case Status.mailFormatError:
          snackbar.error("验证失败", "请输入正确的邮箱", value.statusCode);
          captchaController.value.clear();//验证码框清空
          captchaController.refresh();
          break;
        
        case Status.netError:
          snackbar.error("验证失败", "请检查网络设置", value.statusCode);
          captchaController.value.clear();//验证码框清空
          captchaController.refresh();
          break;
        
        case Status.captchaError:
          snackbar.error("验证失败", "请输入正确的验证码", value.statusCode);
          captchaController.value.clear();//验证码框清空
          captchaController.refresh();
          break;

        case Status.captchaExpiration:
          snackbar.error("验证码超时", "请重新发送验证码", value.statusCode);
          captchaController.value.clear();//验证码框清空
          captchaController.refresh();
          break;
        
        case Status.pyServerError:
          snackbar.error("验证失败", "请稍后重试", value.statusCode);
          captchaController.value.clear();//验证码框清空
          captchaController.refresh();
          break;

        case Status.successButUserNotExist:
          onSuccessButUserNotExist();
          break;
        
        case Status.success:
          onSuccess();
          break;
        
        default:
          snackbar.error("验证失败", "请检查网络设置", value.statusCode, exception:true);
          captchaController.value.clear();
          captchaController.refresh();
          mailController.value.clear();
          mailController.refresh();
          break;
      }
    });
  }
}