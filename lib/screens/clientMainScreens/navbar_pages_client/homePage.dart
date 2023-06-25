// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fp/component/article_slider_card.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/cases_categories.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:fp/constants/constants.dart';
import 'package:fp/screens/LawyersScreen/lawyersScreen.dart';

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
      backgroundColor: Color(LIGHT_GREY),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),

            ///  slider
            CarouselSlider(
                options: CarouselOptions(
                  height: 140,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: true,
                  autoPlay: true,
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
                ]),

            /// counter (how many lawyers & clients)

            UsersCounter(clientsCount: 100, lawyersCount: 35),

            ///Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    'التصنيفات',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(DARK_GREEN),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 248,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.builder(
                    itemCount: casesCategory.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 118,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LawyersScreen(
                                  category: casesCategory[index].name,
                                ),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 200,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              casesCategory[index].imageUrl)),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: TextWidget(
                                        label: casesCategory[index].name,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_right,
                                      color: Color(MINT_GREEN),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 160,
            )
          ],
        ),
      ),
    );
  }
}

Widget UsersCounter({required int clientsCount, required int lawyersCount}) {
  // double clientPercentage =
  //     (clientsCount / (clientsCount + lawyersCount)) * 100;

  double clientPercentage = 35;
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: 45,
            top: 60,
            child: Row(
              children: [
                Text(
                  '570 عميل',
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.cairo(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 4,),
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(MINT_GREEN),
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                    color: Color(DARK_GREEN),
                  ),
                ),
                Container(
                  height: 2,
                  width: 40,
                  color: Color(MINT_GREEN),
                ),
              ],
            ),
          ),

          Positioned(
            right: 30,
            top: 20,
            child: Row(
              children: [
                Container(
                  height: 2,
                  width: 40,
                  color: Color(DARK_GREEN),
                ),
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(MINT_GREEN),
                    border: Border.all(
                      color: Color(DARK_GREEN),
                      width: 1,
                    ),
                  ),
                ),
                SizedBox(width: 4,),
                Text(
                  '35 محامي',
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.cairo(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Center(
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                size: 80,
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
                    fontSize: 8,
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
        ],
      ),
    ),
  );
}
