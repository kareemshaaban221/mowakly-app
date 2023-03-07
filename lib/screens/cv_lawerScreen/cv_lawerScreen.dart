import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fp/component/components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class CvLawerScreen extends StatelessWidget {
  const CvLawerScreen({Key? key}) : super(key: key);

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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           // SizedBox(height: 11.3.h,),
                            /*Text(
                              'Mohamed Ashraf',
                              style: TextStyle(
                                fontSize: 22.50.sp,
                              ),
                            ),*/
                            SizedBox(height: 3.3.h,),
                            //=============================
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(assetIcons+'Ellipse 56.svg'),
                                  Text('مجال التخصص ',
                                  style: TextStyle(
                                    fontSize: 18.sp
                                  ),
                                  )
                                ],
                              ),
                            ),
                            //مجال التخصص
                            SizedBox(
                              height: 16.82.h,
                              width: 74.53.w,
                              child:GridView.builder(
                                 itemCount: 8,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                                  childAspectRatio: 3,crossAxisSpacing: 6,mainAxisSpacing: 5,),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 4.0,
                                            ),
                                          ],
                                        ),
                                        child: Center(child: Text('text')),
                                      ),
                                    );
                                  },)
                            ),
                            Container(
                              height: 0.2.h,
                              width: 90.w,
                              color: const Color(0xff1BE5BF),
                            ),
                            //نبذ عن نفسك
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(assetIcons+'Ellipse 56.svg'),
                                  Text('نبذه عن نفسك ',
                                    style: TextStyle(
                                        fontSize: 18.sp
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 16.482.h,
                              width: 76.53.w,
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4.0,
                                ),
                              ],),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'ادخل هنا الوصف الذي تريد اظهاره للعملاء ',
                                  hintTextDirection: TextDirection.rtl
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 1.h,
                            ),

                            Container(
                              height: 0.2.h,
                              width: 90.w,
                              color: const Color(0xff1BE5BF),
                            ),
                            // المرفقات
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(assetIcons+'Ellipse 56.svg'),
                                  Text('المرفقات ',
                                    style: TextStyle(
                                        fontSize: 18.sp
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                             const Text('''ادخل الملف الذي يحتوي علي السيرة الذاتية الخاصة بك 
                            PDF ملحوظة : يكون الملف بصيغة ''',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            ),

                            SizedBox(
                              height: 1.h,
                            ),

                            Container(
                              height: 3.744.h,
                              width: 37.149.w,
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4.0,
                                  ),
                                ],),

                              child: Center(child: Text('ادخل الملف من هنا ')),

                            ),

                            SizedBox(height: 10.04.h,),
                            //========================== Padding(
                            //                                       padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                            //                                       child: Container(
                            //                                         height:3.344.h,
                            //                                         width: 23.36.w,
                            //                                         decoration: BoxDecoration(
                            //                                           color: Color(0xff1BE5BF),
                            //                                           borderRadius: BorderRadius.circular(15)
                            //                                         ),
                            //                                       ),
                            //                                     );
                            build_button(title: 'التالــــــي',
                                ontap: (){}
                            ),
                          ],
                        ),
                      ),

                    ),


                  ],
                ),
              ),

              // ده circle ال فيها الصوره
              /*Positioned(
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
                  child: SvgPicture.asset(assetIcons+'Icon feather-camera.svg',fit: BoxFit.none),

                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
