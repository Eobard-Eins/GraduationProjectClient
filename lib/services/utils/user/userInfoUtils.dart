
import 'package:client_application/models/User.dart';
import 'package:client_application/services/connect/UserNetService.dart';
import 'package:get/get.dart';
import 'package:client_application/components/display/snackbar.dart';
import 'package:image_picker/image_picker.dart';
class UserInfoUtils extends GetConnect{

  static getUserInfo({
    required String mail,
    required Function(User u) onSuccess,
  }){
    UserNetService().getUserInfo(mail).then((value){
      if(value.isError()){
        snackbar.error("获取信息失败", value.message!, value.statusCode);
      }else{
        User u=User.fromJson(value.data);
        onSuccess(u);
      }
    });
  }

  static setPassword({
    required String password,
    required String passwordAgain,
    required String account,
    required Function() onSuccess,
    required Function() onError,
  }){
    UserNetService().setPassword(account,password, passwordAgain).then((value){
      if(value.isError()){
        snackbar.error("设置失败", value.message!, value.statusCode);
        onError();
      }else{
        if(value.data==true){
            onSuccess();
          }else{
            snackbar.error("设置失败", "请稍后重试", value.statusCode);
            onError();
          }
      }
    });
  }

  static setAvatar({
    required String account,
    required XFile? imgPath,
    required Function() onSuccess,
    required Function() onError
  }){
    UserNetService().setAvatar(account,imgPath).then((value){
      if(value.isError()){
        snackbar.error("头像设置失败", value.message!, value.statusCode);
      }else{
        value.data?onSuccess():snackbar.error("设置失败", "请稍后重试", value.statusCode);
      }
    });
  }

  static setUsername({
    required String username,
    required String account,
    required Function() onSuccess,
    required Function() onError,
  }){
    UserNetService().setUsername(account, username).then((value){
      if(value.isError()){
        snackbar.error("用户名设置失败", value.message!, value.statusCode);
        onError();
      }else{
        if(value.data==true){
            onSuccess();
          }else{
            snackbar.error("用户名设置失败", "请稍后重试", value.statusCode);
            onError();
          }
      }
    });
  }
}