// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class ChatMessage {
  String messageContent;
  String avatar;
  String username;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType, required this.avatar, required this.username});
}
