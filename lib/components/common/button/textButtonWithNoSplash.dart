import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';

class TextButtonWithNoSplash extends StatelessWidget {
  final Function()? onTap;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String text;
  final TextStyle? textStyle;

  const TextButtonWithNoSplash(
      {super.key,
      required this.onTap,
      this.textStyle,
      this.color,
      this.fontSize,
      this.fontWeight,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: onTap,
      highlightColor: Colors.transparent, // 透明色
      splashColor: Colors.transparent,
      child: Text(
          text,
          style: textStyle??TextStyle(
            color: color ?? Coloors.mainLight,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.normal,
          )), //
    );
  }
}
