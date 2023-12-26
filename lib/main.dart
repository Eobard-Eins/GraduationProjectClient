import 'dart:async';

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setNameAndAvatarPage.dart';
import 'package:client_application/pages/loginAndUserInfo/login/agreementPage/agreementPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginWithPasswordPage/loginWithPasswordPageUI.dart';
import 'package:client_application/pages/temp/testUI.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  //runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.getInstance();//初始化本地持续化存储器

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo',
        home: SpUtils.getBool("isLogin")?testUI():LoginPage(),
        onGenerateRoute: RouteConfig.onGenerateRoute,
      );
  }
}