import 'dart:async';

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/pages/home/homePage.dart';
import 'package:client_application/pages/loginAndUserInfo/infoSet/setNameAndAvatarPage.dart';
import 'package:client_application/pages/loginAndUserInfo/login/agreementPage/agreementPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageUI.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginWithPasswordPage/loginWithPasswordPageUI.dart';
import 'package:client_application/pages/temp/testUI.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  //runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  //await SpUtils.getInstance();//初始化本地持续化存储器
  /**
   * 初始化各模块
   * 1.初始化本地持续化存储器
   * 2.初始化网络服务
   */
  await Future.wait([
    MyApp.StorageInit(),
    MyApp.NetServerInit(),
  ]);

  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo',
        home: initJudge()?HomePage():LoginPage(),
        onGenerateRoute: RouteConfig.onGenerateRoute,
      );
  }

  bool initJudge(){
    return SpUtils.getBool("isLogin");
  }

  static Future StorageInit() async{
    return Future.wait([
      SpUtils.getInstance(),
    ]);
  }
  static Future NetServerInit() async{
    return Future.wait([
      Future.sync(() => Get.put(UserNetService()))
    ]);
  }
}