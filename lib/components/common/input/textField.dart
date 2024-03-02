import 'package:flutter/material.dart';

class UserTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final int? maxLength;
  final bool? obscureText;
  final int? maxLines;
  final BoxConstraints? suffixIconConstraints;
  final TextInputAction? textInputAction;

  const UserTextFieldWidget(
      {super.key,
      this.controller,
      this.textInputAction,
      this.hintText,
      this.readOnly,
      this.textAlign,
      this.keyboardType,
      this.prefixText,
      this.onTap,
      this.suffixIcon,
      this.suffix,
      this.onChanged,
      this.onEditingComplete,
      this.suffixIconConstraints,
      this.maxLength,
      this.maxLines, 
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: readOnly==true?null:keyboardType,
      onTap: onTap,
      onChanged: onChanged,
      maxLength: maxLength??25,
      maxLines: maxLines??1,
      obscureText: obscureText??false,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      cursorColor: Colors.grey,
      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        counterText: "",
        prefixText: prefixText,
        suffix: suffix,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w100),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
