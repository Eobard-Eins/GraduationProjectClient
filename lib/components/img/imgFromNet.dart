import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';

class ImgFromNet extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxShape? boxShape;
  final Color? color;
  
  const ImgFromNet({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.boxShape,
    this.color
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??100,
      height: height??100,
      decoration: BoxDecoration(
        color: color??Coloors.greyLight,
        shape: boxShape??BoxShape.rectangle,
        image: DecorationImage(
          fit: BoxFit.cover, // 设置图片填充方式（如：适应容器尺寸）
          image: NetworkImage("https://$imageUrl"),
        ),
      ),
      clipBehavior: Clip.hardEdge,
    );
  }
}