// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:fp/screens/LawyersScreen/lawyersScreen.dart';
import 'package:fp/screens/chatbotScreen/chatbot_api_service.dart';
import 'package:fp/screens/chatbotScreen/chat_model.dart';
import 'package:fp/screens/chatbotScreen/chat_widget.dart';
import 'package:fp/component/appbars/chatbot_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  bool _isLoading = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrollController;

  @override
  void initState() {
    getWelcome();
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
  String lastMsg = '';
  String category = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatBotAppBar(),
      body: SafeArea(
        child: Column(children: [
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
          if (lastMsg.startsWith('القضية دي تصنيفها')) ...[
            YesNoWidget(onYes: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawyersScreen(category: category),
                  ));
            }, onNo: () {
              Navigator.of(context).pop();
            }),
          ],
          if (_isLoading) ...[
            const SpinKitThreeBounce(
              color: Colors.grey,
              size: 18,
            ),
          ],
          const SizedBox(
            height: 15,
          ),
          if (!lastMsg.startsWith('القضية دي تصنيفها')) ...[
            MessageTextField(
                focusNode: focusNode,
                textEditingController: textEditingController,
                onSubmit: () async {
                  await sendMessage();
                }),
          ],
        ]),
      ),
    );
  }

  void scrollListToEnd() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut);
  }

  Future<void> sendMessage() async {
    if (textEditingController.text.isNotEmpty) {
      try {
        String msg = textEditingController.text;
        setState(() {
          _isLoading = true;
          chatList
              .add(ChatModel(msg: textEditingController.text, chatIndex: 0));
          textEditingController.clear();
          focusNode.unfocus();
        });
        chatList.addAll(await ChatbotApiService.sendMessage(message: msg));

        ChatModel last = chatList[chatList.length - 1];
        lastMsg = last.msg;
        print(lastMsg);

        RegExp regExp = RegExp(r'\((.*?)\)');
        RegExpMatch? match = regExp.firstMatch(lastMsg);

        if (match != null) {
          String? word = match.group(1);
          if (word != null) {
            print('The word inside the parentheses is $word');
            category = word;
          } else {
            print('Could not find the word in brackets in the message');
          }
        } else {
          print('Could not find the word in brackets in the message');
        }

        print(category);
        if(category == 'اسره') {
          category = 'أسرة';
        }

        setState(() {});
      } catch (e) {
        log('error: $e');
      } finally {
        setState(() {
          scrollListToEnd();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> getWelcome() async {
    try {
      setState(() {
        _isLoading = true;
      });
      chatList.addAll(await ChatbotApiService.getWelcomeMessage());
      setState(() {});
    } catch (e) {
      log('error: $e');
    } finally {
      setState(() {
        scrollListToEnd();
        _isLoading = false;
      });
    }
  }
}

Widget MessageTextField(
    {required focusNode, required textEditingController, required onSubmit}) {
  return Padding(
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
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: textEditingController,
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
              onPressed: onSubmit,
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
  );
}

Widget YesNoWidget({required VoidCallback onYes, required VoidCallback onNo}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onYes,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
            decoration: BoxDecoration(
              color: Color(MINT_GREEN),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(MINT_GREEN)),
            ),
            child: TextWidget(
              label: 'نعم',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: onNo,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(MINT_GREEN)),
            ),
            child: TextWidget(
              label: 'لا',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
