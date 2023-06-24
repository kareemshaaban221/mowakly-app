import 'package:flutter/material.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/component/complete_widgets/messages_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LawyersScreen extends StatefulWidget {
   LawyersScreen({Key? key}) : super(key: key);

  @override
  State<LawyersScreen> createState() => _LawyersScreenState();
}

class _LawyersScreenState extends State<LawyersScreen> {
  @override
  var selectValue='أسرة';
  var selectValue1='غيرمحدد';
  var selectValue2='400-500';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('التصنيف'),
                ),
                Container(
                  height: 5.h,
                  width: 30.w,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: DropdownButton(
                      underline: SizedBox(),

                      value: selectValue ,
                      onChanged: (value) {
                        setState(() {
                          selectValue=value!;
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('المحافظة'),
                ),
                Container(
                  height: 5.h,
                  width: 30.w,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: DropdownButton(
                      underline: SizedBox(),

                      value: selectValue1 ,
                      onChanged: (value) {
                        setState(() {
                          selectValue1=value!;
                        });

                      },
                      items: const[
                        DropdownMenuItem(child: Text("الدقهلية",),value: "الدقهلية"),
                        DropdownMenuItem(child: Text("غيرمحدد"),value: "غيرمحدد"),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                SizedBox(
                  width: 3.w,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('السعر'),
                ),
                Container(
                  height: 5.h,
                  width: 30.w,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: DropdownButton(
                      underline: SizedBox(),

                      value: selectValue2 ,
                      onChanged: (value) {
                        setState(() {
                          selectValue2=value!;
                        });

                      },
                      items: const[
                        DropdownMenuItem(child: Text("300-400",),value: "300-400"),
                        DropdownMenuItem(child: Text("400-500"),value: "400-500"),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
            child: Divider(
              thickness: 1,
            ),
          ),

          SizedBox(
            height: 70.h,
            width: 100.w,
            child: ListView.builder(itemBuilder: (context, index) => Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    //notification details
                    CircleAvatar(
                      backgroundColor: const Color(0xff0B3939),
                      radius: 34,
                      child: ClipOval(
                          child: Image.asset(
                            'asset/help.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(width: 5.w,),
                    Column(
                      children: [

                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text(
                              ' المحامي محمد السيد العيوطي',
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff0B3939),
                              ),
                            ),

                          ],
                        ),
                        //notification time
                        Row(

                          textDirection: TextDirection.rtl,
                          children: [
                            // SizedBox(
                            //   width: 4.6.w,
                            // ),

                            Text(
                              'dayWeek',
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffCDD6D6),
                              ),
                            ),


                          ],
                        )
                      ],
                    ),

                    // avatar
                    SizedBox(width: 5.w,),
                    Column(
                      children: [
                        Text(
                          '400 جنيه',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.cairo(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff0B3939),
                          ),
                        ),
                        BuildButton(title: 'استشير', onPress: (){},height: 3.h,
                        width: 18.w, labelSize: 12,)
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
                  child: Divider(
                    thickness: 1,
                  ),
                )
              ],
            ),),
          ),
        ],
      ),
    );
  }
}
