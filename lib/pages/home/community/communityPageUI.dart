import 'dart:async';
import 'dart:io';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:client_application/components/item/taskItemBriefly.dart';
import 'package:client_application/pages/home/community/communityPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CommunityPage extends StatelessWidget {
  final CommunityPageController _controller = Get.put(CommunityPageController());
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 15,
          shadowColor: Colors.white,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        body: Center(
          child: 
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20),child:TaskItemBriefly(title: "一个一个一个一个一个一个一个一个一个一个一个一个一个一个标题", addressName: "3.06", time: "2024-12-31 11:54", point: 1024.5,actions: [
              TaskItemBriefly.actionButtion("查看详情", () => null)
            ],))
          
        )
      );
  }

  
}
