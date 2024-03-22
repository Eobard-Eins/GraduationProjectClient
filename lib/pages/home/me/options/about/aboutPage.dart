import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AboutPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("关于"),
        centerTitle: T,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('lib/res/images/SchoolLogo.png'),height: 140,width: 140,),
            Text("湘潭大学2024届毕业设计，暂仅供学习使用",style: TextStyle(fontSize: 12,height: 4),),
            Text("版本号: 1.0.0",style: TextStyle(fontSize: 12,height: 2),),
            Text("开发者: 连辅礽",style: TextStyle(fontSize: 12),),
            Spacer(),
            Padding(padding: EdgeInsets.only(bottom: 40),child:Image(image: AssetImage('lib/res/images/AppLogo.png'),height: 100,width: 100,),)
        ],),)
    );
  }
}