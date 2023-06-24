import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/component/components.dart';
import 'package:fp/screens/LawyerMainScreens/LawyerMainScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CvLawer2Screen extends StatefulWidget {
   CvLawer2Screen({Key? key}) : super(key: key);

  @override
  State<CvLawer2Screen> createState() => _CvLawer2ScreenState();
}

class _CvLawer2ScreenState extends State<CvLawer2Screen> {
   String selectValue='أسرة';
   String selectValue1='محادثة نصية';
   List selectvalue=['أسرة','أسرة'];
   List selectvalue1=['محادثة نصية','محادثة نصية'];

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
                            SizedBox(
                              height: 55.h,
                              width: 90.w,
                              child: ListView.separated(
                                itemCount: 2,
                                separatorBuilder: (context, index) => Container(
                                  height: 0.2.h,
                                  width: 90.w,
                                  color: const Color(0xff1BE5BF),
                                ),
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 25.64.h,
                                    width:80.14.w ,
                                    child: Column(
                                      textDirection: TextDirection.rtl,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.h,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25),
                                          child: Row(
                                            textDirection: TextDirection.rtl,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(assetIcons+'Ellipse 56.svg'),
                                              Text('أضف سعر للخدمة ',
                                                style: TextStyle(
                                                    fontSize: 18.sp
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                          child: Row(
                                            textDirection: TextDirection.rtl,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const[
                                              Text('أضف تصنيف الاستشارة'),
                                              Text('أضف سعر الاستشارة'),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              //اضف تصنيف الاستشاره
                                              Container(
                                                height:4.57.h,
                                                width: 37.85.w,
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
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                                  child: Directionality(
                                                    textDirection: TextDirection.rtl,
                                                    child: DropdownButton(
                                                      underline: SizedBox(),
                                                      value: selectvalue[index] ,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectvalue[index]=value!;
                                                        });

                                                      },
                                                      items: const[
                                                        DropdownMenuItem(child: Text("أسرة",),value: "أسرة"),
                                                        DropdownMenuItem(child: Text("مدني"),value: "مدني"),
                                                        DropdownMenuItem(child: Text("جنائي"),value: "جنائي"),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              //اضف سعر الاستشارة
                                              Container(
                                                height:4.57.h,
                                                width: 37.85.w,
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
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    textDirection: TextDirection.rtl,
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children:  [
                                                     const Text ('EG'),
                                                      SizedBox(
                                                        height:4.h ,
                                                        width: 15.w,
                                                        child: TextFormField(
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                          child: Text('أضف طريقة التواصل'),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Container(
                                            height:4.57.h,
                                            width: 37.85.w,
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
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                              child: Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: DropdownButton(
                                                  underline: SizedBox(),

                                                  value: selectvalue1[index] ,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectvalue1[index]=value!;
                                                    });

                                                  },
                                                  items: const[
                                                    DropdownMenuItem(child: Text("محادثة نصية",),value: "محادثة نصية"),
                                                    DropdownMenuItem(child: Text("مكالمة صوتية",),value: "مكالمة صوتية"),
                                                    DropdownMenuItem(child: Text("مقابلة في المكتب"),value: "مقابلة في المكتب"),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  );
                                },

                                  ),
                            ),
                            SizedBox(height: 3.h,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BuildButton(title: 'التالي',
                                  labelSize: 25,
                                  onPress:(){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LawyerMainScreen(),));
                                  } ),
                            )
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
