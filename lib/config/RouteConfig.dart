
import 'package:client_application/pages/home/homePageUI.dart';
import 'package:client_application/pages/home/task/newTask/newTaskPageUI.dart';
import 'package:client_application/pages/home/task/taskInfo/taskInfoPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/userInitProfile/setUserInitProfileUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/agreementPage/agreementPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setNameAndAvatarPage/setNameAndAvatarUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginWithPasswordPage/loginWithPasswordPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setPasswordPage/setPasswordUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/verifyEmailPage/verifyEmailUI.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteConfig {

  static const String loginWithCaptchaPage="/loginWithCaptchaPage";
  static const String loginWithPasswordPage="/loginWithPasswordPage";

  static const String agreementInfoPage="/agreementInfoPage";
  static const String verifyEmailPage="/verifyEmailPage";
  
  static const String setPasswordPage="/setPasswordPage";
  static const String setNameAndAvatarPage="/setNameAndAvatarPage";
  static const String setUserInitProfilePage="/setUserInitProfilePage";

  static const String homePage="/homePage";

  static const String taskInfoPage="/taskInfoPage";
  static const String newTaskPage="/newTaskPage";

  static List<GetPage<dynamic>>? getPages=[
    GetPage(
      name: loginWithCaptchaPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: loginWithPasswordPage,
      page: () => LoginWithPasswordPage(),
    ),
    GetPage(
      name: agreementInfoPage,
      page: () => const AgreementPage(),
    ),
    GetPage(
      name: verifyEmailPage,
      page: () => VerifyEmailPage(),
    ),
    GetPage(
      name: setPasswordPage,
      page: () => SetPasswordPage(),
    ),
    GetPage(
      name: setNameAndAvatarPage,
      page: () => SetNameAndAvatarPage(),
    ),
    GetPage(
      name: setUserInitProfilePage, 
      page: () => SetUserInitProfilePage()
    ),
    GetPage(
      name: homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: taskInfoPage, 
      page: ()=>TaskInfoPage(),
    ),
    GetPage(
      name: newTaskPage, 
      page: ()=>NewTaskPage(),
    )
  ];

}