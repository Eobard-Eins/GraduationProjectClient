import 'package:client_application/components/display/shortHeadBar.dart';
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImgPacker{
  //设置图片挑选器
  final ImagePicker _picker = ImagePicker();
  ImgPacker(Rx<XFile?> imgPath){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top:10,left: 20,right: 20),
        height: 150,
        child: Column(children: [
          const ShortHeadBar(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          Row(children: [
            Expanded(child: InkWell(
              onTap: () async {
                Get.back();
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                imgPath.value=image;
                imgPath.refresh();
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                
                child:const Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
                  Icon(
                    Icons.photo_library,
                    color: Coloors.main,
                    size: 50,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  Text("从相册选择")
                ]),
              ),)
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Container(
              height: 40,
              width: 1,
              decoration: const BoxDecoration(color: Color.fromARGB(255, 181, 181, 181)), 
            ),),
            Expanded(child: InkWell(
              onTap:() async {
                Get.back();
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                imgPath.value=image;
                imgPath.refresh();
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                alignment: Alignment.center,
                
                child: const Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
                  Icon(
                    Icons.camera_sharp,
                    color: Coloors.main,
                    size: 50,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  Text("拍照")
                ]),
              ),)
            )
          ],)
            
          ]
        ),
      ),
      backgroundColor: Colors.white
    );
  }
}
