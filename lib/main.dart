import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/pages/loginPage/infoSet/setNameAndAvatarPage.dart';
import 'package:client_application/pages/loginPage/login/loginPage/loginPageUI.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      home: LoginPage(),
      onGenerateRoute: RouteConfig.onGenerateRoute,
    )
  );
}
