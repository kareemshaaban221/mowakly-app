import 'package:flutter/material.dart';
import 'package:fp/component/components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 21.81.h,
            width: 59.07.w,
          ),
          //
          build_text_filed(label: 'الاسم بالكامل'),
          SizedBox(height: 4.1.h,),
          build_text_filed(label: 'البريد الإلكتروني'),
          SizedBox(height: 4.1.h,),
          build_text_filed(label: 'كلمة المرور'),
          SizedBox(height: 4.1.h,),
          build_text_filed(label: 'كلمة المرور الجديدة'),
          SizedBox(height: 3.85.h,),
          build_button(title: 'التالــــــي'),

          SizedBox(
            height: 4.12.h,
          ),

          SizedBox(
            height:2.56.h,
            width: 78.03.w,
            child: Row(
              children: [
                build_line(),
                SizedBox(width: 6.30.w),
                Text('أو سجل الدخول عن طريق',style: TextStyle(fontSize: 13.2.sp)),
                SizedBox(width: 6.30.w),
                build_line(),
              ],
            ),
          ),

          SizedBox(
            height: 3.34.h,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 48.0,right: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                build_button_icon(),
                build_button_icon(),
                build_button_icon(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
