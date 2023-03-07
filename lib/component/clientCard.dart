import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClientCard extends StatelessWidget {

  String label;
  String asset;
  VoidCallback onPress;

  ClientCard({required this.label, required this. asset, required this.onPress});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 20.h,
        width:  20.h ,
        decoration: BoxDecoration(
          color:  Color(0xffffffff),
          borderRadius: BorderRadius.circular(4.pt),
          boxShadow: const [
            BoxShadow(
              color: Color(0x990B3939),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset),
            Text(label,style: GoogleFonts.cairo(color: Color(0xff0B3939),fontSize: 28, fontWeight: FontWeight.w800),)
          ],
        ),
      ),
    );
  }
}
