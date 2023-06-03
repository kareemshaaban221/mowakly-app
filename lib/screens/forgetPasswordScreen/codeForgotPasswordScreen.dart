import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/component/components.dart';
import 'package:fp/screens/forgetPasswordScreen/cubit/cubitForgotPasswordScreen.dart';
import 'package:fp/screens/forgetPasswordScreen/cubit/statesCubit.dart';
import 'package:fp/screens/forgetPasswordScreen/newPasswordScreen.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CodeForgotPasswordScreen extends StatelessWidget {
   CodeForgotPasswordScreen({Key? key,this.email}) : super(key: key);

  @override
  OtpFieldController controller=OtpFieldController();
  var email;
  var code;
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordScreenCubit(),
      child: BlocConsumer<ForgotPasswordScreenCubit,ForgotPasswordStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          ForgotPasswordScreenCubit cubit=ForgotPasswordScreenCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                Container(
                  height: 30.h,
                  width: double.infinity,

                ),

                OTPTextField(
                  length: 6,
                  width: 70.w,
                  fieldWidth: 10.w,
                  style: TextStyle(
                      fontSize: 17
                  ),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  controller: controller,
                  keyboardType: TextInputType.text,
                  onCompleted: (value) {
                    code=value;

                  },


                ),
                SizedBox(
                  height: 15.h,
                ),

                build_button(title: 'التالي', ontap: (){
                  cubit.checkCodeSent(userType: 'client', email:email , code: code);

                  Navigator.push(context,MaterialPageRoute(builder: (context) => NewPasswordScreen(email: email,),));

                })
              ],
            ),
          );
        },
      )
    );
  }
}
