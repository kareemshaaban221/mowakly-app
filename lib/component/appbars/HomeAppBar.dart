// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fp/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar({super.key, this.hideAppbar});

  bool? hideAppbar;

  @override
  Size get preferredSize => hideAppbar?? false ? Size.zero : const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    if (hideAppbar ?? false){
      return const SizedBox.shrink(); // return a zero-sized widget
    } else {
      return AppBar(
        backgroundColor: const Color(0xff1BE5BF),
        iconTheme: const IconThemeData(color: Color(0xff0B3939)),
        elevation: 0,
        actions: [
          Text(
            userName,
            style: GoogleFonts.cairo(
                color: const Color(0xff0B3939),
                fontSize: 16.sp,
                height: 3.6,
                fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,),
            child: CircleAvatar(
              backgroundColor: const Color(0xff0B3939),
              radius: 34,
              child: ClipOval(
                  child: Image.asset(userAvatar,  fit: BoxFit.cover,)
              ),
            ),
          ),
        ],
      );
    }
  }
}

