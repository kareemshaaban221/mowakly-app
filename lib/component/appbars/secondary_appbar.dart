// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
   SecondaryAppBar({super.key, required this.label,}) ;
   String label;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Color(DARK_GREEN)),
      backgroundColor: Color(MINT_GREEN),
      title: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextWidget(
              label: label,
              fontWeight: FontWeight.w700,
              color: Color(DARK_GREEN),
            ),
          ],
        ),
      ),
    );
  }
}