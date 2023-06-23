import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.label,
      this.fontSize,
      this.color,
      this.fontWeight,
        this.textDirection
      })
      : super(key: key);

  final String label;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textDirection: textDirection?? TextDirection.rtl,
      style: GoogleFonts.cairo(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 20,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
