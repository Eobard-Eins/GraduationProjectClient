
import 'package:client_application/pages/home/homePage.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/userInitProfile/setUserInitProfileUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/agreementPage/agreementPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setNameAndAvatarPage/setNameAndAvatarUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginWithPasswordPage/loginWithPasswordPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setPasswordPage/setPasswordUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/verifyPhonePage/verifyPhoneUI.dart';
import 'package:client_application/pages/temp/testUI.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


class RouteConfig {

  static const String loginWithCaptchaPage="/loginWithCaptchaPage";
  static const String loginWithPasswordPage="/loginWithPasswordPage";

  static const String agreementInfoPage="/agreementInfoPage";
  static const String verifyPhonePage="/verifyPhonePage";
  
  static const String setPasswordPage="/setPasswordPage";
  static const String setNameAndAvatarPage="/setNameAndAvatarPage";
  static const String setUserInitProfilePage="/SetUserInitProfilePage";

  static const String homePage="/homePage";

  static const String TESTPAGE="/TESTPAGE";

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
      name: verifyPhonePage,
      page: () => VerifyPhonePage(),
    ),
    GetPage(
      name: setPasswordPage,
      page: () => SetPasswordPage(),
    ),
    GetPage(
      name: setNameAndAvatarPage,
      page: () => SetNameAndAvatarPage(),
    ),
    // GetPage(
    //   name: setUserInitProfilePage,
    //   page: () => SetUserInitProfilePage(),
    // ),
    GetPage(
      name: homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: TESTPAGE,
      page: () => testUI(),
    ),
  ];

}