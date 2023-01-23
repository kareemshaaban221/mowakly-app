import 'package:flutter/material.dart';
import 'package:fp/screens/loginScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'screens/signup2Screen.dart';
import 'screens/signupScreen.dart';

void main (){
  runApp( MowakleApp());
}
class MowakleApp extends StatelessWidget {
  const MowakleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return ResponsiveSizer(
      builder: (context, orientation, screenType){
        return const MaterialApp(
          home: Signup2Screen(),
        );
      },
    );
  }
}
