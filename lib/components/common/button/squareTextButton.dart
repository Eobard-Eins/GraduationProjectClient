import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';

class SquareTextButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const SquareTextButton({super.key, required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(onTap == null? Colors.grey : Coloors.main),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
          textStyle: MaterialStateProperty.all(const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          )),
        ),
        onPressed: onTap,
        child:Padding(padding: const EdgeInsets.only(bottom:2),child: Text(text,),)
      );
  }
}