import 'package:flutter/material.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/component/skipButton.dart';
import 'package:fp/screens/chooseScreen/chooseScreen.dart';
import 'package:fp/screens/login_intro_screens/loginIntro1Screen.dart';
import 'package:fp/screens/login_intro_screens/loginIntro2Screen.dart';
import 'package:fp/screens/login_intro_screens/loginIntro3Screen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginIntroScreen extends StatefulWidget {
  const LoginIntroScreen({Key? key}) : super(key: key);

  @override
  State<LoginIntroScreen> createState() => _LoginIntroScreenState();
}

class _LoginIntroScreenState extends State<LoginIntroScreen> {

  // controller to keep track of which page we're on
  final PageController _controller = PageController();

  // keep track of if we are on the last page or not
  bool onLastPage = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            //page view
            PageView(
              controller: _controller,
              onPageChanged: (index){
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: const [
                LoginIntro1Screen(),
                LoginIntro2Screen(),
                LoginIntro3Screen(),
              ],
            ),



            // skip  =>  ("تخطي") كلمة
            Container(
              alignment: const Alignment(0.8, -0.85),
              child: SkipButton(
                  onPress: (){
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context){
                        return ChooseScreen();
                      },
                      ),
                    );
                  }
              ),
            ),



            // dot indicator =>   ( .   .   . )
                Container(
                  alignment: const Alignment(0, 0.45),
                  child: SmoothPageIndicator(controller: _controller, count: 3,
                    effect: const ExpandingDotsEffect(
                      dotColor:  Colors.grey,
                      activeDotColor:  Color(0xff0B3939),
                      dotWidth:  11.0,
                      dotHeight:  11.0,
                      spacing:  16,
                    ), ),
                ),





                    //check last page or not  =>    كلمة ("التالي")
                    Container(
                      alignment: const Alignment(0, 0.75),
                      child: BuildButton(
                        title: 'التالي',labelSize: 25,color: 0xff1BE5BF,onPress: (){
                          if(onLastPage){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context){
                                  return const ChooseScreen();
                                },
                                ),
                              );
                          }else{
                            _controller.nextPage(duration: const Duration(microseconds: 500), curve: Curves.easeIn);
                          }
                      }
                      ),
                    ),


          ],
        )
    );
  }
}
