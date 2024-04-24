
import 'package:client_application/pages/home/homePageUI.dart';
import 'package:client_application/pages/home/me/options/about/aboutPage.dart';
import 'package:client_application/pages/home/me/options/history/historyPageUI.dart';
import 'package:client_application/pages/home/me/options/myAccess/myAccessPageUI.dart';
import 'package:client_application/pages/home/me/options/myPublish/myPublishPageUI.dart';
import 'package:client_application/pages/home/me/options/setting/settingPageUI.dart';
import 'package:client_application/pages/home/task/newTask/newTaskPageUI.dart';
import 'package:client_application/pages/home/task/taskInfo/taskInfoPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/agreementPage/agreementPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setNameAndAvatarPage/setNameAndAvatarUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginWithPasswordPage/loginWithPasswordPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setPasswordPage/setPasswordUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/verifyEmailPage/verifyEmailUI.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteConfig {

  static const String loginWithCaptchaPage="/login/loginWithCaptchaPage";
  static const String loginWithPasswordPage="/login/loginWithPasswordPage";

  static const String agreementInfoPage="/login/agreementInfoPage";
  static const String verifyEmailPage="/login/verifyEmailPage";
  
  static const String setPasswordPage="/set/setPasswordPage";
  static const String setNameAndAvatarPage="/set/setNameAndAvatarPage";

  static const String homePage="/homePage";

  static const String taskInfoPage="/task/taskInfoPage";
  static const String newTaskPage="/task/newTaskPage";

  static const String aboutPage="/me/aboutPage";
  static const String settingPage="/me/settingPage";
  static const String myPublishPage="/me/myPublishPage";
  static const String myAccessPage="/me/myAccessPage";
  static const String taskHistoryPage="/me/taskHistoryPage";

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
    ),
    GetPage(
      name:aboutPage,
      page: ()=>AboutPage(),
    ),
    GetPage(
      name: settingPage, 
      page: ()=>SettingPage(),
    ),
    GetPage(
      name: myPublishPage, 
      page: ()=>MyPublishPage(),
    ),
    GetPage(
      name: myAccessPage, 
      page: ()=>MyAccessPage(),
    ),
    GetPage(
      name: taskHistoryPage, 
      page: ()=>HistoryPage(),
    ),
  ];

}