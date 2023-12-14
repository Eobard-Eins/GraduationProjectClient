
import 'package:client_application/pages/loginPage/agreementPage.dart';
import 'package:client_application/pages/loginPage/loginPage.dart';
import 'package:client_application/pages/loginPage/loginWithPasswordPage.dart';
import 'package:flutter/material.dart';

class RouteConfig {

  static const String loginWithCaptcha="/loginWithCaptcha";
  static const String loginWithPassword="/loginWithPassword";
  static const String agreementInfo="/agreementInfo";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginWithCaptcha:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case loginWithPassword:
        return MaterialPageRoute(builder: (context) => const LoginWithPasswordPage());
      case agreementInfo:
        return MaterialPageRoute(builder: (context) => const AgreementPage());
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text("No Page Route Provided"),)));
    }
  }
}