import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fp/screens/chatbotScreen/chat_api_service.dart';
import 'package:fp/screens/chatbotScreen/chat_model.dart';
import 'package:fp/screens/chatbotScreen/chat_widget.dart';
import 'package:fp/screens/chatbotScreen/chatbot_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrollController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    _listScrollController = ScrollController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _listScrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatBotAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _listScrollController,
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatList[index].msg,
                    chatIndex: chatList[index].chatIndex,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.grey,
                size: 18,
              ),
            ],
            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffeeeeee),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: 76.w,
                        child: TextField(

                          focusNode: focusNode,
                          textAlign: TextAlign.right,
                          style: const TextStyle(color: Colors.black,),
                          controller: textEditingController,
                          onSubmitted: (value) async {
                            await sendMessageFCT();
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: 'اكتب رسالتك هنا',
                              hintTextDirection: TextDirection.rtl,
                              hintStyle: GoogleFonts.cairo(
                                color: Colors.grey,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff0B3939),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await sendMessageFCT();
                        },
                        icon: Transform.rotate(
                          angle: 315 * 3.14 / 180, // 45 degrees in radians
                          child: const Icon(
                            Icons.send_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListToEnd() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT() async {
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        textEditingController.clear();
        focusNode.unfocus();
      });
      chatList.addAll(await ApiService.sendMessage(message: msg));
      setState(() {});
    } catch (e) {
      log('error: $e');
    } finally {
      setState(() {
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
}
