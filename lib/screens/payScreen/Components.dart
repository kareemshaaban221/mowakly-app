
import 'package:flutter/cupertino.dart';
import 'package:fp/component/components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

Widget build_text_filed_payWithCheckBox({
  @required text,
  @required hintText,
  @required controller,
  valu=false,
  @required on
  }){
  return SizedBox(
    height:10.256.h,
    width: 70.09.w,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        Text(text,
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff0B3939)
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            Container(
                height: 6.02.h,
                width: 30.w,
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
            Checkbox(
              value: valu,
              onChanged: on
            ),
            Text('لا يوجد رمز حماية')
          ],
        ),
      ],
    ),
  );
}



Widget widgetBuiltScreenVisa({
  controllerNumberCard,
  validationNumberCard,
  controllerDataCard,
  validationDataCard,
  valu=false,
  on


}){
  return Column(
    children: [
      build_text_filed_pay(
          text: 'رقم بطاقة الإئتمان',
          hintText: 'ادخل الرقم هنا',
          controller: controllerNumberCard,

      ),
      SizedBox(height: 3.01.h,),
      build_text_filed_pay(
        text: 'تاريخ إنتهاء الصلاحية',
        hintText: 'mm/yy',
        controller: controllerDataCard,

      ),
      SizedBox(height: 3.01.h,),

      build_text_filed_payWithCheckBox(
          text: 'رمز الحماية',
          hintText: 'hintText',
          controller: controllerNumberCard,
        valu: valu,
        on: on



      )



    ],
  );
}



List listIconsPayScreen=[
  'Group 315.svg',
  'MasterCard-Logo-1979.svg',
  'MasterCard-Logo-1979.svg',

];

