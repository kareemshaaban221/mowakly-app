import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatBotAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatBotAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: Color(0xFF1BE5BF),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 14.w),
          child: Text(
            'شات بوت موكلي',
            style: GoogleFonts.cairo(
              height: 2.8,
              color: const Color(0xffffffff),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.w,
            top: 12,
            bottom: 12,
            right: 12.w,
          ),
          child: Image.asset('asset/chatbot-white.png'),
        ),
      ],
    );
  }
}