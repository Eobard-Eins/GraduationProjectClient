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
      child:Column(children: [
        Icon(icon,size:iconSize),
        Text(str,style: TextStyle(fontSize: fontSize),)
      ],)
    );
  }
}