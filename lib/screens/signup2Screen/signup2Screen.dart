import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fp/component/components.dart';
import 'package:fp/screens/clientMainScreens/ClientMainScreen.dart';
import 'package:fp/screens/cv_lawerScreen/cv_lawerScreen.dart';
import 'package:fp/screens/payScreen/payScreen.dart';
import 'package:fp/screens/signupScreen/cuibt/cubitSignupScreen.dart';
import 'package:fp/screens/signupScreen/cuibt/statesCuibt.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Signup2Screen extends StatelessWidget {
   Signup2Screen({Key? key,this.userType,this.user}) : super(key: key);

   static String id = 'signup2';
   var scaffoldKey=GlobalKey<ScaffoldState>();
   var formKey=GlobalKey<FormState>();
   var phoneController=TextEditingController();
   var dateController=TextEditingController();
   String ?userType;
   Map? user;
   String ?gender='male';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupScreenCubit(),

      child: BlocConsumer<SignupScreenCubit,SignupStates>(
        listener: (context, state) {},
        builder:(context, state) {
          SignupScreenCubit cuibt= SignupScreenCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xff0B3939),
            body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    // ده ال container ال في داتا
                    Align(
                      alignment: Alignment.center,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 13.81.h,
                              width: double.infinity,
                            ),

                            Container(
                              height:86.18.h,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.only(topLeft:Radius.circular(50.0),topRight: Radius.circular(50.0))
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 11.3.h,),
                                    Text(
                                      'Mohamed Ashraf',
                                      style: TextStyle(
                                        fontSize: 22.50.sp,
                                      ),
                                    ),
                                    SizedBox(height: 6.3.h,),
                                    build_text_filed(label: 'تاريخ الميلاد',
                                      icon: assetIcons+'Icon material-date-range.svg',
                                      readonly: true,
                                      controller: dateController,
                                      ontap: (){
                                        showDatePicker(context: context,

                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: const ColorScheme.light(
                                                  primary:Color(0xff0B3939) ,
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },

                                        ).then((value){
                                          //DateFormat.yMMMd().format(value!);
                                          dateController.text=DateFormat('yyyy-MM-dd').format(value!);
                                        }
                                        );
                                      },
                                      validata: (value) {
                                        if (value!.isEmpty) {
                                          return 'Title must not empty';
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                    ),
                                    //=====================
                                    SizedBox(height: 4.5.h,),
                                    //==========================
                                    build_text_filed(label: 'رقم الهاتف',
                                      textInputType: TextInputType.phone,
                                      icon: assetIcons+'Icon awesome-phone-alt.svg',
                                      controller: phoneController,
                                      validata: (value) {
                                        if (value!.isEmpty) {
                                          return 'Title must not empty';
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                    ),
                                    //======================
                                    SizedBox(height: 4.5.h,),
                                    //=======================

                                    /*build_text_filed(
                                     label: 'النــــوع',
                                     icon: assetIcons+'Ellipse 55.svg',
                                     controller: passwordController,
                                     readonly: true,
                                     ontap: (){

                                     },
                                     validata: (value) {
                                       if (value!.isEmpty) {
                                         return 'Title must not empty';
                                       }
                                       else {
                                         return null;
                                       }
                                     },
                                   ),*/
                                    build_choice_filed(icon: assetIcons+'Ellipse 55.svg',selectValue:gender,context: context ,
                                        onChange: (value) {
                                      SignupScreenCubit.get(context).change();
                                      gender=value!;
                                    }),



                                    //=============================
                                    SizedBox(height: 13.04.h,),
                                    //==========================
                                    build_button(title: 'التالــــــي',
                                        ontap: ()async{
                                          if(formKey.currentState!.validate()){

                                            if(userType=='client'){
                                              cuibt.userSignup(user_type: 'client', fname: user!['name'], email:user!['email'], password: user!['password'], password_confirmation: user!['passwordConfirm'], lname: 'nghg', gender: gender, date_of_birth: dateController.text, phone: phoneController.text);
                                            await  _dialogBuilder(context);
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ClientMainScreen(),));
                                            }
                                            else if(userType=='lawyer'){
                                              print(user);
                                              user!.addAll({
                                                'gender':gender,
                                                'phone':phoneController.text,
                                                'date_of_birth':dateController.text,
                                              });
                                            await  cuibt.showCategories();

                                              Navigator.push(context, MaterialPageRoute(builder: (context) => CvLawerScreen(user: user),));
                                            }
                                          }
                                      
                                          

                                        }
                                    ),
                                  ],
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),

                    // ده circle ال فيها الصوره
                    Positioned(
                      top: 6.h,
                      right: 33.w,
                      left: 33.w,
                      child:  const CircleAvatar(
                        radius: 67.0,
                        backgroundColor: Color(0xffFFFFFF),
                        child: CircleAvatar(
                          radius: 63.7,
                          backgroundColor: Color(0xff0B3939),
                          child: CircleAvatar(
                            backgroundColor: Color(0xffFFFFFF),
                            radius: 60.0,

                          ),
                        ),
                      ),
                    ),
                    //ده ال icon ال كاميرا
                    Positioned(
                      top: 18.h,
                      right: 45.w,
                      left: 45.w,
                      child: Container(
                        height: 4.12.h,
                        width: 8.8.w,
                        decoration: BoxDecoration(
                          color: const Color(0xff1BE5BF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset(assetIcons+'Icon feather-camera.svg',fit: BoxFit.none),

                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
   Future<void> _dialogBuilder(BuildContext context){
    return showDialog(context: context,
      builder:(context) => AlertDialog(content:Text('تم انشاء الحساب بنجاح') ,
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('تم'))
        ],
      ), );
   }
}
