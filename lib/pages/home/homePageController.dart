import 'package:client_application/pages/home/chat/chatPageUI.dart';
import 'package:client_application/pages/home/community/communityPageUI.dart';
import 'package:client_application/pages/home/me/mePageUI.dart';
import 'package:client_application/pages/home/task/taskPageController.dart';
import 'package:client_application/pages/home/task/taskPageUI.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class HomePageController extends GetxController {
  /// 响应式成员变量，默认位置指引0
  final _currentPage = 0.obs;
  set currentPage(index) => _currentPage.value = index;
  get currentPage => _currentPage.value;
  DateTime? _lastQuitTime;
  /// PageView页面控制器
  late PageController pageController;
  //Page页面集合
  late List<Widget> tabPageBodies;

  /// 底部BottomNavigationBarItem
  late List<BottomNavigationBarItem> bottomTabs;

  switchBottomTabBar(int index) {
    //点击底部BottomNavigationBarItem切换PageView页面
    //pageController.animateToPage(index,duration: Duration(seconds: 1),curve: Curves.fastLinearToSlowEaseIn);
    if(currentPage==0){
      Get.find<TaskPageController>().moveToTop();
    }
    pageController.jumpToPage(index);
  }

  onPageChanged(int index) {
    currentPage = index;
    printInfo(info:"当前page：$currentPage");
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

  Future<bool> popScope() async {
    printInfo(info:"进入返回拦截");
    
    if(currentPage!=0){
      pageController.jumpToPage(0);
      return false;
    }else{
      if (_lastQuitTime == null ||
          DateTime.now().difference(_lastQuitTime!).inSeconds > 1) {
        printInfo(info:'再按一次 Back 按钮退出');
        //Get.snackbar("再次返回退出","",snackPosition: SnackPosition.BOTTOM,duration: const Duration(seconds: 1,milliseconds: 250));
        showToast("再次返回退出",backgroundColor: Coloors.greyDeep, position: const ToastPosition(align: Alignment.bottomCenter,offset: -20),duration: const Duration(seconds: 1,milliseconds: 750),textPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5));
        _lastQuitTime = DateTime.now();
        return false;
      } else {
        printInfo(info:'正常返回');
        return true;
      }

    }
    //拦截 返回true 表示不拦截
  }
}
