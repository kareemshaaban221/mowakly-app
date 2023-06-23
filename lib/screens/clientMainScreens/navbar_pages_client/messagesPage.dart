import 'package:flutter/material.dart';

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
            SizedBox(height: 200,),
            Center(child: Text('msgs')),
            SizedBox(height: 140,) //خليها دايما مسافة من تحت عشان الاب بار ميغطيش ع الكونتنت
          ],
        ),
      ),
    );
  }
}
