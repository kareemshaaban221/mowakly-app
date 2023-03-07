import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fp/cubit%20App/blocObserver.dart';
import 'package:fp/network/remote/dio_helper.dart';
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
        return const MaterialApp(
          home: SplashScreen(),
        );
      },
    );
  }
}
