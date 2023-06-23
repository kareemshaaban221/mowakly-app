// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:fp/constants/constants.dart';
import 'package:fp/models/article_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 124,
            ),

            /// advertisement slider
            CarouselSlider(
                options: CarouselOptions(
                  height: 140,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: true,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {},
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  ArticleSliderCard(articleModel: articlesList[0]),
                  ArticleSliderCard(articleModel: articlesList[1]),
                  ArticleSliderCard(articleModel: articlesList[2]),
                  ArticleSliderCard(articleModel: articlesList[3]),
                ]),

            /// counter (how many lawyers & clients)
            ///

            UsersCounter(clientsCount: 100, lawyersCount: 35),
            
            ///Categories
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'التصنيفات',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(DARK_GREEN),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 96.w,
              height: 52.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                child: Scrollbar(
                  thickness: 4,
                  radius: const Radius.circular(20),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 80,
                          childAspectRatio: 2.2 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: categories.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xff9c9c9c),
                                    spreadRadius: 0.2,
                                    blurRadius: 4,
                                  ),
                                ],
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              categories[index],
                              maxLines: 3,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cairo(
                                  color: const Color(0xff0B3939),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),

            const SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}

Widget UsersCounter({required int clientsCount, required int lawyersCount}){
  double clientPercentage = (clientsCount/(clientsCount+lawyersCount))* 100 ;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child:Container(
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                size: 100,
                counterClockwise: true,
                startAngle: 0,
                angleRange: 360,
                customColors: CustomSliderColors(
                  progressBarColor: Color(MINT_GREEN),
                  trackColor: Color(DARK_GREEN),
                ),
                customWidths: CustomSliderWidths(
                  progressBarWidth: 14,
                  trackWidth: 10,
                  shadowWidth: 10,
                  handlerSize: 0,
                ),
                infoProperties: InfoProperties(
                  mainLabelStyle: GoogleFonts.cairo(
                    color: Color(DARK_GREEN),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  modifier: (percentage) {
                    return 'مستخدمين \n البرنامج ';
                  },
                ),
              ),
              min: 0,
              max: 100,
              initialValue: clientPercentage,
            ),
          ),
          Positioned(
            right: 34,
            top: 60,
            child: Container(
              height: 2,
              width: 100,
              color: Color(DARK_GREEN),
            ),
          ),
          Positioned(
            right: 30,
            top: 50,
            child: Container(
              height: 2,
              width: 100,
              color: Color(MINT_GREEN),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget ArticleSliderCard({required ArticleModel articleModel}) {
  return Container(
      width: 100.w,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
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
                  borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(28)),
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
                        onPress: () {},
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
                        onPress: () {},
                        width: 120,
                        height: 30,
                        labelSize: 16,
                      )
                    ],
                  ),
                ))
          ],
        ),
      ));
}
