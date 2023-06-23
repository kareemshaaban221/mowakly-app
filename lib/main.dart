import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/cubit%20App/blocObserver.dart';
import 'package:fp/network/remote/dio_helper.dart';
import 'package:fp/screens/appointmentsScreen/appointmentsScreen.dart';
import 'package:fp/screens/homeScreens/HomeScreen.dart';
import 'package:fp/screens/loginScreen/cubit/cubitLoginScreen.dart';
import 'package:fp/screens/payScreen/cubit/cubitPayScreen.dart';
import 'package:fp/screens/signupScreen/cuibt/cubitSignupScreen.dart';
import 'package:fp/screens/splashScreen/splashScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';




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
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: ((context) => LoginScreenCubit()),),
            BlocProvider(create: ((context) => PayScreenCubit()),),
            BlocProvider(create: (context) => SignupScreenCubit(),),
            //BlocProvider(create: (context) => ForgotPasswordScreenCubit(),),
          ],
          child: const MaterialApp(
            //hellow
            home: AppointmentsScreen(),
          ),
        );
      },
    );
  }
}
