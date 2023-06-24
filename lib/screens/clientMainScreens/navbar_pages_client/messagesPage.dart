import 'package:flutter/material.dart';
import 'package:fp/component/complete_widgets/messages_widget.dart';
import 'package:fp/screens/massageScreen/massageScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            MessagesWidget(),
            SizedBox(
              width: 100.w,
              height: 62.h,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MassageScreen(),));
                    },
                    child: MessagesItem(
                        event: 'احمد مسعد أبوالخير',
                        dayWeek: 'الأربعاء',
                        date: '16-3-2-23',
                        hour: '10:15'),
                  );
                },
              ),
            ),
            SizedBox(height: 140,) //خليها دايما مسافة من تحت عشان الاب بار ميغطيش ع الكونتنت
          ],
        ),
      ),
    );
  }
}
