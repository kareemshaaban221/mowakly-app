



import 'package:flutter/material.dart';
import 'package:fp/component/components.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
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
                focusedDay: DateTime.parse('2023-06-06'),


                currentDay: DateTime.now(),
                eventLoader: (day) {
                  if (day == DateTime.utc(2023,6,6)) {
                    return ['Cyclic event',''];
                  }

                  return [];
                },
                headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),


                onDaySelected: (selectedDay, focusedDay) {
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
                          Text('data'),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: TextDirection.rtl,
                          children:  [
                          Text('data'),
                            SizedBox(width: 2.w,),
                            Text('data'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                separatorBuilder: (context, index) => SizedBox(height: 0.1.h,), itemCount:3),
          ),
          SizedBox(height:2.h),
          build_button(title: 'إضافة ميعاد جديد', ontap: (){})
        ],
      ),
    );
  }
}
