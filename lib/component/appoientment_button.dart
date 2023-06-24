// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget AppoientmentButton({required VoidCallback onPressed}){
  return Stack(
    children: [
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
          onTap: onPressed,
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(fit: BoxFit.fill,'asset/Group 532.png'),
              )
          ),
        ),
      )
    ],
  );
}