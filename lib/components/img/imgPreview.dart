import 'package:client_application/res/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';

typedef PageChanged = void Function(int index);
// ignore: must_be_immutable
class ImgPreview extends StatelessWidget {
  final List galleryItems; //图片列表
  final int defaultImage; //默认第几张
  final PageChanged pageChanged; //切换图片回调
  final Axis direction; //图片查看方向
  final Decoration? decoration;//背景设计

  ImgPreview(
    {super.key, required this.galleryItems,
      this.defaultImage = 0,
      required this.pageChanged,
      this.direction = Axis.horizontal,
      this.decoration
    });

  Rx<int> tempSelect=1.obs;

  @override
  Widget build(BuildContext context) {
    tempSelect.value=defaultImage+1;
    return Material(
      child: Obx(()=>Stack(
        children: [
           PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage("https://${galleryItems[index]}"),
                  onTapUp: (context, details, controllerValue) => Get.back(),
                );
              },
              scrollDirection: direction,
              itemCount: galleryItems.length,
              backgroundDecoration: const BoxDecoration(color: Colors.white),
              pageController: PageController(initialPage: defaultImage),
              onPageChanged: (index){
                printInfo(info:"page changed $index");
                tempSelect.value=index+1;
                pageChanged(index);
              }
          ),
          Positioned(
            right: 30,
            top: 40,
            child: Container(
              decoration: const BoxDecoration(
                color: Coloors.greyLight,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Text('${tempSelect.value}/${galleryItems.length}',style: const TextStyle(color:Colors.black),),),
            )
          )
        ],
      ),)
    );
  }
}
