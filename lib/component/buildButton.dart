// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildButton extends StatelessWidget {
  String title;
  VoidCallback onPress;
  int? color;
  double? height;
  double? width;
  double? labelSize;
  IconData? rightIcon;
  IconData? leftIcon;
  double? radius;

  BuildButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.color,
    this.height,
    this.width,
    this.labelSize,
    this.rightIcon,
    this.leftIcon,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height ?? 54,
        width: width ?? 240,
        decoration: BoxDecoration(
          color: Color(color?? MINT_GREEN),
          borderRadius: BorderRadius.circular(radius ?? 31.pt),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Center(
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (rightIcon != null) Icon(rightIcon, color: Colors.white, size: (labelSize!+4) ?? 32),
              SizedBox(width: rightIcon != null ? 4 : 0),
              Flexible(
                child: Text(
                  title,
                  style: GoogleFonts.cairo(
                    color: const Color(0xffFFFFFF),
                    fontSize: labelSize ?? 32,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: leftIcon != null ? 4 : 0),
              if (leftIcon != null) Icon(leftIcon, color: Colors.white, size: (labelSize) ?? 32),

            ],
          ),
        ),
      ),
    );
  }
}