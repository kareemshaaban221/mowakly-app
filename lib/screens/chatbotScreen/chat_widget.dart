// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.msg, required this.chatIndex})
      : super(key: key);

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
              alignment: chatIndex == 0? Alignment.centerRight :Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: chatIndex==0? TextDirection.ltr :TextDirection.rtl,
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(chatIndex == 0? 0xFF1BE5BF :0xFFE6EBEB),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(msg),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      backgroundColor:  Color(chatIndex==0?  0xff0B3939:0xffffffff),
                      radius: 20,
                      child: Image.asset(
                        fit: BoxFit.cover,
                        chatIndex==0? 'asset/help.png': 'asset/chatbot-black.png',
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
