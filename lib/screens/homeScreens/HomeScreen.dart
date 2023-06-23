// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fp/screens/chatbotScreen/ChatbotScreen.dart';
import 'package:fp/screens/homeScreens/proflePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../component/components.dart';
import 'homePage.dart';
import 'messagesPage.dart';
import 'notificationsPage.dart';

///
/// THIS ONLY CONTAIN
/// 1- CONSTANT APPBAR ,
/// 2- CONSTANT SEARCH BOX
/// 3- CONSTANT SIDE DRAWER ,
/// 4- CONSTANT BOTTOM NAVIGATION BAR
///
/// TO DISPLAY OVER THESE 4 PAGES   (3 الرئيسية 0, الإشعارات 1, الرساىل 2, ملفي)
///



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

String userName =  'أحمد محمد علي';

  final PageController _controller = PageController();
  bool onHomePage = true;
  bool onNotificationsPage = false;
  bool onMessagesPAge = false;
  bool onProfilePage = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        /// APPBAR
        appBar: AppBar(
          backgroundColor: const Color(0xff1BE5BF),
          iconTheme: const IconThemeData(color: Color(0xff0B3939)),
          elevation: 0,
          actions: [
            Text(
              userName,
              style: GoogleFonts.cairo(
                  color: const Color(0xff0B3939),
                  fontSize: 16.sp,
                  height: 3.6,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,),
              child: CircleAvatar(
                backgroundColor: const Color(0xff0B3939),
                radius: 34,
                child: ClipOval(
                  child: Image.asset('${assetImage}help.png',  fit: BoxFit.cover,)
                ),
              ),
            ),
          ],
        ),

        ///   SIDE DRAWER
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(height: 12.h,),
              DrawerElement(label: 'الرئيسية', onPress: () {}),
              DrawerElement(label: 'طلب استشارة', onPress: () {}),
              DrawerElement(label: 'الصفحة الشخصية', onPress: () {}),
              DrawerElement(label: 'الإعدادات', onPress: () {}),
              DrawerElement(label: 'تواصل معنا', onPress: () {}),
              DrawerElement(label: 'من نحن', onPress: () {}),
              DrawerElement(label: 'الأسئلة الشائعة', onPress: () {}),
              DrawerElement(label: 'الرسائل', onPress: () {}),
            ],
          ),
        ),
        body: Stack(
          children: [





            /// VIEW 4 PAGES
            PageView(
              reverse: true,
              controller: _controller,
              onPageChanged: (index){
                setState(() {
                  onHomePage = (index==0);
                  onNotificationsPage = (index==1);
                  onMessagesPAge = (index==2);
                  onProfilePage = (index==3);
                });
              },
              children: const [
                HomePage(),
                NotificationsPage(),
                MessagesPage(),
                ProfilePage(),
              ],
            ),



            /// search box
            Container(
              color: const Color(0xff1BE5BF),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: TextField(
                  autocorrect: false,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Color(0xff000000)),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: const Color(0xffCDD6D6),
                      size: 20.sp,
                    ),
                    hintText: ' ابحث من هنا',
                    hintStyle: GoogleFonts.cairo(
                        fontSize: 14.8.sp,
                        color: const Color(0xffCDD6D6),
                        fontWeight: FontWeight.w600),
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    enabledBorder: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(28.0)),
                        borderSide: BorderSide(color: Color(0xffffffff))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(28.0)),
                        borderSide: BorderSide(color: Color(0xff0B3939))),
                    filled: true,
                  ),
                ),
              ),
            ),
            /// CUSTOMIZED BOTTOM NAVIGATION BAR
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 75,
                width: 400,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffe2e2e2),
                      spreadRadius: 0.5,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /// INDEX = 0 (home)
                      InkWell(
                        onTap: (){
                          _controller.jumpToPage(0);
                        },
                        child: Column(
                          children: [
                            Icon(Icons.home_filled, color: onHomePage?const Color(0xff1BE5BF):const Color(0xffCDD6D6),size: 40,),
                            Text('الرئيسية', style:TextStyle(color: onHomePage?const Color(0xff1BE5BF):const Color(0xffCDD6D6),fontSize: 14,),),
                          ],
                        ),
                      ),
                      /// INDEX = 1 (notifications)
                      InkWell(
                        onTap: (){
                          _controller.jumpToPage(1);
                        },
                        child: Column(
                          children: [
                            Icon(Icons.notifications_rounded, color: onNotificationsPage?const Color(0xff1BE5BF):const Color(0xffCDD6D6),size: 40,),
                            Text('الإشعارات', style:TextStyle(color: onNotificationsPage?const Color(0xff1BE5BF):const Color(0xffCDD6D6),fontSize: 14,),),
                          ],
                        ),
                      ),

                      //space for chatbot
                      const SizedBox(width: 40,),

                      /// INDEX = 2 ( messages)
                      InkWell(
                        onTap: (){
                          _controller.jumpToPage(2);
                        },
                        child: Column(
                          children: [
                            Icon(Icons.message_outlined, color: onMessagesPAge?const Color(0xff1BE5BF):const Color(0xffCDD6D6),size: 40,),
                            Text('الرسائل', style:  TextStyle(color: onMessagesPAge?const Color(0xff1BE5BF):const Color(0xffCDD6D6),fontSize: 14,),),
                          ],
                        ),
                      ),
                      /// INDEX = 3 (profile)
                      InkWell(
                        onTap: (){
                          _controller.jumpToPage(3);
                        },
                        child: Column(
                          children: [
                            Icon(Icons.person_outlined, color: onProfilePage?const Color(0xff1BE5BF):const Color(0xffCDD6D6),size: 40,),
                            Text('ملفي', style:  TextStyle(color: onProfilePage?const Color(0xff1BE5BF):const Color(0xffCDD6D6),fontSize: 14,),),
                          ],
                        ),
                      ),

                    ]),
              ),
            ),

            /// chatbot
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                        blurRadius: 15,
                      ),
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Color(0xFFFffffff), Color(0xFFF3F2F2)]),
                    shape: BoxShape.circle),
              ),
            ),
            //chat bot
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatbotScreen(),));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffCDD6D6),
                        spreadRadius: 0.5,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  // child: const Icon(Icons.smart_toy_outlined, color: Color(0xff1BE5BF), size: 46,)
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(fit: BoxFit.fill,'asset/chatbot-green.png'),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget DrawerElement({required String label, required VoidCallback onPress}){
  return InkWell(
    onTap: onPress,
    child: Column(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: CircleAvatar(
                backgroundColor: Color(0xff0B3939),
                radius: 7,
                child: CircleAvatar(
                  backgroundColor: Color(0xff1BE5BF),
                  radius: 5,
                ),
              ),
            ),
            Text(label, style:GoogleFonts.cairo(
                fontSize: 18.sp
            ),),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
          child: Divider(thickness: 1,),
        )
      ],
    ),
  );
}
