import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/date_symbol_data_local.dart' as int;

import 'Message.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<Message> messages = [
    Message(
        text: 'السلام عليكم ورحمة الله وبركاته',
        date: DateTime.now().subtract(const Duration(days: 8,hours: 5)),
        isSentByMe: true),
    Message(
        text: 'وعليكم السلام ورحمة الله وبركاته',
        date: DateTime.now().subtract(const Duration(days: 8, minutes: 10)),
        isSentByMe: false),
    Message(
        text: 'لو سمحت عايز استفسر عن حاجة',
        date: DateTime.now().subtract(const Duration(days: 7, minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'اتفضل حضرتك',
        date: DateTime.now().subtract(const Duration(days: 7, minutes: 10)),
        isSentByMe: false),
    Message(
        text: 'text',
        date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'text',
        date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'text',
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'text',
        date: DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'text',
        date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'text',
        date: DateTime.now().subtract(const Duration(days: 1, minutes: 10)),
        isSentByMe: true),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B3939),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xFF1BE5BF),
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Color(0xFF1BE5BF),
                )),
            Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: Text(
                'شات بوت موكلي',
                style: GoogleFonts.cairo(
                    height: 2.8,
                    color: const Color(0xffffffff),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 4.w, top: 12, bottom: 12, right: 12.w),
              child: Image.asset('asset/chatbot-white.png'),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: GroupedListView<Message, DateTime>(
                padding: EdgeInsets.all(8),
                reverse: true,
                order: GroupedListOrder.DESC,
                // useStickyGroupSeparators: true,
                // floatingHeader: true,
                elements: messages,
                groupBy: (messages) => DateTime(
                  messages.date.year,
                  messages.date.month,
                  messages.date.day,
                ),
                groupHeaderBuilder: (Message message) => SizedBox(
                  height: 80,
                  child: Center(
                    //date of msgs
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: const BoxDecoration(
                            color: Color(0xffE6EBEB),
                            borderRadius: BorderRadius.all(Radius.circular(28))),
                        child:
                        Text(
                          DateFormat("dd/MM/yyy").format(message.date),
                          style: GoogleFonts.cairo(color: Color(0xff0B3939)),
                        ),
                      )
                    ),
                  ),
                ),
                itemBuilder: (context, Message message) => message.isSentByMe?
                SentMsgWidget(msg: message.text):
                RecieveMsgWidget(msg: message.text)

              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0xFFE6EBEB),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  hintText: ('اكتب رسالتك هنا'),
                  hintStyle: GoogleFonts.cairo(),
                ),
                onSubmitted: (text) {
                  final message = Message(
                      text: text, date: DateTime.now(), isSentByMe: true);
                  setState(() {
                    messages.add(message);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget SentMsgWidget({required String msg}) {
    return Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1BE5BF),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(msg),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor: const Color(0xff0B3939),
                radius: 24,
                child: ClipOval(
                    child: Image.asset(
                      'asset/help.png',
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ],
        ));
  }
  Widget RecieveMsgWidget({required String msg}) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white, // change this to your desired background color
                  borderRadius: BorderRadius.circular(50), // set half the width/height to get a circular shape
                ),
                child: Image.asset('asset/chatbot-black.png'),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE6EBEB),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(msg),
              ),
            ),
          ],
        ));
  }
}
//1BE5BF mint
//E6EBEB grey
