import 'package:flutter/material.dart';
import 'package:fp/component/clientCard.dart';
import 'package:fp/screens/loginScreen/loginScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end:  Alignment.bottomCenter,
          colors: [Color(0xff1BE5BF), Color(0xff1d8181)]
        )
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Image.asset('asset/head.png'),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Text('برجاء الإختيار', textAlign: TextAlign.center,style: GoogleFonts.cairo(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.w,
                  color: Color(0xff0B3939)
                ),),
              ),

              ClientCard(label: 'محامي', asset: 'asset/lawyer.png', onPress: () { Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(userType: 'lawer'),)); } ,),

              SizedBox(height: 6.h,),

              ClientCard(label: 'عميل', asset: 'asset/client.png', onPress: () { Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(userType: 'client'),)); },),

            ],
          ),
        ),
      ),
    );
  }

}
