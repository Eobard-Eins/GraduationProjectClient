// ignore_for_file: file_names

import 'package:client_application/components/img/imgFromNet.dart';
import 'package:client_application/pages/home/chat/chatDetailPageUI.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final String messageText;
  final String time;
  final bool isMessageRead;
  final Function()? onTap;

  const ConversationList({super.key, required this.name, required this.email, required this.imageUrl, required this.time, required this.messageText, required this.isMessageRead, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  ImgFromNet(imageUrl: imageUrl, width: 50,height: 50, boxShape: BoxShape.circle,),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,size: 15,),
            const SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }
}
