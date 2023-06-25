// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWidgetClient extends StatelessWidget {
  const ChatWidgetClient({Key? key, required this.msg, required this.chatIndex})
      : super(key: key);

  final String msg;
  final String chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: chatIndex == 'me'? Alignment.centerRight :Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: chatIndex=='me'? TextDirection.ltr :TextDirection.rtl,
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(chatIndex == 'me'? 0xFF1BE5BF :0xFFE6EBEB),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(msg, textAlign: TextAlign.right, style: GoogleFonts.cairo(fontSize: 14)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      backgroundColor:  Color(chatIndex=='me'?  0xff0B3939:0xffffffff),
                      radius: 20,
                      child: Image.asset(
                        fit: BoxFit.cover,
                        chatIndex=='me'? 'asset/user_avatar.png': 'asset/user_avatar.png',
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
