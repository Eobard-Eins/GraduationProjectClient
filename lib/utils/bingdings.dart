import 'package:client_application/pages/home/homePageController.dart';
import 'package:client_application/pages/home/task/taskPageController.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setNameAndAvatarPage/setNameAndAvatarController.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setPasswordPage/setPasswordController.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/userInitProfile/setUserInitProfileController.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/verifyPhonePage/verifyPhoneController.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageController.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginWithPasswordPage/loginWithPasswordPageController.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // 将 Controller 注入到依赖容器中
    Get.lazyPut<LoginPageController>(() => LoginPageController());
    Get.lazyPut<LoginWithPasswordPageController>(() => LoginWithPasswordPageController());
    Get.lazyPut<VerifyPhoneController>(() => VerifyPhoneController());
    Get.lazyPut<SetUserInitProfileController>(() => SetUserInitProfileController());
    Get.lazyPut<SetPasswordController>(() => SetPasswordController());
    Get.lazyPut<SetNameAndAvatarController>(() => SetNameAndAvatarController());
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<TaskPageController>(() => TaskPageController());
  }
}