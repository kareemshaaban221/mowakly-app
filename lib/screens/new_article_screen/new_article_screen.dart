import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fp/component/appbars/secondary_appbar.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/component/form_components.dart';
import 'package:fp/component/main_screens_components.dart';
import 'package:fp/component/side_drawer.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:fp/constants/constants.dart';
import 'package:fp/models/article_model.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/screens/LawyerMainScreens/LawyerMainScreen.dart';
import 'package:google_fonts/google_fonts.dart';


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

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(LIGHT_GREY),
      appBar: SecondaryAppBar(label: 'إنشاء مقالة جديدة'),
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TFLabel(label: 'عنوان المقالة'),
                TransparentTextField2(
                  controller: _titleController,
                ),
                TFLabel(label: 'مضمون المقالة'),
                TransparentTextField2(
                  maxLines: 16, controller: _contentController,),
                TFLabel(label: 'صورة المقالة'),
                Row(
                  children: [
                    BuildButton(
                      title: 'رفع صورة للمقال',
                      labelSize: 12,
                      width: 120,
                      height: 28,
                      onPress: () {},
                    ),
                  ],
                ),
                SizedBox(height: 32,),
                BuildButton(
                  title: 'نشر المقالة',
                  labelSize: 16,
                  width: 180,
                  height: 36,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      ArticleModel newArticleModel = ArticleModel(
                          label: _titleController.text,
                          paragraph: _contentController.text,
                          imageUrl: 'https://blog.ipleaders.in/wp-content/uploads/2021/02/lawyer-keywords.jpg',
                          author: loginmodel?.data?.fname ?? 'said mosad',
                          date: DateTime.now());
                      articlesList.insert(0, newArticleModel);
                      print(articlesList[0].label);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: TextWidget(label: 'نشر المقال', fontSize: 12,),
                            content: TextWidget(label: 'تم نشر المقال بنجاح', fontSize: 16,),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LawyerMainScreen(),));
                                },
                                child: Text('حسناً', style: GoogleFonts.cairo(),),
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          );
                        },
                      );



                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
