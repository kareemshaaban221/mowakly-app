



import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fp/component/components.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/screens/cv_lawer2Screen/cv_lawer2Screen.dart';
import 'package:fp/screens/signupScreen/cuibt/cubitSignupScreen.dart';
import 'package:fp/screens/signupScreen/cuibt/statesCuibt.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class CvLawerScreen extends StatelessWidget {
   CvLawerScreen({Key? key,this.user}) : super(key: key);

   var scaffoldKey=GlobalKey<ScaffoldState>();
   var formKey=GlobalKey<FormState>();
   var descriptionController=TextEditingController();
   Map? user;
   var file1Path;
   var filePath;
   var file1Name;
   var fileName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) {
        //SignupScreenCubit.get(context).showCategories();
        return SignupScreenCubit();},
      child: BlocConsumer<SignupScreenCubit,SignupStates>(
        listener: (context, state) {
          if (state is SignupInitialState){
            print('object');
          }
        },
        builder: (context, state) {
          SignupScreenCubit cubit=SignupScreenCubit.get(context);

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
                                    // SizedBox(height: 11.3.h,),
                                    /*Text(
                                    'Mohamed Ashraf',
                                    style: TextStyle(
                                      fontSize: 22.50.sp,
                                    ),
                                  ),*/
                                    SizedBox(height: 3.3.h,),
                                    //=============================
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(assetIcons+'Ellipse 56.svg'),
                                          Text('مجال التخصص ',
                                            style: TextStyle(
                                                fontSize: 18.sp
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //مجال التخصص
                                    SizedBox(
                                        height: 16.82.h,
                                        width: 74.53.w,
                                        child:GridView.builder(
                                          itemCount: categories?.length,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                                            childAspectRatio: 3,crossAxisSpacing: 6,mainAxisSpacing: 5,),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xffFFFFFF),
                                                  borderRadius: BorderRadius.circular(15),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 4.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(child: Text(categories?[index])),
                                              ),
                                            );
                                          },)
                                    ),
                                    Container(
                                      height: 0.2.h,
                                      width: 90.w,
                                      color: const Color(0xff1BE5BF),
                                    ),
                                    //نبذ عن نفسك
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(assetIcons+'Ellipse 56.svg'),
                                          Text('نبذه عن نفسك ',
                                            style: TextStyle(
                                                fontSize: 18.sp
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                      height: 16.482.h,
                                      width: 76.53.w,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 4.0,
                                          ),
                                        ],),
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        controller: descriptionController,
                                        textDirection: TextDirection.rtl,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'ادخل هنا الوصف الذي تريد اظهاره للعملاء ',
                                            hintTextDirection: TextDirection.rtl
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 1.h,
                                    ),

                                    Container(
                                      height: 0.2.h,
                                      width: 90.w,
                                      color: const Color(0xff1BE5BF),
                                    ),
                                    // المرفقات
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(assetIcons+'Ellipse 56.svg'),
                                          Text('المرفقات ',
                                            style: TextStyle(
                                                fontSize: 18.sp
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    const Text('''ادخل الملف الذي يحتوي علي السيرة الذاتية الخاصة بك
                             PDF ملحوظة : يكون الملف بصيغة''',

                                      style: TextStyle(

                                        color: Colors.grey,
                                      ),
                                    ),

                                    SizedBox(
                                      height: 1.h,
                                    ),

                                    InkWell(
                                      onTap: ()async{

                                         final result = await FilePicker.platform.pickFiles();
                                         print(result!.paths.first);

                                         if (result != null){
                                          //List<File> files = result.paths.map((path) => File(path!)).toList();
                                          filePath= result.paths.first!;
                                          fileName= result.names.first;
                                        //  print(filePath.toString());
                                        } else {
                                          // User canceled the picker
                                        }
                                      },
                                      child: Container(
                                        height: 3.744.h,
                                        width: 37.149.w,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 4.0,
                                            ),
                                          ],),

                                        child: Center(child: Text('ادخل الملف من هنا ')),

                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    InkWell(
                                      onTap: ()async{
                                        final result = await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['pdf'],
                                        );

                                        if (result != null){
                                          //List<File> files = result.paths.map((path) => File(path!)).toList();
                                           file1Path= result.files.single.path!.toString();
                                           file1Name= result.files.single.name;
                                          print(file1Path);
                                        } else {
                                          // User canceled the picker
                                        }
                                      },
                                      child: Container(
                                        height: 3.744.h,
                                        width: 37.149.w,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 4.0,
                                            ),
                                          ],),

                                        child: Center(child: Text('ادخل الملف من هنا ')),

                                      ),
                                    ),

                                    SizedBox(height: 10.04.h,),
                                    //========================== Padding(
                                    //                                       padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                    //                                       child: Container(
                                    //                                         height:3.344.h,
                                    //                                         width: 23.36.w,
                                    //                                         decoration: BoxDecoration(
                                    //                                           color: Color(0xff1BE5BF),
                                    //                                           borderRadius: BorderRadius.circular(15)
                                    //                                         ),
                                    //                                       ),
                                    //                                     );
                                    build_button(title: 'التالــــــي',
                                        ontap: (){

                                      cubit.uploadImage(user_type: 'lawyer',
                                          fname: user!['name'],
                                          email: user!['email'],
                                          password: user!['password'],
                                          password_confirmation: user!['passwordConfirm'],
                                          lname: 'mosad',
                                          gender: user!['gender'],
                                          date_of_birth: user!['date_of_birth'],
                                          phones0: user!['phone'],
                                          description: descriptionController.text,
                                          card_id: '165486598',
                                          filePathCard: filePath,
                                          fileNameCard: fileName,
                                          filePathAvatar: filePath,
                                          filenameAvatar: fileName,
                                          filePathAttachment: file1Path,
                                          fileNameAttaachment: file1Name,
                                          phones1: '1584654654',
                                          national_id: '11111111111111');
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => CvLawer2Screen(),));
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
                    /*Positioned(
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
                  ),*/
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
