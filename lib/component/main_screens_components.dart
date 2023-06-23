// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/constant_colors.dart';



Widget SearchBox(){
  return Container(
    color:  Color(MINT_GREEN),
    child: Container(
      padding: const EdgeInsets.all(24),
      child: TextField(
        autocorrect: false,
        textAlign: TextAlign.right,
        style: const TextStyle(color: Color(0xff000000)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: const Color(0xffCDD6D6),
            size: 20.sp,
          ),
          hintText: ' ابحث من هنا',
          hintStyle: GoogleFonts.cairo(
              fontSize: 14.8.sp,
              color: const Color(0xffCDD6D6),
              fontWeight: FontWeight.w600),
          fillColor: Colors.white,
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(28.0)),
              borderSide: BorderSide(color: Color(0xffffffff))),
          focusedBorder: const OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(28.0)),
              borderSide: BorderSide(color: Color(0xff0B3939))),
          filled: true,
        ),
      ),
    ),
  );
}

Widget TFLabel({required String label}){
  return  Row(
    textDirection: TextDirection.rtl,
    children: [
      Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          color: Color(MINT_GREEN),
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(DARK_GREEN),
            width: 2,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(label, style: GoogleFonts.cairo(),),
      ),
    ],
  );
}

Widget TextView({required String text}){
  return  Padding(
    padding: const EdgeInsets.only(top: 4.0, bottom: 16),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffd3d3d3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textDirection: TextDirection.rtl,
            text, style: GoogleFonts.cairo(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ),
  );
}


Widget ProfilePicture(){
  return Stack(
    children: [
      Container(
        height: 130,
        width: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(DARK_GREEN),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'asset/user_avatar.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: (130 - 30) / 2,
        child: Center(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(MINT_GREEN),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}