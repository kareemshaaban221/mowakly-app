import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClientCard extends StatelessWidget {

  String label;
  String asset;
  VoidCallback onPress;
  int backgroundColor ;
  ClientCard({required this.label, required this. asset, required this.backgroundColor,required this.onPress});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 18.h,
        width:  18.h ,
        decoration: BoxDecoration(
          color:  Color(backgroundColor),
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
            SizedBox(height: 8.8.h,
                child: Image.asset(asset)),
            Text(label,style: GoogleFonts.cairo(color: Color(0xffffffff),fontSize: 18.sp, fontWeight: FontWeight.w800),)
          ],
        ),
      ),
    );
  }
}
