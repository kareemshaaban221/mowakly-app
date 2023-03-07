

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/component/components.dart';
import 'package:fp/screens/loginScreen/cubit/cubitLoginScreen.dart';
import 'package:fp/screens/loginScreen/cubit/statesCubit.dart';
import 'package:fp/screens/signupScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';



class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

   var emailController=TextEditingController();
   var passwordController=TextEditingController();
   var scaffoldKey=GlobalKey<ScaffoldState>();
   var formKey=GlobalKey<FormState>();
   static String id = 'login';

  @override



  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => LoginScreenCubit(),
          child: BlocConsumer<LoginScreenCubit,LoginStates>(
            listener: (context, state) {},
              builder: (context, state) {
              LoginScreenCubit cubit =LoginScreenCubit.get(context);
                return Scaffold(
                  key: scaffoldKey,
                  body: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          //
                          Container(
                            height: 21.07.h,
                            width: double.infinity,
                            color:const Color(0xff0B3939),
                            child: SizedBox(
                                height: 10.367.h,width: 14.48.w,
                                child: SvgPicture.asset('asset/لوجو موكلي.svg',fit: BoxFit.none,)),
                          ),

                          SizedBox(
                            height: 5.23.h,
                          ),

                          build_text_filed(label: 'الاسم,الايميل',icon: assetIcons+'Icon material-person.svg',
                            controller: emailController,
                            validata: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not empty';
                              }
                              else {
                                return null;
                              }
                            },
                          ),// دي widget انا عملتها لل textformfiled لل ui
                          SizedBox(
                            height: 4.02.h,
                          ),
                          build_text_filed(
                            label: 'كلمة السر',
                            icon: assetIcons+'lock.svg',
                            controller: passwordController,
                            validata: (value) {
                              if (value!.isEmpty) {
                                return 'Title must not empty';
                              }
                              else {
                                return null;
                              }
                            },

                          ),
                          SizedBox(
                            height: 4.01.h,
                          ),
                          
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            fallback: (context)=> CircularProgressIndicator() ,
                            builder:(context) => build_button(title: 'تسجيل دخول',
                                ontap: (){
                              if( formKey.currentState!.validate()){
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                );
                              }
                            },
                            ),
                          ),
                          
                          SizedBox(
                            height: 10.03.h,
                          ),

                          SizedBox(
                            height:2.56.h,
                            width: 78.03.w,
                            child: Row(
                              children: [
                                build_line(),
                                SizedBox(width: 6.30.w),
                                Text('أو سجل الدخول عن طريق',style: TextStyle(fontSize: 13.2.sp)),
                                SizedBox(width: 6.30.w),
                                build_line(),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 3.45.h,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 48.0,right: 48.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                build_button_icon(icon: assetIcons+'facebook.svg'),
                                build_button_icon(icon: assetIcons+'facebook.svg'),
                                build_button_icon(icon: assetIcons+'twitter.svg'),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 6.02.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: [
                              Text('لا يوجد لك حساب ؟',style: TextStyle(fontSize: 13.5.sp),),
                              InkWell(
                                  onTap:() => Navigator.pushNamed(context,SignupScreen.id),
                                  child: Text('سجل من هنا ',style: TextStyle(fontSize: 13.5.sp,color: Color(0xff1BE5BF)),))
                            ],
                          )




                        ],
                      ),
                    ),
                  ),

                );
              },
          ),
    );
  }
}
