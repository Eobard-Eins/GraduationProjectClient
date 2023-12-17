import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircleAvatarOfUser extends StatelessWidget {
  final XFile? image;
  final double? size;
  final Color? backgroundColor;
  final Color? roundColor;

  const CircleAvatarOfUser({super.key,this.image,this.size, this.backgroundColor, this.roundColor});

  @override
  Widget build(BuildContext context) {
    
    return CircleAvatar(
      backgroundImage: const AssetImage("assets/images/default_avatar.png"),
      foregroundImage: image==null?null:FileImage(File(image!.path)),
      backgroundColor: backgroundColor,
      radius: size??26,
    );
  }
}