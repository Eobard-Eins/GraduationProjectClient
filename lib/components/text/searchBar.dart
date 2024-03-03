import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final double? height;
  final double? width;
  final String hintText;
  final Function()? prefixIconFunc;
  final Function(String) onChanged;
  final Widget? suffixIcon;

  const SearchInput(
      {super.key,
      required this.controller,
      this.height,
      this.width,
      required this.hintText,
      this.prefixIconFunc,
      this.suffixIcon, 
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height??40,
      child: TextField(
        controller: controller,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 16
        ),
        onChanged: onChanged,
        cursorColor: Coloors.main,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Coloors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Coloors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Coloors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: prefixIconFunc,
            ),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.only(top:0,bottom: 0),

          ),
      ),
    );
  }
}
