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