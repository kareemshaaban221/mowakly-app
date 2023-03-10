import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [
    "أسرة",
    "مجلس الدولة",
    "جرائم إلكترونية",
    "قضاء عسكري",
    "تجاري وشركات",
    "عمال",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),

            /// advertisement slider
            CarouselSlider(
                options: CarouselOptions(
                  height: 18.h,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {},
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  AdvertisementCard(),
                ]),

            /// counter (how many lawyers & clients)
            SizedBox(height: 50,),

            ///Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  Text('التصنيفات',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1BE5BF),
                    ),
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text('مشاهدة الكل',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff0B3939),
                        ),
                      ),
                      Icon(Icons.arrow_back_ios_rounded, color: Color(0xff0B3939), size: 16.sp,)
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 96.w,
              height: 52.w,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                child: Scrollbar(
                  thickness: 4,
                  radius: Radius.circular(20),
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
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff9c9c9c),
                                    spreadRadius: 0.2,
                                    blurRadius: 4,
                                  ),
                                ],
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              categories[index],
                              maxLines: 3,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cairo(
                                  color: Color(0xff0B3939),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),

            SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}

Widget AdvertisementCard() {
  return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: Color(0xff0B3939),
          borderRadius: BorderRadius.all(Radius.circular(28))),
      child: Center(
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تخفيضات',
                  style: GoogleFonts.cairo(
                      fontSize: 24.sp,
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'على أول خدمة',
                  style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      height: 1.2,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),

                //button
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 4.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: Color(0xff1BE5BF),
                        borderRadius: BorderRadius.circular(31.pt),
                      ),
                      child: Center(
                          child: Text(
                        'احصل عليها الآن',
                        style: GoogleFonts.cairo(
                          color: Color(0xff0B3939),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                    ),
                  ),
                )
              ],
            ),

            //50 % discount
            Stack(
              children: [
                Text(
                  '50 ',
                  style: GoogleFonts.cairo(
                      fontSize: 40.sp,
                      color: Colors.white,
                      height: 1.4,
                      fontWeight: FontWeight.w800),
                ),

                Positioned(
                  bottom: 24,
                  right: 0,
                  child: Stack(
                    children: [
                      // Implement the stroke
                      Text(
                        '%',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Color(0xff0B3939),
                        ),
                      ),
                      // The text inside
                      Text(
                        '%',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Positioned(
                //   bottom: 1,
                //   right: 2,
                //   child: Text(
                //     '%',
                //     style: GoogleFonts.cairo(
                //         fontSize: 20.sp,
                //         color: Colors.white,
                //         height: -3,
                //         fontWeight: FontWeight.w800),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ));
}
