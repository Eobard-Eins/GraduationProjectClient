import 'dart:io';

import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgFromLocal extends StatelessWidget {
  final XFile? image;
  final double? size;
  final Color? backgroundColor;
  final BoxShape? boxShape;
  final bool needBorder;
  final Function()? close;
  final double? closeButtonSize;

  const ImgFromLocal({super.key,this.image,this.size, this.backgroundColor,this.boxShape,this.needBorder=true,this.close,this.closeButtonSize});

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        Container(
          width: size ?? 100,
          height: size ?? 100,
          decoration: BoxDecoration(
            shape: boxShape ?? BoxShape.rectangle,
            border: needBorder? Border.all(color: backgroundColor??Coloors.greyLight):null,
            color: backgroundColor??Coloors.greyLight,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(image!.path)),
            ),
          ),
          clipBehavior: Clip.hardEdge,
        ),
        // 在右上角添加一个按钮
        Positioned(
          top: 0, // 距离顶部0距离
          right: 0, // 距离右边0距离
          width: (size??100)/6,
          height: (size??100)/6,
          child: Material(
            borderRadius: BorderRadius.circular(0),
            color: close==null?Colors.transparent:Coloors.grey, // 可选，设置圆角以美化按钮样式
            child: InkWell(
              onTap: close,
              child: Icon(Icons.close, color: close==null?Colors.transparent:Colors.white,size: closeButtonSize??16,), // 使用图标作为小按钮
            ), // 设置按钮背景颜色
          ),
        ),
      ],
    );
    // CircleAvatar(
    //   foregroundImage: image==null?null:FileImage(File(image!.path)),
    //   backgroundColor: backgroundColor??Coloors.greyLight,
    //   radius: size??26,
    // );
  }
}