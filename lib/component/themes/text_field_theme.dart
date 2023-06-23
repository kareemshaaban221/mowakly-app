// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../constants/constant_colors.dart';

Widget TextFieldTheme({required Widget child}) {
  return Theme(
      data: ThemeData(
        primarySwatch: MINT_PRIMARY_COLOR,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(LIGHT_GREY))),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(LIGHT_GREY)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(MINT_GREEN)),
              borderRadius: BorderRadius.circular(16),
            )),
      ),
      child: child);
}
