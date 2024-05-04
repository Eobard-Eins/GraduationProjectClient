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
        padding: const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 15),
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
                            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            messageText,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(time,style: const TextStyle(fontSize: 12,),),
                      Padding(padding: const EdgeInsets.only(top: 3),child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: isMessageRead?Colors.transparent:Colors.red,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),)
                    ],
                  )
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
