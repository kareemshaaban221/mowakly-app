import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:fp/cubit%20App/blocObserver.dart';
import 'package:fp/network/remote/dio_helper.dart';
import 'package:fp/screens/LawyerMainScreens/LawyerMainScreen.dart';
import 'package:fp/screens/book_consultation/book_consultation.dart';
import 'package:fp/screens/clientMainScreens/ClientMainScreen.dart';
import 'package:fp/screens/loginScreen/cubit/cubitLoginScreen.dart';
import 'package:fp/screens/payScreen/cubit/cubitPayScreen.dart';
import 'package:fp/screens/signupScreen/cuibt/cubitSignupScreen.dart';
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
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: ((context) => LoginScreenCubit()),),
            BlocProvider(create: ((context) => PayScreenCubit()),),
            BlocProvider(create: (context) => SignupScreenCubit(),),
            //BlocProvider(create: (context) => ForgotPasswordScreenCubit(),),
          ],
          child: MaterialApp(
            theme: ThemeData(
              primarySwatch: MINT_PRIMARY_COLOR, // Use the custom MaterialColor
            ),
            home:  const ClientMainScreen(),
          ),
        );
      },
    );
  }}
