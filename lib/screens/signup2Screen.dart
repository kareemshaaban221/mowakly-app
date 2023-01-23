import 'package:flutter/material.dart';
import 'package:fp/component/components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Signup2Screen extends StatelessWidget {
  const Signup2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B3939),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            // ده ال container ال في داتا
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 13.81.h,
                    width: double.infinity,
                  ),

                  Container(
                    height:86.18.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(50.0),topRight: Radius.circular(50.0))
                    ),
                     child: SingleChildScrollView(
                       child: Column(
                         children: [
                           SizedBox(height: 11.3.h,),
                           Text(
                             'Mohamed Ashraf',
                           style: TextStyle(
                             fontSize: 22.50.sp,
                           ),
                           ),
                           SizedBox(height: 6.3.h,),
                           build_text_filed(label: 'تاريخ الميلاد'),
                           SizedBox(height: 4.5.h,),
                           build_text_filed(label: 'رقم الهاتف'),
                           SizedBox(height: 4.5.h,),
                           build_text_filed(label: 'النــــوع'),
                           SizedBox(height: 13.04.h,),
                           build_button(title: 'التالــــــي'),


                         ],
                    ),
                     ),

                  ),
                ],
              ),
            ),
            // ده circle ال فيها الصوره
            Positioned(
              top: 6.h,
              right: 33.w,
              left: 33.w,
              child:  const CircleAvatar(
                radius: 67.0,
                backgroundColor: Color(0xffFFFFFF),
                child: CircleAvatar(
                  radius: 63.7,
                  backgroundColor: Color(0xff0B3939),
                  child: CircleAvatar(
                    backgroundColor: Color(0xffFFFFFF),
                    radius: 60.0,
                  ),
                ),
              ),
            ),
            //ده ال icon ال كاميرا
            Positioned(
              top: 18.h,
              right: 45.w,
              left: 45.w,
              child: Container(
                height: 4.12.h,
                width: 8.8.w,
                decoration: BoxDecoration(
                    color: const Color(0xff1BE5BF),
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
