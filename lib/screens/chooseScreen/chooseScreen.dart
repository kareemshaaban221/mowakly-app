import 'package:flutter/material.dart';
import 'package:fp/component/clientCard.dart';
import 'package:fp/screens/loginScreen/loginScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset('asset/head.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'برجاء الإختيار',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: Color(0xff0B3939)),
              ),
            ),
            ClientCard(
              asset: 'asset/lawyer.png',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(userType: 'lawyer'),
                    ));
              },
              backgroundColor: 0xff0B3939, label: 'محامي',
            ),
            SizedBox(
              height: 6.h,
            ),
            ClientCard(
              asset: 'asset/client.png',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(userType: 'client'),
                    ));
              },
              backgroundColor: 0xff1BE5BF, label: 'عميل',
            ),
          ],
        ),
      ),
    );
  }
}
