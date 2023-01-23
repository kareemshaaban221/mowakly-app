import 'package:flutter/material.dart';
import 'package:fp/component/components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              height: 21.07.h,
              width: double.infinity,
              color: const Color(0xff0B3939),
            ),
          ),

          SizedBox(
            height: 5.23.h,
          ),
           build_text_filed(label: 'الاسم,الايميل'),// دي widget انا عملتها لل textformfiled لل ui
          SizedBox(
            height: 4.02.h,
          ),
          build_text_filed(label: 'كلمة السر'),
          SizedBox(
            height: 4.01.h,
          ),
          build_button(title: 'تسجيل دخول'),
          SizedBox(
            height: 10.03.h,
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
            height: 3.45.h,
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

          SizedBox(
            height: 6.02.h,
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              Text('لا يوجد لك حساب ؟',style: TextStyle(fontSize: 13.5.sp),),
              Text('سجل من هنا ',style: TextStyle(fontSize: 13.5.sp,color: Color(0xff1BE5BF)),)
            ],
          )




        ],
      ),

    );
  }
}
