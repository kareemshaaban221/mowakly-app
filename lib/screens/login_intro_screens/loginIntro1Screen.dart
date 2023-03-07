import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginIntro1Screen extends StatelessWidget {
  const LoginIntro1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Image.asset("asset/easy.png"),),
            SizedBox(height: 8.h,),

            Text('معاك هنسهل عليك', style: GoogleFonts.cairo(
              color: Color(0xff1BE5BF),
              fontSize: 8.w
            ),),


            Text('حل مشكلة الوصول للمحامي المناسب', style: GoogleFonts.cairo(
              color: Color(0xff0B3939),
              fontSize: 6.w
            ),),


          ],
        ),
      ),
    );
  }
}
