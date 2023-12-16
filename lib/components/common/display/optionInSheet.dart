
import 'package:flutter/material.dart';

//横向的选项，用于弹窗
class OptionInSheet extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Icon? icon;
  const OptionInSheet({super.key, required this.text, this.onTap, this.icon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent, // 透明色
      splashColor: Colors.transparent,
      child:  Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  const SizedBox(width: 20,),
                  icon??Container(),
                  SizedBox(width: (icon==null)?0:15,),
                  Text(text, style: const TextStyle(fontSize: 16, color: Colors.black)),
                  const Spacer(),
                ],
              ),
            ),
            
            Divider(color: Colors.grey.withOpacity(0.2),height: 2,),
            
          ],
        ),
    );
  }
}