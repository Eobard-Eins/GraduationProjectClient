
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
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
        theme: ThemeData(
          primaryColor: Coloors.main,
          primaryColorLight: Coloors.mainLight,
          primaryColorDark: Coloors.mainDark,
          ),
        debugShowCheckedModeBanner: false,
        title: 'Demo',
        initialRoute: initJudge()?RouteConfig.homePage:RouteConfig.homePage,
        getPages: RouteConfig.getPages,
        unknownRoute: GetPage(name: '/notfound', page: () => const Scaffold(body: Center(child: Text("No Page Route Provided"),))),
        
      );
    
  }

  bool initJudge(){
    if(SpUtils.getBool("isLogin")){//true
      int lt=SpUtils.getInt("lastLoginTime");
      int nt=DateTime.now().millisecondsSinceEpoch;
      if((nt-lt).abs()<15*86400000){
        //两次登录天数小于15天
        SpUtils.setInt("lastLoginTime", nt);
        print("[INFO] 登陆日期判断通过");
        return true;
      }else{
        SpUtils.clear();
        return false;
      }
    }else{//null false
      return false;
    }
  }

  // static Future StorageInit() async{
  //   return Future.wait([
  //     SpUtils.getInstance(),
  //   ]);
  // }
}