import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget MessagesWidget(){
  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  'الرسائل',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff0B3939),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: const BoxDecoration(
                      color: Color(0xffE6EBEB),
                      borderRadius: BorderRadius.all(Radius.circular(28))),
                  child: Text(
                    'جعل الكل مرئي',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff0B3939),
                    ),
                  ),
                )
              ],
            ),
          ),


        ],
      ),
    ),
  );
}

Widget MessagesItem({
  required String event,
  required String dayWeek,
  required String date,
  required String hour,
}) {
  return Column(

    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          //notification details
          CircleAvatar(
            backgroundColor: const Color(0xff0B3939),
            radius: 34,
            child: ClipOval(
                child: Image.asset(
                  'asset/user_avatar.png',
                  fit: BoxFit.fill,
                )),
          ),
          SizedBox(width: 5.w,),
          Column(
            children: [

              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(
                    event,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff0B3939),
                    ),
                  ),

                ],
              ),
              //notification time
              Row(

                textDirection: TextDirection.rtl,
                children: [
                  // SizedBox(
                  //   width: 4.6.w,
                  // ),

                  Text(
                    dayWeek,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffCDD6D6),
                    ),
                  ),


                ],
              )
            ],
          ),

          // avatar

        ],
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
        child: Divider(
          thickness: 1,
        ),
      )
    ],
  );
}