import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:get/get.dart';
class MePageController extends GetxController{
  Rx<String> username="".obs;
  Rx<String> avatarURL=staticValue.defaultAvatar.obs;
  Rx<double> point=0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // username.value=SpUtils.getString("username");
    // avatarURL.value=SpUtils.getString("avatarURL");
    // point.value=SpUtils.getDouble("point");
    username.value="username";
    avatarURL.value=staticValue.defaultAvatar;
    point.value=0.0;
  }

  void gotoAboutPage(){
    Get.toNamed(RouteConfig.aboutPage);
  }
  void gotoSettingPage(){
    Get.toNamed(RouteConfig.settingPage);
  }
}