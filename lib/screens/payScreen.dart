import 'package:flutter/material.dart';
import 'package:fp/component/components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B3939),
      body: SizedBox(
      height: double.infinity,
      width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 13.81.h,
                      width: double.infinity,
                      child: Center(
                        child: SizedBox(
                          height: 5.23.h,
                          width: 81.30.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Text('طرق الدفع',
                                style: TextStyle(
                                  fontSize: 19.sp,
                                  color: Color(0xffFFFFFF),
                                  fontFamily: 'Cairo',
                                ),
                              ),

                              Container(
                                height: 4.12.h,
                                width:21.72.w ,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(31.pt),
                                ),
                                child: const Center(
                                    child: Text(
                                      'تخطي',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                      ),)
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
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
                            SizedBox(height: 4.90.h,),

                            SizedBox(
                              height: 11.4.h,
                              width: 90.53.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                 build_container_icon_pay(),
                                 build_container_icon_pay(),
                                 build_container_icon_pay(),
                                  Container(
                                    height: 10.0.h,
                                    width:8.17.w ,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4.0,
                                        ),
                                      ],
                                    ),


                                  ),
                                ],
                              ),
                            ),
                            // Row icons methods pay
                            SizedBox(height: 5.23.h,),
                            build_text_filed_pay(),
                            SizedBox(height: 3.01.h,),
                            build_text_filed_pay(),
                            SizedBox(height: 3.01.h,),
                            build_text_filed_pay(),
                            SizedBox(height: 6.02.h,),
                            build_button(title: 'التالــــــي')
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
