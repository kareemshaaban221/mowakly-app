import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget build_text_filed({@required label}){

  return SizedBox(
    height: 7.36.h,
    width: 70.11.w,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 6.02.h,
            width:70.09.w ,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(31.pt),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 8.0,
                ),
              ],
            ),

            child: Row(
              children: [
                SizedBox(
                  height: 6.02.h,
                  width: 52.75.w,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8,left: 8,top: 8),
                    child: TextFormField(
                      textAlign: TextAlign.end,
                      decoration:  InputDecoration(
                        hintText: label,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [ BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4.0,
                  offset: Offset(-3, 3)
              ),
              ],
            ),
            child: CircleAvatar(
              radius: 5.pt,
              backgroundColor: const Color(0xffFFFFFF),

            ),
          ),
        ),
      ],
    ),
  );
}

Widget build_button({@required title}){

  return Container(
    height: 6.02.h,
    width:38.08.w ,
    decoration: BoxDecoration(
      color: const Color(0xff1BE5BF),
      borderRadius: BorderRadius.circular(31.pt),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 4.0,
        ),
      ],
    ),
    child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xffFFFFFF),
          ),)
    ),

  );
}

Widget build_line(){
  return Container(
    height: 0.44.h,
    width: 18.45.w,
    color: const Color(0xff1BE5BF),
  );
}

Widget build_button_icon(){
  return Container(
    height: 6.02.h,
    width: 20.79.w,
    decoration: BoxDecoration(
      color: const Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(31.pt),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 4.0,
        ),
      ],
    ),
  );
}

Widget build_container_icon_pay(){
  return SizedBox(
    height: 11.4.h,
    width: 19.9.w,
    child: Column(
      children: [
        Container(
          height: 9.0.h,
          width:19.85.w ,
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(21),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
              ),
            ],
          ),


        ),
        SizedBox(height: 1.6.h,),
        Container(
          height: 0.66.h,
          width: 12.38.w,
          decoration: BoxDecoration(
            color: Color(0xff1BE5BF),
            borderRadius: BorderRadius.circular(3)
          ),
          
        ),
      ],
    ),
  );
}

Widget build_text_filed_pay(){
  return SizedBox(
    height:10.256.h,
    width: 70.09.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        Text('رقم بطاقة الإئتمان',
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff0B3939)
          ),
        ),

        Container(
            height: 6.02.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff0B3939).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textAlign: TextAlign.end,
                decoration:  InputDecoration(
                  hintText: 'ادخل الرقم هنا',
                  enabledBorder: InputBorder.none,
                ),
              ),
            )
        ),
      ],
    ),
  );
}