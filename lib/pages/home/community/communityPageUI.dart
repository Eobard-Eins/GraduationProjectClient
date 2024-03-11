import 'dart:async';
import 'dart:io';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:client_application/pages/home/community/communityPageController.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CommunityPage extends StatelessWidget {
  final CommunityPageController _controller = Get.put(CommunityPageController());
  


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:50),
      child: Obx(()=>Column(children: [
        Text(_controller.a.value),
        Text(_controller.b.value),
        TextButton(onPressed: (){
          _controller.a.value="latitude: ${SpUtils.getDouble('latitude')}";
          _controller.b.value="longitude: ${SpUtils.getDouble('longitude')}";
        }, child: Text("定位"),)
      ]),)
    );
  }

  
}
