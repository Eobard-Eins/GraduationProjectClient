
import 'package:client_application/pages/loginPage/agreementPage.dart';
import 'package:client_application/pages/loginPage/login/loginPage.dart';
import 'package:client_application/pages/loginPage/login/loginWithPasswordPage.dart';
import 'package:client_application/pages/loginPage/register/setPasswordPage.dart';
import 'package:client_application/pages/loginPage/register/verifyPhonePage.dart';
import 'package:flutter/material.dart';

class RouteConfig {

  static const String loginWithCaptchaPage="/loginWithCaptchaPage";
  static const String loginWithPasswordPage="/loginWithPasswordPage";
  static const String agreementInfoPage="/agreementInfoPage";
  static const String verifyPhonePage="/verifyPhonePage";
  static const String setPasswordPage="/setPasswordPage";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginWithCaptchaPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case loginWithPasswordPage:
        return MaterialPageRoute(builder: (context) => const LoginWithPasswordPage());
      case agreementInfoPage:
        return MaterialPageRoute(builder: (context) => const AgreementPage());
      case verifyPhonePage:
        return MaterialPageRoute(builder: (context) => const VerifyPhonePage());
      case setPasswordPage:
        return MaterialPageRoute(builder: (context) => const SetPasswordPage());
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text("No Page Route Provided"),)));
    }
  }
}