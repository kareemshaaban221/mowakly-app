import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fp/screens/signupScreen/cuibt/cubitSignupScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

String assetImage = 'asset/';

String assetIcons = 'asset/icons/';

Widget build_choice_filed({@required icon,selectValue='male',context}){
  //String selectValue='ذكر';
  return SizedBox(
    height: 7.36.h,
    width: 70.11.w,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 7.02.h,
            width:80.09.w ,
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
              textDirection: TextDirection.rtl,
              children: [
                SizedBox(
                  width: 15.w,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton(
                    autofocus: false,

                    value: selectValue ,
                    onChanged: (value) {
                      SignupScreenCubit.get(context).change();
                      selectValue=value!;
                    },
                    items: const[
                      DropdownMenuItem(child: Text("ذكر",),value: 'male'),
                      DropdownMenuItem(child: Text("انثي"),value: 'female'),

                    ],
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

              child: SvgPicture.asset(icon,fit: BoxFit.none),

            ),
          ),
        ),
      ],
    ),
  );
}

Widget build_text_filed({
  @required label,
  @required icon,
  @required controller,
 @required String?Function(String?) ?validata,
  readonly=false,
  ontap=null,

}){

  return SizedBox(
    height: 7.36.h,
    width: 70.11.w,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 7.02.h,
            width:80.09.w ,
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
                  height: 7.02.h,
                  width: 52.75.w,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: controller,
                      validator : validata ,
                      textAlign: TextAlign.end,
                      readOnly: readonly,
                      onTap: ontap,
                      decoration:  InputDecoration(

                        hintText: label,
                        enabledBorder: InputBorder.none,
                        //suffixIcon: SvgPicture.asset(suffxicon,fit: BoxFit.none),

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

              child: SvgPicture.asset(icon,fit: BoxFit.none),

            ),
          ),
        ),
      ],
    ),
  );
}

Widget build_button({@required title,@required ontap}){

  return InkWell(
    onTap: ontap,
    child: Container(
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

Widget build_button_icon({@required icon}){
  return Container(
    height: 6.02.h,
    width: 20.79.w,
    decoration: BoxDecoration(
      color: const Color(0xffFFFFFF,),
      borderRadius: BorderRadius.circular(31.pt),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 4.0,
        ),
      ],
    ),
     child: SvgPicture.asset(icon,fit: BoxFit.none),
  );
}

Widget build_container_icon_pay({@required icon,@required ontap,color}){
  //color=Color(0xff0B3939).withOpacity(0.1);
  return SizedBox(
    height: 11.4.h,
    width: 19.9.w,
    child: Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
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

            child: SvgPicture.asset(assetIcons+icon,fit: BoxFit.none),

          ),
        ),
        SizedBox(height: 1.6.h,),
        Container(
          height: 0.66.h,
          width: 12.38.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3)
          ),
          
        ),
      ],
    ),
  );
}

Widget build_text_filed_pay({@required text,@required hintText,@required controller,
  }){
  return SizedBox(
    height:10.256.h,
    width: 70.09.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        Text(text,
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff0B3939)
          ),
        ),

        Container(
            height: 6.02.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff0B3939).withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                textAlign: TextAlign.end,

                decoration:  InputDecoration(
                  hintText: hintText,
                  enabledBorder: InputBorder.none,
                ),
              ),
            )
        ),
      ],
    ),
  );
}
