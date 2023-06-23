// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fp/component/main_screens_components.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../component/buildButton.dart';
import '../edit_profile_screen_client/edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(DARK_GREEN),
      body: Stack(
        children: [
          Container(
            height: 80.h,
            width: double.infinity,
            margin: EdgeInsets.only(top: 16.h),
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(36),
                topLeft: Radius.circular(36),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    
                    const Center(child: TextWidget(label: 'Mohammed Ashraf')),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        TextWidget(label: 'عميل', fontSize: 16, fontWeight: FontWeight.w600,),
                        Icon(Icons.person, size: 20,)
                      ],
                    ),

                    Center(
                        child: BuildButton(
                          title: 'تعديل الملف الشخصي',
                          labelSize: 12,
                          height: 40,
                          width: 160,
                          rightIcon: Icons.tune_rounded,
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage(),));
                          },
                        )),
                    TFLabel(label: 'الاسم الأول'),
                    TextView(text: 'Mohammed'),
                    TFLabel(label: 'الاسم الثاني'),
                    TextView(text: 'Ashraf'),
                    TFLabel(label: 'النوع'),
                    TextView(text: 'ذكر'),
                    TFLabel(label: 'تاريخ الميلاد'),
                    TextView(text: '02-08-2001'),
                    TFLabel(label: 'رقم الهاتف'),
                    TextView(text: '01092279230'),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Align(
              alignment: Alignment.topCenter,
              child: ProfilePicture(),
            ),
          ),
        ],
      ),
    );
  }
}
