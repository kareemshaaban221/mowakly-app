// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: 12.h),
          SideDrawerElement(label: 'الرئيسية', onPress: () {}),
          SideDrawerElement(label: 'طلب استشارة', onPress: () {}),
          SideDrawerElement(label: 'الصفحة الشخصية', onPress: () {}),
          SideDrawerElement(label: 'الإعدادات', onPress: () {}),
          SideDrawerElement(label: 'تواصل معنا', onPress: () {}),
          SideDrawerElement(label: 'من نحن', onPress: () {}),
          SideDrawerElement(label: 'الأسئلة الشائعة', onPress: () {}),
          SideDrawerElement(label: 'الرسائل', onPress: () {}),
        ],
      ),
    );
  }
}

Widget SideDrawerElement({required String label, required VoidCallback onPress}){
  return InkWell(
    onTap: onPress,
    child: Column(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: CircleAvatar(
                backgroundColor: Color(0xff0B3939),
                radius: 7,
                child: CircleAvatar(
                  backgroundColor: Color(0xff1BE5BF),
                  radius: 5,
                ),
              ),
            ),
            Text(label, style:GoogleFonts.cairo(
                fontSize: 18.sp
            ),),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
          child: Divider(thickness: 1,),
        )
      ],
    ),
  );
}
