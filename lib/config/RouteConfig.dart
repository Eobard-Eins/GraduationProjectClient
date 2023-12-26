
import 'package:client_application/pages/loginAndUserInfo/login/agreementPage/agreementPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setNameAndAvatarPage.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginWithPasswordPage/loginWithPasswordPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setPasswordPage.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/verifyPhonePage.dart';
import 'package:client_application/pages/temp/testUI.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:flutter/material.dart';

class RouteConfig {

  static const String loginWithCaptchaPage="/loginWithCaptchaPage";
  static const String loginWithPasswordPage="/loginWithPasswordPage";

  static const String agreementInfoPage="/agreementInfoPage";
  static const String verifyPhonePage="/verifyPhonePage";
  
  static const String setPasswordPage="/setPasswordPage";
  static const String setNameAndAvatarPage="/setNameAndAvatarPage";

  static const String TESTPAGE="/TESTPAGE";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginWithCaptchaPage:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case loginWithPasswordPage:
        return MaterialPageRoute(builder: (context) => LoginWithPasswordPage());
      case agreementInfoPage:
        return MaterialPageRoute(builder: (context) => const AgreementPage());
      case verifyPhonePage:
        return MaterialPageRoute(builder: (context) => const VerifyPhonePage());
      case setPasswordPage:
        return MaterialPageRoute(builder: (context) => const SetPasswordPage());
      case setNameAndAvatarPage:
        return MaterialPageRoute(builder: (context) => const SetNameAndAvatarPage());
      case TESTPAGE:
          return MaterialPageRoute(builder: (context) => testUI());
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text("No Page Route Provided"),)));
    }
  }
}