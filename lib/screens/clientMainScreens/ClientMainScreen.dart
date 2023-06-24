// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fp/component/chatbot_button.dart';
import 'package:fp/component/main_screens_components.dart';
import 'package:fp/component/navigation_bar.dart';
import 'package:fp/component/side_drawer.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/screens/chatbotScreen/ChatbotScreen.dart';
import 'package:fp/component/appbars/HomeAppBar.dart';
import 'navbar_pages_client/homePage.dart';
import 'navbar_pages_client/messagesPage.dart';
import 'navbar_pages_client/notificationsPage.dart';
import 'navbar_pages_client/proflePage.dart';


///
/// THIS IS  FOR NAVIGATION BETWEEN THESE 4 PAGES   (3 الرئيسية 0, الإشعارات 1, الرساىل 2, ملفي)
///

class ClientMainScreen extends StatefulWidget {
  const ClientMainScreen({Key? key}) : super(key: key);

  @override
  State<ClientMainScreen> createState() => _ClientMainScreenState();
}

class _ClientMainScreenState extends State<ClientMainScreen> {

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
        appBar: HomeAppBar(hideAppbar: onProfilePage,textName: loginmodel!.data!.fname),
        drawer: const SideDrawer(),
        body: Stack(
          children: [

            /// VIEW 4 PAGES
            PageView(
              reverse: true,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onHomePage = (index == 0);
                  onNotificationsPage = (index == 1);
                  onMessagesPage = (index == 2);
                  onProfilePage = (index == 3);

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
            onProfilePage ? const SizedBox.shrink() : SearchBox(),

            /// NAV BAR
            NavBar(
                controller: _controller,
                onHomePage: onHomePage,
                onNotificationsPage: onNotificationsPage,
                onMessagesPage: onMessagesPage,
                onProfilePage: onProfilePage),

            /// chatbot
            ChatBotButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatbotScreen(),
                  ));
            })
          ],
        ),
      ),
    );
  }
}
