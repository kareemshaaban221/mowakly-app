// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

String assetImage = 'asset/';

String assetIcons = 'asset/icons/';

Widget build_choice_filed({@required icon,@required void onChange(Object)?,selectValue='male',context}){
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
                    onChanged: onChange,
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
  @required textInputType,
 @required String?Function(String?) ?validata,
  obscureText=false,
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
                      obscureText: obscureText,
                      validator : validata ,
                      textAlign: TextAlign.end,
                      readOnly: readonly,
                      onTap: ontap,
                      keyboardType: textInputType,
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
            style: const TextStyle(
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
          style: const TextStyle(
              fontSize: 16,
              color: Color(0xff0B3939)
          ),
        ),

        Container(
            height: 6.02.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xff0B3939).withOpacity(0.05),
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


Widget ConsultationPrice({required String price}){
  return Padding(
    padding: const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 24
    ),
    child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: const [
                TextWidget(label: 'علماً بأن سعر الاستشارة', fontSize: 16, fontWeight: FontWeight.w600,),
                TextWidget(
                  label: 'يجب الدفع من أجل تقديم طلب استشارة',
                  color: Color(0xffadadad),
                  fontSize: 9,
                )
              ],
            ),

            Row(
              children: [
                TextWidget(label: 'جنيه', color: Color(MINT_GREEN), fontSize: 10,fontWeight: FontWeight.w800,),
                const SizedBox(width: 4,),
                TextWidget(label: price, color: Color(MINT_GREEN), fontWeight: FontWeight.w600,fontSize: 28,),
              ],
            ),

          ],
        )),
  );
}

Widget SmallTextContainer({required String text}){
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          decoration: BoxDecoration(
            color: Color(MINT_GREEN),
            borderRadius: BorderRadius.circular(12.pt),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.cairo(
                color: const Color(0xffFFFFFF),
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget AddButton({required VoidCallback onPress}){
  Color clr =  const Color(0xff9d9d9d) ;
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.pt),
              border: Border.all(color: clr,
            ),
            ),
            child: Center(
              child: Icon(Icons.add, color: clr,size: 20, )
            ),
          ),
        ],
      ),
    ),
  );
}

Widget ServicePrice({required major, required channel, required price}) {
  double widgetWidth = 74.w;
  double widgetHeight = 32;
  return Container(
    width: widgetWidth,
    height: widgetHeight,
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xff9a9a9a),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: widgetWidth * 0.28 - 4,
          height: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Center(
            child: TextWidget(
              label: major,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: 1,
          height: double.infinity,
          color: const Color(0xff9a9a9a),
        ),
        Container(
          width: widgetWidth * 0.44 - 4,
          height: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: TextWidget(
              label: channel,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: 1,
          height: double.infinity,
          color: const Color(0xff9a9a9a),
        ),
        Container(
          width: widgetWidth * 0.28 - 4,
          height: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: TextWidget(
              label: price,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget SmallDeleteButton({required VoidCallback onPress}){
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 1.w),
    child: InkWell(
      onTap: onPress,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: const Color(0xffe5e5e5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_forever_outlined, size: 20,color: Color(
            0xff4f4f4f),),
      ),
    ),
  );
}

Widget SmallAddButton({required VoidCallback onPress}){
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 1.w),
    child: InkWell(
      onTap: onPress,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Color(MINT_GREEN),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.add, size: 20,color: Color(
            0xffffffff),),
      ),
    ),
  );
}



Widget AdvertisementCard() {
  return Container(
      width: 100.w,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: const BoxDecoration(
          color: Color(0xff0B3939),
          borderRadius: BorderRadius.all(Radius.circular(28))),
      child: Center(
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تخفيضات',
                  style: GoogleFonts.cairo(
                      fontSize: 24.sp,
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'على أول خدمة',
                  style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      height: 1.2,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),

                //button
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 4.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: const Color(0xff1BE5BF),
                        borderRadius: BorderRadius.circular(31.pt),
                      ),
                      child: Center(
                          child: Text(
                            'احصل عليها الآن',
                            style: GoogleFonts.cairo(
                              color: const Color(0xff0B3939),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                  ),
                )
              ],
            ),

            //50 % discount
            Stack(
              children: [
                Text(
                  '50 ',
                  style: GoogleFonts.cairo(
                      fontSize: 40.sp,
                      color: Colors.white,
                      height: 1.4,
                      fontWeight: FontWeight.w800),
                ),
                Positioned(
                  bottom: 24,
                  right: 0,
                  child: Stack(
                    children: [
                      // Implement the stroke
                      Text(
                        '%',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = const Color(0xff0B3939),
                        ),
                      ),
                      // The text inside
                      Text(
                        '%',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}

