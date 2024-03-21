import 'dart:async';
import 'dart:io';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:client_application/pages/home/community/communityPageController.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/localStorage.dart';
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
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 20,right:20,bottom: 15),
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(children: [
                  const Text(
                    '论坛',
                    style: TextStyle(
                        fontFamily: 'SmileySans',
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.only(top: 5,right: 10),
                    iconSize: 50,
                    highlightColor: Colors.transparent,
                    onPressed: (){},
                    icon: const Icon(
                      Icons.add_circle_outlined,
                      color: Coloors.main,
                    ))
                ])),
            //const Divider(height: 1,color: Coloors.greyLight,),
        
          ],
        )
      );
  }

  
}
