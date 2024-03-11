
import 'package:flutter/material.dart';

class LittleButton extends StatelessWidget{
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  final double? height;
  final double? width;
  final double? size;
  final Color? color;
  const LittleButton({super.key,required this.text,required this.onTap,required this.icon, this.height, this.width, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent, // 透明色
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
        decoration: BoxDecoration(
          color: color??const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(children: [
          Icon(icon,size:size??16,color: Colors.black,),
          Padding(padding: EdgeInsets.only(left: text.isEmpty?0:2,),child:Text(text,style: const TextStyle(color: Colors.black,fontSize: 12),),),
          
        ],),
      ),
    );
  }
}