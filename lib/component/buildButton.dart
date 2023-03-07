import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildButton extends StatelessWidget {

String title ;
VoidCallback onPress;
int color;

BuildButton({required this.title, required this.onPress,  required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          height: 7.02.h,
          width: 70.w ,
          decoration: BoxDecoration(
          color:  Color(color),
            borderRadius: BorderRadius.circular(31.pt),
            boxShadow: const [
            BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            ),
            ],
            ),
            child: Center(
            child: Text(
            title,
            style: GoogleFonts.cairo(
            color: Color(0xffFFFFFF),
            fontSize: 32
            ),)
            ),
      ),
    );
  }
}
