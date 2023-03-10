import 'package:flutter/material.dart';
import 'package:fp/component/components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 88,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'الإشعارات',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0B3939),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: Color(0xffE6EBEB),
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: Text(
                      'جعل الكل مرئي',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff0B3939),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 100.w,
              height: 62.h,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return NotificationItem(
                      event: 'لقد نجحت في تغيير كلمة السر الخاصة بك',
                      dayWeek: 'الأربعاء',
                      date: '16-3-2-23',
                      hour: '10:15');
                },
              ),
            ),
            const SizedBox(
              height: 140,
            )
          ],
        ),
      ),
    );
  }
}

Widget NotificationItem({
  required String event,
  required String dayWeek,
  required String date,
  required String hour,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        textDirection: TextDirection.rtl,
        children: [
          //notification details
          Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff0B3939),
                      radius: 7,
                    ),
                  ),
                  Text(
                    event,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0B3939),
                    ),
                  ),
                ],
              ),
              //notification time
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14.sp,
                    color: Color(0xffCDD6D6),
                  ),
                  Text(
                    dayWeek,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffCDD6D6),
                    ),
                  ),
                  SizedBox(
                    width: 4.6.w,
                  ),
                  Text(
                    date,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffCDD6D6),
                    ),
                  ),
                  SizedBox(
                    width: 4.6.w,
                  ),
                  Icon(
                    Icons.access_time_rounded,
                    size: 14.sp,
                    color: Color(0xffCDD6D6),
                  ),
                  Text(
                    hour,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffCDD6D6),
                    ),
                  )
                ],
              )
            ],
          ),

          // avatar
          CircleAvatar(
            backgroundColor: Color(0xff0B3939),
            radius: 34,
            child: ClipOval(
                child: Image.asset(
              '${assetImage}help.png',
              fit: BoxFit.cover,
            )),
          ),
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
