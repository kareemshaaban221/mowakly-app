import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fp/network/models/models.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget ContainerMessage({text,chatwho}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Align(
      alignment:chatwho.toString()=='me'?AlignmentDirectional.centerEnd:AlignmentDirectional.centerStart,
      child: SizedBox(
        width: 64.8.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection:chatwho.toString()=='me'?TextDirection.rtl:TextDirection.ltr

          ,
          children: [
            CircleAvatar(
              radius: 0.7.cm,
            ),
            SizedBox( width: 2.w,),
            Container(
              constraints: BoxConstraints(
                maxWidth: 50.w,

              ),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius:BorderRadius.circular(15),

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Text(text.toString()),
              ),
            ),
          ],
        ),
      ),

    ),
  );
}