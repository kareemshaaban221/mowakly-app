import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/component/components.dart';
import 'package:fp/screens/forgetPasswordScreen/codeForgotPasswordScreen.dart';
import 'package:fp/screens/forgetPasswordScreen/cubit/cubitForgotPasswordScreen.dart';
import 'package:fp/screens/forgetPasswordScreen/cubit/statesCubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({Key? key}) : super(key: key);

   var emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordScreenCubit(),
      child: BlocConsumer<ForgotPasswordScreenCubit,ForgotPasswordStates>(
          listener: (context, state) {

          },
        builder: (context, state) {
            ForgotPasswordScreenCubit cuibt=ForgotPasswordScreenCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(

                children: [
                  SizedBox(height: 5.h,),
                  Container(
                    height: 30.h,
                    width: double.infinity,
                    child: Image.asset('asset/undraw_message_sent_re_q2kl.png'),

                  ),
                  SizedBox(
                    height:14.h ,
                    width: 78.2.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text('البريد الالكتروني'),
                        SizedBox(height: 2.h,),
                        Text('''من فضلك اكتب عنوان البريد الالكتروني او رقم الهاتف للبحث عن الحساب الخاص بك''',textDirection: TextDirection.rtl,style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    height: 7.5.h,
                    width: 80.2.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(39),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration:const InputDecoration(
                              enabledBorder: InputBorder.none,
                              hintText: 'ادخل البريد الالكتروني من هنا',
                              hintTextDirection: TextDirection.rtl
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 6.h,
                  ),
                  build_button(title: 'البحث', ontap: (){
                    cuibt.codeSent(userType: 'client', email: emailController.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CodeForgotPasswordScreen(email: emailController.text),));

                  })


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
