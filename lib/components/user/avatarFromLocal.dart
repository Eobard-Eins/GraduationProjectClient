import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class avatarFromLocal extends StatelessWidget {
  final XFile? image;
  final double? size;
  final Color? backgroundColor;
  final Color? roundColor;

  const avatarFromLocal({super.key,this.image,this.size, this.backgroundColor, this.roundColor});

  @override
  Widget build(BuildContext context) {
    
    return CircleAvatar(
      foregroundImage: image==null?null:FileImage(File(image!.path)),
      backgroundColor: backgroundColor,
      radius: size??26,
    );
  }
}