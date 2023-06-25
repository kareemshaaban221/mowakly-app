import 'package:flutter/material.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/screens/loginIntroScreen/loginIntroScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_svg/svg.dart';



class Intro1Screen extends StatelessWidget {
  const Intro1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [

          SizedBox(
            child: Image.asset('asset/welcome.png'),),
          const SizedBox(height:32 ,),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 8 ),
            child: BuildButton(title: 'مرحبا بك' , color: 0xff0B3939,labelSize: 25, onPress: () {  },),
          ),


           Text('في تطبيق موكلي', textAlign: TextAlign.center, style: GoogleFonts.cairo(
            color: Color(0xff0B3939),
            fontSize: 36
          ),),
          const SizedBox(height: 72,),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: BuildButton(title: 'التالي',labelSize: 25,color: 0xff1BE5BF, onPress: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return LoginIntroScreen();
              }));
            },),
          ),

        ],
      ),
    );
  }
}
