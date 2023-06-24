



import 'package:flutter/material.dart';
import 'package:fp/component/components.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsScreen extends StatefulWidget {
   AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();

}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  DateTime _focusedDay=DateTime.now();
  DateTime _selectedDay=DateTime.now();
 int count=0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xff1BE5BF),

        title: Text('الجدول'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 3.h,),
          Center(
            child: Container(
              height: 45.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
              ),
              child: TableCalendar(
                  firstDay: DateTime(2010),
                  lastDay: DateTime(2030),
                focusedDay: _focusedDay,


               // currentDay: DateTime.now(),
                eventLoader: (day) {
                  if (day == DateTime.utc(2023,6,30)) {
                    return ['Cyclic event'];
                  }

                  return [];
                },
                headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),

                selectedDayPredicate: (day) {

                  return isSameDay(_selectedDay, day);

                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    if(_selectedDay==DateTime.utc(2023,6,30)){
                        count=1;
                    }
                    else{

                        count=0;

                    }
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 1.h,),
          SizedBox(
            height: 26.5.h,
            width: 85.w,
            child: ListView.separated(itemBuilder:(context, index) => Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height:11.5.h ,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),

                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children:  [
                         const CircleAvatar(radius: 15,),
                          SizedBox(width: 2.w,),
                          Text('مقابلة المحامي محمد  في المكتب',
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff0B3939),
                          ),)
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: TextDirection.rtl,
                          children:  [
                          Text('اريد مقابلة المحامي محمد في مكتبه الخاص',
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffCDD6D6),
                          ),),
                            SizedBox(width: 2.w,),
                            Text('3:00 pm'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                separatorBuilder: (context, index) => SizedBox(height: 0.1.h,), itemCount:count),
          ),
          SizedBox(height:2.h),
          build_button(title: 'إضافة ميعاد جديد', ontap: (){})
        ],
      ),
    );
  }
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;

      });
    }
  }
}
