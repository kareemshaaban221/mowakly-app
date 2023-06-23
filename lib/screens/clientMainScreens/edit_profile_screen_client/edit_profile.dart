// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fp/component/form_components.dart';
import 'package:fp/component/main_screens_components.dart';
import 'package:fp/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../component/buildButton.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(DARK_GREEN),
      body: Stack(
        children: [
          Container(
            height: 90.h,
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
                      height: 10.h,
                    ),
                    TFLabel(label: 'الاسم الأول'),
                    RegularTextField(initial_value: 'Mohammed'),
                    TFLabel(label: 'الاسم الثاني'),
                    RegularTextField(initial_value: 'Ashraf'),
                    TFLabel(label: 'النوع'),
                    DropdownTextField(dropdownList: ['ذكر', 'أنثى'], hint: 'ذكر'),
                    TFLabel(label: 'تاريخ الميلاد'),
                    DateTextField(context: context, selectedDate: DateTime(2001,8,2)),
                    TFLabel(label: 'رقم الهاتف'),
                    TextView(text: '01092279230'),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TFLabel(label: 'كلمة المرور'),
                        BuildButton(
                            title: 'تغيير كلمة المرور',
                            height: 26,
                            width: 160,
                            labelSize: 10,
                            onPress: () {})
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: BuildButton(
                      title: 'حفظ البيانات',
                      labelSize: 16,
                      height: 40,
                      width: 160,
                      onPress: () {},
                    )),
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
