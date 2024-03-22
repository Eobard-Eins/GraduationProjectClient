import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';

class HorizontalButton extends StatelessWidget{
  final String text;
  final IconData icon;
  final IconData? iconSuffix;
  final Function()? onTap;
  final double? height;
  final double? iconSize;
  final double? fontSize;
  final bool needDivider;

  HorizontalButton({required this.text,required this.icon,this.iconSuffix,required this.onTap,this.height,this.iconSize,this.fontSize,this.needDivider=true});

  @override
  Widget build(BuildContext context) {
    return horizontalButton(text,icon,iconSuffix??Icons.chevron_right,onTap,height??40,iconSize??20,fontSize??16);
  }

  Widget horizontalButton(String text,IconData iconA, IconData  iconB,Function()? onTap,double height,double iconSize,double fontSize){
    return Column(children: [
      InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: SizedBox(
          height: height,
          child: Row(
            children: [
                Padding(padding: const EdgeInsets.only(right: 10),child: Icon(iconA,color: Coloors.greyDeep,size:iconSize),),
                Expanded(child: Text(text,style: TextStyle(fontSize: fontSize,color: Coloors.greyDeep),),),
                Padding(padding: const EdgeInsets.only(left: 5,right: 5),child: Icon(iconB,color: Coloors.greyDeep,size:iconSize-2),),
              ],
            ),
        )
      ),
      Padding(padding: const EdgeInsets.only(top: 10,bottom: 10),child:Divider(height:0.2,indent:0,endIndent: 0,color: needDivider?Coloors.greyLight:Colors.transparent,),),
    ],);
  }
}