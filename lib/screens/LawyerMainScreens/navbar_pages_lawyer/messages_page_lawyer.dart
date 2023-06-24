import 'package:flutter/material.dart';
import 'package:fp/component/complete_widgets/messages_widget.dart';
import 'package:fp/screens/massageScreen/massageScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class MessagesPageLawyer extends StatefulWidget {
  const MessagesPageLawyer({Key? key}) : super(key: key);

  @override
  State<MessagesPageLawyer> createState() => _MessagesPageLawyerState();
}

class _MessagesPageLawyerState extends State<MessagesPageLawyer> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            SizedBox(height: 140,) ,
          ],
        ),
      ),
    );
  }
}
