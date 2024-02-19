import 'package:client_application/pages/home/chat/chatPageUI.dart';
import 'package:client_application/pages/home/community/communityPageUI.dart';
import 'package:client_application/pages/home/me/mePageUI.dart';
import 'package:client_application/pages/home/task/taskPageUI.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  /// 响应式成员变量，默认位置指引0
  final _currentPage = 0.obs;
  set currentPage(index) => _currentPage.value = index;
  get currentPage => _currentPage.value;

  /// PageView页面控制器
  late PageController pageController;
  //Page页面集合
  late List<Widget> tabPageBodies;

  /// 底部BottomNavigationBarItem
  late List<BottomNavigationBarItem> bottomTabs;

  switchBottomTabBar(int index) {
    //点击底部BottomNavigationBarItem切换PageView页面
    //pageController.animateToPage(index,duration: Duration(seconds: 1),curve: Curves.fastLinearToSlowEaseIn);
    pageController.jumpToPage(index);
  }

  onPageChanged(int index) {
    currentPage = index;
  }

  /// 在Widget内存中分配后立即调用，可以用它来初始化initialize一些东西
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPage);
    bottomTabs = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            size: 25,
          ),
          activeIcon: Icon(Icons.home_outlined, size: 25),
          label: '首页'
        ),

      BottomNavigationBarItem(
          icon: Icon(
            Icons.forum_outlined,
            size: 25,
          ),
          activeIcon: Icon(Icons.forum_outlined, size: 25),
          label: '论坛'
        ),

      BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_outlined,
            size: 25,
          ),
          activeIcon: Icon(Icons.chat_outlined, size: 25),
          label: '聊天'
        ),

      BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outlined,
            size: 25,
          ),
          activeIcon: Icon(Icons.person_outlined, size: 25),
          label: '我的'
        ),
    ];

    tabPageBodies = <Widget>[TaskPage(), CommunityPage(), ChatPage(), MePage()];
  }
}
