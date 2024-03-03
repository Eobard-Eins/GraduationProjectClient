import 'package:flutter/material.dart';

class ScrollableText extends StatelessWidget {
  final String text;

  const ScrollableText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Text(
          text,
          style: const TextStyle(
              color: Color.fromARGB(255, 94, 94, 94),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
        ),
      ),
    );
  }
}