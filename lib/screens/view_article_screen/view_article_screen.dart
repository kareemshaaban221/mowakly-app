// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fp/component/chatbot_button.dart';
import 'package:fp/component/main_screens_components.dart';
import 'package:fp/component/navigation_bar.dart';
import 'package:fp/component/side_drawer.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:fp/constants/constants.dart';
import 'package:fp/models/article_model.dart';
import 'package:fp/screens/LawyerMainScreens/navbar_pages_lawyer/messages_page_lawyer.dart';
import 'package:fp/screens/LawyerMainScreens/navbar_pages_lawyer/notification_page_lawyer.dart';
import 'package:fp/screens/LawyerMainScreens/navbar_pages_lawyer/profile_page_lawyer.dart';
import 'package:fp/screens/chatbotScreen/ChatbotScreen.dart';
import 'package:fp/component/appbars/HomeAppBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewArticleScreen extends StatefulWidget {
  ViewArticleScreen({Key? key, required this.articleModel}) : super(key: key);

  ArticleModel articleModel;

  @override
  State<ViewArticleScreen> createState() => _ViewArticleScreenState();
}

class _ViewArticleScreenState extends State<ViewArticleScreen> {
  final PageController _controller = PageController();
  bool onHomePage = true;
  bool onNotificationsPage = false;
  bool onMessagesPage = false;
  bool onProfilePage = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: HomeAppBar(),
        drawer: const SideDrawer(),
        body: CompleteArticle(
          articleModel: widget.articleModel,
        ),
      ),
    );
  }
}

class CompleteArticle extends StatelessWidget {
  CompleteArticle({Key? key, required this.articleModel}) : super(key: key);
  ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(LIGHT_GREY),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    /// title & author
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(DARK_GREEN),
                                width: 1,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'asset/user_avatar.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              articleModel.label,
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                height: 1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Text(
                                  ' المحامي',
                                  style: GoogleFonts.cairo(
                                    fontSize: 10,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  articleModel.author,
                                  style: GoogleFonts.cairo(
                                    fontSize: 14,
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            //TextWidget(label: articleModel.label, fontWeight: FontWeight.w700,),
                            //TextWidget(label: articleModel.author, fontSize: 14,fontWeight: FontWeight.w600,),
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Color(0xffadadad),
                                  size: 14,
                                ),
                                TextWidget(
                                  label: intl.DateFormat('dd/MM/yyyy')
                                      .format(articleModel.date),
                                  fontSize: 8.8,
                                  color: const Color(0xffadadad),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    ///picture
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: NetworkImage(articleModel.imageUrl),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),

                    ///paragraph
                    TextWidget(
                      label: articleModel.paragraph,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ///also read
                    TextWidget(
                      label: 'اقرأ أيضاً',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        height: 160,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:  min(articlesList.length, 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 4,
                            mainAxisExtent: 20,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewArticleScreen(
                                          articleModel: articlesList[index]),
                                    ));
                              },
                              child: TextWidget(
                                label: articlesList[index].label,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );
  }
}
