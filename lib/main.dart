
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/pages/home/homePage.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageUI.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  //runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.getInstance();//初始化本地持续化存储器
  // /**
  //  * 初始化各模块
  //  * 1.初始化本地持续化存储器
  //  * 2.初始化网络服务
  //  */
  // await Future.wait([
  //   MyApp.StorageInit(),
  //   MyApp.NetServerInit(),
  // ]);

  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo',
        initialRoute: initJudge()?RouteConfig.homePage:RouteConfig.loginWithCaptchaPage,
        getPages: RouteConfig.getPages,
        unknownRoute: GetPage(name: '/notfound', page: () => const Scaffold(body: Center(child: Text("No Page Route Provided"),))),
      );
  }

  bool initJudge(){
    return SpUtils.getBool("isLogin");
  }

  // static Future StorageInit() async{
  //   return Future.wait([
  //     SpUtils.getInstance(),
  //   ]);
  // }
}