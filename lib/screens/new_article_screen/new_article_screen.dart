import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fp/component/appbars/secondary_appbar.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/component/form_components.dart';
import 'package:fp/component/main_screens_components.dart';
import 'package:fp/component/side_drawer.dart';
import 'package:fp/constants/constants.dart';


class NewArticleScreen extends StatefulWidget {
  const NewArticleScreen({Key? key}) : super(key: key);

  @override
  _NewArticleScreenState createState() => _NewArticleScreenState();
}

class _NewArticleScreenState extends State<NewArticleScreen> {

  //File? _imageFile;
  // Future<void> _pickImage() async {
  //   print('test func ');
  //   final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(LIGHT_GREY),
      appBar: SecondaryAppBar(label: 'إنشاء مقالة جديدة'),
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          child: Column(
            children: [
              TFLabel(label: 'عنوان المقالة'),
              TransparentTextField(),
              TFLabel(label: 'مضمون المقالة'),
              TransparentTextField(maxLines: 16),
              TFLabel(label: 'صورة المقالة'),
              Row(
                children: [
                  BuildButton(
                    title: 'رفع صورة للمقال',
                    labelSize: 12,
                    width: 120,
                    height: 28,
                    onPress: (){},
                  ),
                ],
              ),
              SizedBox(height: 32,),

              // if (_imageFile != null)
              //   Container(
              //     height: 200,
              //     width: 200,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: FileImage(_imageFile!),
              //         fit: BoxFit.cover,
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),

              BuildButton(
                title: 'نشر المقالة',
                labelSize: 16,
                width: 180,
                height: 36,
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
