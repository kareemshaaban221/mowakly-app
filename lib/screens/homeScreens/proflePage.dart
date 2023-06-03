import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Center(child: Text('profile')),
            SizedBox(height: 140,) //خليها دايما مسافة من تحت عشان الاب بار ميغطيش ع الكونتنت
          ],
        ),
      ),
    );
  }
}
