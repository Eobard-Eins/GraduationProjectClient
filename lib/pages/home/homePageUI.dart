import 'package:client_application/pages/home/homePageController.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget{
  final HomePageController _hpc=Get.put<HomePageController>(HomePageController());

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     //appBar: AppBar(title: Text('BottomNavigationBar'),),
     bottomNavigationBar: _buildBottomNavigationBar(),
     body: _buildPageView(),
   );
  }

  Widget _buildBottomNavigationBar(){
    return Obx(()=>Theme(
        data: ThemeData(
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: _hpc.bottomTabs,
          currentIndex: _hpc.currentPage,
          type: BottomNavigationBarType.fixed,
          // fixedColor: Colors.red,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Coloors.main,
          onTap:  (int index) => _hpc.switchBottomTabBar(index),
        ),
      ),
    );
  }
  /// 内容页
  Widget _buildPageView() {
    return PageView(
      controller: _hpc.pageController,
      onPageChanged: (index) => _hpc.onPageChanged(index),
      //禁止滑动
      //physics: const NeverScrollableScrollPhysics(),
      children: _hpc.tabPageBodies,
    );
  }
}