
import 'package:client_application/services/connect/UserNetService.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_application/components/display/snackbar.dart';
import 'package:image_picker/image_picker.dart';
class UserInfoUtils extends GetConnect{

  static setPassword({
    required Rx<TextEditingController> passwordController,
    required Rx<TextEditingController> passwordAgainController,
    required String account,
    required Function() onSuccess,
  }){
    UserNetService().setPassword(account,passwordController.value.text, passwordAgainController.value.text).then((value){
      switch(value.statusCode){
        case Status.passwordInconsistent:
          snackbar.error("设置失败", "请确保两次密码一致", value.statusCode);
          passwordController.value.clear();
          passwordAgainController.value.clear();
          passwordController.refresh();
          passwordAgainController.refresh();
          break;

        case Status.passwordFormatError:
          snackbar.error("设置失败", "请检查密码格式", value.statusCode);
          passwordController.value.clear();
          passwordAgainController.value.clear();
          passwordController.refresh();
          passwordAgainController.refresh();
          break;

        case Status.netError||Status.setPasswordError:
          snackbar.error("设置失败", "请检查网络设置", value.statusCode);
          passwordController.value.clear();
          passwordAgainController.value.clear();
          passwordController.refresh();
          passwordAgainController.refresh();
          break;

        case Status.infoMiss:
          snackbar.error("设置失败", "请检查输入是否正确", value.statusCode);
          passwordController.value.clear();
          passwordAgainController.value.clear();
          passwordController.refresh();
          passwordAgainController.refresh();
          break;

        case Status.success:
          if(value.data==true){
            onSuccess();
          }else{
            snackbar.error("设置失败", "请稍后重试", value.statusCode);
            passwordController.value.clear();
            passwordAgainController.value.clear();
            passwordController.refresh();
            passwordAgainController.refresh();
          }
          break;

        default:
          snackbar.error("设置失败", "请检查网络设置", value.statusCode, exception: true);
          passwordController.value.clear();
          passwordAgainController.value.clear();
          passwordController.refresh();
          passwordAgainController.refresh();
          break;
      }
    });
  }

  static setAvatar({
    required String account,
    required Rx<XFile?> imgPath,
    required Function() onSuccess
  }){
    UserNetService().setAvatar(account,imgPath.value).then((value){
      switch(value.statusCode){
        case Status.setAvatarError||Status.ossError:
          snackbar.error("头像设置失败", "请稍后重试", value.statusCode);
          imgPath.value=null;
          break;

        case Status.netError:
          snackbar.error("头像设置失败", "请检查网络设置", value.statusCode);
          imgPath.value=null;
          break;

        case Status.userNotExist:
          snackbar.error("头像设置失败", "账号不存在", value.statusCode);
          imgPath.value=null;
          break;

        case Status.success:
          value.data?onSuccess():snackbar.error("设置失败", "请稍后重试", value.statusCode);
          break;

        default:
          snackbar.error("头像设置失败", "请检查网络设置", value.statusCode, exception: true);
          imgPath.value=null;
          break;
      }
    });
  }

  static setUsername({
    required Rx<TextEditingController> usernameController,
    required String account,
    required Function() onSuccess
  }){
    UserNetService().setUsername(account, usernameController.value.text).then((value){
      switch(value.statusCode){
        case Status.setUsernameError:
          snackbar.error("用户名设置失败", "请稍后重试", value.statusCode);
          usernameController.value.clear();
          usernameController.refresh();
          break;
        case Status.netError:
          snackbar.error("用户名设置失败", "请检查网络设置", value.statusCode);
          usernameController.value.clear();
          usernameController.refresh();
          break;

        case Status.infoMiss:
          snackbar.error("用户名设置失败", "请检查输入是否正确", value.statusCode);
          usernameController.value.clear();
          usernameController.refresh();
          break;

        case Status.success:
          if(value.data==true){
            onSuccess();
          }else{
            snackbar.error("用户名设置失败", "请稍后重试", value.statusCode);
            usernameController.value.clear();
            usernameController.refresh();
          }
          break;

        default:
          snackbar.error("用户名设置失败", "请检查网络设置", value.statusCode, exception: true);
          usernameController.value.clear();
          usernameController.refresh();
          break;
      }
    });
  }
}