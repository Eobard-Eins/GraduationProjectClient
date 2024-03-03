
import 'package:flutter/material.dart';

//弹窗上方的横条
class ShortHeadBar extends StatelessWidget{
  const ShortHeadBar({super.key, this.height, this.width, this.color});
  final double? height;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:height??4,
      width: width??40,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color:color??Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}