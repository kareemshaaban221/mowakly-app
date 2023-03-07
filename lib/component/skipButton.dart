import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SkipButton extends StatelessWidget {
  VoidCallback onPress;

  SkipButton({required this.onPress});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 4.h,
        width: 24.w ,
        decoration: BoxDecoration(
          color:  Color(0x88bbbbbb),
          borderRadius: BorderRadius.circular(31.pt),

        ),
        child: Center(
            child: Text(
              'تخطي',
              style: GoogleFonts.cairo(
                  color: Color(0xffFFFFFF),
                  fontSize: 16
              ),)
        ),
      ),
    );
  }
}
