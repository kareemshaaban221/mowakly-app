import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/cubit%20App/blocObserver.dart';
import 'package:fp/screens/cv_lawer2Screen/cv_lawer2Screen.dart';
import 'package:fp/screens/cv_lawerScreen/cv_lawerScreen.dart';

import 'package:fp/screens/loginScreen/loginScreen.dart';
import 'package:fp/screens/loginScreen/cubit/cubitLoginScreen.dart';
import 'package:fp/screens/payScreen/payScreen.dart';
import 'package:fp/screens/payScreen/cubit/cubitPayScreen.dart';
import 'package:fp/screens/signup2Screen/signup2Screen.dart';
import 'package:fp/screens/splashScreen/splashScreen.dart';

import 'package:responsive_sizer/responsive_sizer.dart';


import 'network/remote/dio_helper.dart';
import 'screens/signupScreen/signupScreen.dart';

void main (){
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp( const MowakleApp());
}
class MowakleApp extends StatelessWidget {
  const MowakleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return ResponsiveSizer(
      builder: (context, orientation, screenType){
        return  MultiBlocProvider(
          providers: [
            BlocProvider(create: ((context) => LoginScreenCubit()),),
            BlocProvider(create: ((context) => PayScreenCubit()),)
          ],
          child: MaterialApp(
            /*initialRoute:LoginScreen.id,
            routes:{
              LoginScreen.id:(context)=> LoginScreen(),
              SignupScreen.id:(context)=>SignupScreen(),
              Signup2Screen.id:(context)=>Signup2Screen(),
              PayScreen.id:(context)=> PayScreen(),


            },*/
            home: SplashScreen(),

            theme: ThemeData(
              primaryColor: Color(0xff0B3939),

            ),
          ),
        );
      },
    );
  }
}
