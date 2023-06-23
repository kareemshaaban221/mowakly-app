import 'package:flutter/material.dart';
import 'package:fp/component/complete_widgets/articles_list_widget.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/constants/constants.dart';
import 'package:fp/screens/new_article_screen/new_article_screen.dart';

class HomePageLawyer extends StatefulWidget {
  const HomePageLawyer({Key? key}) : super(key: key);

  @override
  State<HomePageLawyer> createState() => _HomePageLawyerState();
}

class _HomePageLawyerState extends State<HomePageLawyer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(LIGHT_GREY),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 108,
            ),
            Center(
              child: BuildButton(
                  title: 'إضافة مقال جديد',
                  labelSize: 16,
                  height: 36,
                  width: 200,
                  rightIcon: Icons.add_circle_outline,
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => NewArticleScreen(),));
                  }),
            ),

            const SizedBox(
              height: 10,
            ),

            ArticlesListWidget()

            //
          ],
        ),
      ),
    );
  }
}
