// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/constants.dart';
import 'package:fp/models/article_model.dart';
import 'package:fp/screens/view_article_screen/view_article_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../buildButton.dart';

class ArticlesListWidget extends StatefulWidget {
   ArticlesListWidget({
    Key? key,
     this.height,
  }) : super(key: key);

   double? height;

  @override
  State<ArticlesListWidget> createState() => _ArticlesListWidgetState();
}

class _ArticlesListWidgetState extends State<ArticlesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: widget.height?? 58.h,
        child: ListView.builder(
          itemCount: articlesList.length +1,
          itemBuilder: (BuildContext context, int index) {
            if(index == articlesList.length){
              return const SizedBox(height: 160,);
            }
            return ArticleItem(articleModel: articlesList[index]);
          },
        ),
      ),
    );
  }

  Widget ArticleItem({required ArticleModel articleModel}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        width: 100.w,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      articleModel.label,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      articleModel.paragraph,
                      textDirection: TextDirection.rtl,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        height: 1.4,
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.rtl,
                      children: [
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            const Icon(
                              Icons.person_outline,
                              color: Color(0xffadadad),
                              size: 16,
                            ),
                            SizedBox(
                              width: 60,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  articleModel.author,
                                  style: GoogleFonts.cairo(
                                    fontSize: 10,
                                    color: const Color(0xff555555),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
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
                        BuildButton(
                          title: 'قراءة المزيد',
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewArticleScreen(
                                    articleModel: articleModel,
                                  ),
                                ));
                          },
                          width: 64,
                          height: 24,
                          labelSize: 8,
                          leftIcon: Icons.arrow_back_ios_rounded,
                          radius: 8,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(16)),
                  image: DecorationImage(
                    image: NetworkImage(articleModel.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
