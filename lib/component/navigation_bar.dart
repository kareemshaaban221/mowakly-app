// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget NavBar(
    {required controller,
    required onHomePage,
    required onNotificationsPage,
    required onMessagesPage,
    required onProfilePage}) {
  return Align(
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
              onTap: () {
                controller.jumpToPage(0);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.home_filled,
                    color: onHomePage
                        ? const Color(0xff1BE5BF)
                        : const Color(0xffCDD6D6),
                    size: 40,
                  ),
                  Text(
                    'الرئيسية',
                    style: TextStyle(
                      color: onHomePage
                          ? const Color(0xff1BE5BF)
                          : const Color(0xffCDD6D6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            /// INDEX = 1 (notifications)
            InkWell(
              onTap: () {
                controller.jumpToPage(1);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.notifications_rounded,
                    color: onNotificationsPage
                        ? const Color(0xff1BE5BF)
                        : const Color(0xffCDD6D6),
                    size: 40,
                  ),
                  Text(
                    'الإشعارات',
                    style: TextStyle(
                      color: onNotificationsPage
                          ? const Color(0xff1BE5BF)
                          : const Color(0xffCDD6D6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            //space for chatbot
            const SizedBox(
              width: 40,
            ),

            /// INDEX = 2 ( messages)
            InkWell(
              onTap: () {
                controller.jumpToPage(2);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.message_outlined,
                    color: onMessagesPage
                        ? const Color(0xff1BE5BF)
                        : const Color(0xffCDD6D6),
                    size: 40,
                  ),
                  Text(
                    'الرسائل',
                    style: TextStyle(
                      color: onMessagesPage
                          ? const Color(0xff1BE5BF)
                          : const Color(0xffCDD6D6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            /// INDEX = 3 (profile)
            InkWell(
              onTap: () {
                controller.jumpToPage(3);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.person_outlined,
                    color: onProfilePage
                        ? const Color(0xff1BE5BF)
                        : const Color(0xffCDD6D6),
                    size: 40,
                  ),
                  Text(
                    'ملفي',
                    style: TextStyle(
                      color: onProfilePage
                          ? const Color(0xff1BE5BF)
                          : const Color(0xffCDD6D6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ]),
    ),
  );
}
