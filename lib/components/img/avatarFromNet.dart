import 'package:flutter/material.dart';

class AvatarFromNet extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxShape? boxShape;
  
  const AvatarFromNet({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.boxShape
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
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