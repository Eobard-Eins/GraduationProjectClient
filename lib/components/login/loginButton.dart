
import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function()? onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: onPressed == null? [Color.fromARGB(255, 186, 186, 186),const Color.fromARGB(255, 149, 149, 149),] : [ Coloors.mainLoginButton, Coloors.mainLight],
        ),  
      ),
      child: IconButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            alignment: Alignment.center,
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_forward,color: Colors.white,size: 40,)
        
      ),
    );
  }
}