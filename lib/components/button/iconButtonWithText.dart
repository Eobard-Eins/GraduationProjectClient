import 'package:flutter/material.dart';

class IconButtonWithText extends StatelessWidget{
  final IconData icon;
  final String str;
  final Function()? onTap;
  final double? iconSize;
  final double? fontSize;

  const IconButtonWithText({super.key, required this.icon, required this.str, this.onTap, this.iconSize, this.fontSize});

  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent, // 透明色
      child:Column(children: [
        Padding(padding: const EdgeInsets.only(bottom: 2),child: Icon(icon,size:iconSize),),
        Text(str,style: TextStyle(fontSize: fontSize),)
      ],)
    );
  }
}