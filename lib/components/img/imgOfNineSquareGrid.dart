
import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/components/img/imgPreview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImgOfNineSquareGrid extends StatelessWidget{
  final RxList<String> imgs;
  final double size;

  const ImgOfNineSquareGrid({Key? key, required this.imgs, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(imgs.isEmpty){
        return Container();
      }
      switch (imgs.length){
        case 1: return img1t1();
        case 2: return img1t2();
        case 3: return img1t3();
        case 4: return img2t2();
        case 5: return img2t3();
        case 6: return img2t3();
        case 7: return img3t3();
        case 8: return img3t3();
        case 9: return img3t3();
        default: return Container();
      }
    });
  }
  Widget img(int index,double size){
    if (index>=imgs.length){
      return Container();
    }
    return InkWell(
      highlightColor: Colors.transparent, // 透明色
      splashColor: Colors.transparent,
      onTap: (){
        Get.to(()=>ImgPreview(
          galleryItems: imgs,
          defaultImage: index,
          pageChanged: (index) {},
        ));
      },
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),child: ImgFromNet(imageUrl:imgs[index],height: size,width: size,),),
    );
  }

  Widget img1t1(){
    return SizedBox(
      height: size,
      width: size,
      child: Expanded(child: img(0,size))
    );
  }
  Widget img1t2(){
    return SizedBox(
      height: size/2,
      width: size,
      child: Row(
        children: [
        Expanded(child: img(0,size/2)),
        Expanded(child: img(1,size/2))
      ],)
    );
  }
  Widget img1t3(){
    return SizedBox(
      height: size/3,
      width: size,
      child: Row(children: [
        Expanded(child: img(0,size/3)),
        Expanded(child: img(1,size/3)),
        Expanded(child: img(2,size/3))
      ],)
    );
  }
  Widget img2t2(){
    return SizedBox(
      height: size,
      width: size,
      child: Column(children: [
        Expanded(child: Row(children: [
          Expanded(child: img(0,size/2)),
          Expanded(child: img(1,size/2)),
        ],)),
        Expanded(child: Row(children: [
          Expanded(child: img(2,size/2)),
          Expanded(child: img(3,size/2)),
        ],))
      ],)
    );
  }
  Widget img2t3(){
    return SizedBox(
      height: size*2/3,
      width: size,
      child: Column(children: [
        Expanded(child: Row(children: [
          Expanded(child: img(0,size/3)),
          Expanded(child: img(1,size/3)),
          Expanded(child: img(2,size/3)),
        ],)),
        Expanded(child: Row(children: [
          Expanded(child: img(3,size/3)),
          Expanded(child: img(4,size/3)),
          Expanded(child: img(5,size/3)),
        ],))
      ],)
    );
  }
  Widget img3t3(){
    return SizedBox(
      height: size,
      width: size,
      child: Column(children: [
        Expanded(child: Row(children: [
          Expanded(child: img(0,size/3)),
          Expanded(child: img(1,size/3)),
          Expanded(child: img(2,size/3)),
        ],)),
        Expanded(child: Row(children: [
          Expanded(child: img(3,size/3)),
          Expanded(child: img(4,size/3)),
          Expanded(child: img(5,size/3)),
        ],)),
        Expanded(child: Row(children: [
          Expanded(child: img(6,size/3)),
          Expanded(child: img(7,size/3)),
          Expanded(child: img(8,size/3)),
        ],))
      ],)
    );
  }
}