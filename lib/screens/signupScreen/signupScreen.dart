import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fp/component/components.dart';
import 'package:fp/screens/signup2Screen/signup2Screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupScreen extends StatelessWidget {
    SignupScreen({Key? key,this.userType}) : super(key: key);

   var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var passwordConfirmController=TextEditingController();
    var emailController=TextEditingController();
    var scaffoldKey=GlobalKey<ScaffoldState>();
    var formKey=GlobalKey<FormState>();
    static String id = 'signup';
    String ?userType;
    Map user={};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 21.81.h,
                width: 59.07.w,
                child: SvgPicture.asset('${assetImage}obj.svg',),
              ),
              //
              build_text_filed(label: 'الاسم بالكامل',
                textInputType: TextInputType.text,
                icon: '${assetIcons}Icon material-person.svg',
                controller: nameController,
                validata: (value) {
                  if (value!.isEmpty) {
                    return 'Title must not empty';
                  }
                  else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 4.1.h,),

              build_text_filed(label: 'البريد الإلكتروني',
                textInputType: TextInputType.emailAddress,
                icon: '${assetIcons}Icon ionic-ios-mail.svg',
                controller: emailController,
                validata: (value) {
                  if (value!.isEmpty) {
                    return 'Title must not empty';
                  }
                  else {
                    return null;
                  }
                },),
              SizedBox(height: 4.1.h,),
              build_text_filed(label: 'كلمة المرور',
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
                icon: '${assetIcons}Icon awesome-lock.svg',
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
              SizedBox(height: 4.1.h,),
              build_text_filed(label: 'تأكيد كلمة المرور ',
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
                icon: '${assetIcons}Icon awesome-lock.svg',
                controller: passwordConfirmController,
                validata: (value) {
                  if (value!.isEmpty) {
                    return 'Title must not empty';
                  }
                  else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 3.85.h,),
              build_button(title: 'التالــــــي',
                  ontap: (){
                    if( formKey.currentState!.validate()){
                      user={
                        'name':nameController.text,
                        'email':emailController.text,
                        'password':passwordController.text,
                        'passwordConfirm':passwordConfirmController.text,
                      };
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Signup2Screen(userType: userType,user: user),));
                    }
                    else{

                    }
                  }
              ),

              SizedBox(
                height: 4.12.h,
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
                height: 3.34.h,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 48.0,right: 48.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    build_button_icon(icon: '${assetIcons}twitter.svg'),
                    build_button_icon(icon: '${assetIcons}facebook.svg'),
                    build_button_icon(icon: '${assetIcons}facebook.svg'),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
