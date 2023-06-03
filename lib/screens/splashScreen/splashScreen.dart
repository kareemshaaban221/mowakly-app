import 'package:flutter/material.dart';
import 'package:fp/component/components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../intro1Screen/intro1Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    navigate();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B3939),
      body: Center(
        child: SizedBox(
          width: 50.w, height: 50.w, child: Image.asset(assetImage+'logo.png'),),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 2), () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Intro1Screen()));
    }
    );
  }
}



