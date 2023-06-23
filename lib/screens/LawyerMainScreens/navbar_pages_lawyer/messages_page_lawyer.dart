import 'package:flutter/material.dart';


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
            SizedBox(height: 200,),
            Center(child: Text('msgs lawyer')),
            SizedBox(height: 140,) ,
          ],
        ),
      ),
    );
  }
}
