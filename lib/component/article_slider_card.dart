import 'package:flutter/material.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/models/article_model.dart';
import 'package:fp/screens/clientMainScreens/view_all_articles_screen.dart';
import 'package:fp/screens/view_article_screen/view_article_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ArticleSliderCard extends StatelessWidget {
  ArticleSliderCard({
    super.key,
    required this.articleModel,
  });

  ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100.w,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(articleModel.imageUrl),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(28))),
        child: Center(
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(28)),
                    gradient: LinearGradient(
                      stops: const [0, 1],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FittedBox(
                          child: TextWidget(
                            label: articleModel.label,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          articleModel.paragraph,
                          textDirection: TextDirection.rtl,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            height: 1.4,
                            fontSize: 8,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        BuildButton(
                          title: 'تكملة المقال',
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewArticleScreen(
                                    articleModel: articleModel,
                                  ),
                                ));
                          },
                          width: 76,
                          height: 18,
                          labelSize: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        BuildButton(
                          title: 'لقراءة المزيد',
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllArticlesScreen(),));
                          },
                          width: 120,
                          height: 30,
                          labelSize: 16,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
