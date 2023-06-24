import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/component/components.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/screens/chooseScreen/chooseScreen.dart';
import 'package:fp/screens/forgetPasswordScreen/cubit/cubitForgotPasswordScreen.dart';
import 'package:fp/screens/forgetPasswordScreen/cubit/statesCubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewPasswordScreen extends StatelessWidget {
   NewPasswordScreen({Key? key,this.email,}) : super(key: key);

  var conPasswordController=TextEditingController();
  var passwordController=TextEditingController();
  var email;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordScreenCubit(),
      child: BlocConsumer<ForgotPasswordScreenCubit,ForgotPasswordStates>(
           listener:(context, state) {

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
                    child: Image.asset('asset/undraw_done_re_oak4.png'),

                  ),
                  SizedBox(height: 5.h,),

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
                          controller: passwordController,
                          decoration:const InputDecoration(
                              enabledBorder: InputBorder.none,
                              hintText: 'ادخل كلمة المرور الجديدة',
                              hintTextDirection: TextDirection.rtl
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 3.h,
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
                          controller:conPasswordController ,
                          decoration:const InputDecoration(
                              enabledBorder: InputBorder.none,
                              hintText: 'ادخل كلمة المرور الجديدة مرة أخرى ',
                              hintTextDirection: TextDirection.rtl
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),

                  build_button(title: 'التالي', ontap: (){
                    print(email);
                    print(passwordController.text);
                    print(conPasswordController.text);
                    cuibt.newPassword(userType: 'client',
                        token:tokenPassword,
                        email: email,
                        newPassword: passwordController.text,
                        conNewPassword: conPasswordController.text);
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ChooseScreen(),));
                  })
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
