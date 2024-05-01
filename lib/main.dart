
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

void main() async{ 
  //runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.getInstance();//初始化本地持续化存储器
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return OKToast(child: GetMaterialApp(
        theme: ThemeData(
          primaryColor: Coloors.main,
          primaryColorLight: Coloors.mainLight,
          primaryColorDark: Coloors.mainDark,
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Coloors.mainLight.withOpacity(0.35), // 选中文本背景颜色
            cursorColor: Coloors.main, // 光标颜色
            selectionHandleColor: Coloors.main, // 选区手柄颜色
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: '帮帮',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          // 添加对Cupertino (iOS风格) 组件的本地化支持
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('zh', 'CN')], 
        initialRoute: goHome()?RouteConfig.homePage:RouteConfig.loginWithCaptchaPage,
        getPages: RouteConfig.getPages,
        unknownRoute: GetPage(name: '/notfound', page: () => const Scaffold(body: Center(child: Text("No Page Route Provided"),))),
        
      ));
    
  }

  bool goHome(){
    if(SpUtils.getBool("isLogin")){//true
      int lt=SpUtils.getInt("lastLoginTime");
      int nt=DateTime.now().millisecondsSinceEpoch;
      if((nt-lt).abs()<15*86400000){
        //两次登录天数小于15天
        SpUtils.setInt("lastLoginTime", nt);
        print("[INFO] 登陆日期判断通过 user:${SpUtils.getString("account")}");
        //SocketUtils().connect(SpUtils.getString("account"));
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