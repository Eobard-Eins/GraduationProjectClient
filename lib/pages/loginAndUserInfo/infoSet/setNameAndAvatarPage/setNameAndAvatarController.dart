
import 'package:client_application/components/common/snackbar/snackbar.dart';
import 'package:client_application/components/user/avatarFromLocal.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetNameAndAvatarController extends GetxController{
  Rx<TextEditingController> usernameController=TextEditingController().obs;
  Rx<XFile?> imgPath=Rx(null);
  //设置图片挑选器
  final ImagePicker _picker = ImagePicker();

  openGallery() async {
    Get.back();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    imgPath.value=image;
    imgPath.refresh();
  }
  takePhoto() async {
    Get.back();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    imgPath.value=image;
    imgPath.refresh();
  }
  //头像
  Widget imageView() {
    if (imgPath.value == null) {
      return Container(
        padding: const EdgeInsets.all(26),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Coloors.greyLight,
        ),
        child: const Padding(
            padding: EdgeInsets.only(bottom: 3, right: 3),
            child: Icon(
              Icons.add_a_photo_rounded,
              color: Coloors.grey,
              size: 48,
            )),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          //设置描边
          border: Border.all(color: Coloors.greyLight, width: 1),
          color: Colors.transparent,
        ),
        child: avatarFromLocal(image: imgPath.value,size: 50,)
      );
    }
  }

  Function()? canNext(){
    return usernameController.value.text.isNotEmpty&&imgPath.value!=null ? onTapNext : null;
  }
  void onTapNext() {
    printInfo(info:"点击下一步");
    bool needSetInfo=Get.arguments["needSetInfo"] as bool;
    String account=Get.arguments["account"] as String;
    UserNetService().setAvatar(account,imgPath.value).then((value){
      switch(value.statusCode){
        case Status.setAvatarError||Status.ossError:
          snackbar.error("设置失败", "请稍后重试", value.statusCode);
          onInit();
          break;

        case Status.netError:
          snackbar.error("设置失败", "请检查网络设置", value.statusCode);
          onInit();
          break;

        case Status.userNotExist:
          snackbar.error("设置失败", "账号不存在", value.statusCode);
          onInit();
          break;

        case Status.success:
          value.data?setname(account, needSetInfo):snackbar.error("设置失败", "请稍后重试", value.statusCode);
          break;

        default:
          snackbar.error("设置失败", "请检查网络设置", value.statusCode, exception: true);
          onInit();
          break;
      }
    });
  }
  void setname(String account,bool needSetInfo){
    UserNetService().setUsername(account, usernameController.value.text).then((value){
      switch(value.statusCode){
        case Status.setUsernameError:
          snackbar.error("设置失败", "请稍后重试", value.statusCode);
          onInit();
          break;
        case Status.netError:
          snackbar.error("设置失败", "请检查网络设置", value.statusCode);
          onInit();
          break;

        case Status.infoMiss:
          snackbar.error("设置失败", "请检查输入是否正确", value.statusCode);
          onInit();
          break;

        case Status.success:
          if(value.data==true){
            needSetInfo?
              Get.offNamed(RouteConfig.setUserInitProfilePage,arguments:{'needSetInfo':true,'account':account}):
              Get.back();
          }else{
            snackbar.error("设置失败", "请稍后重试", value.statusCode);
          }
          break;

        default:
          snackbar.error("设置失败", "请检查网络设置", value.statusCode, exception: true);
          onInit();
          break;
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    usernameController.value.clear();
    usernameController.refresh();
    imgPath.value=null;
  }
}