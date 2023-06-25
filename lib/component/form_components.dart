// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fp/component/themes/text_field_theme.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget ClockTextField({required BuildContext context, required selectedTime}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: SizedBox(
          width: 38.w,
          child: TextFieldTheme(
            child: TextFormField(
              textAlign: TextAlign.right,
              readOnly: true,
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null && picked != selectedTime) {
                  setState(() {
                    selectedTime = picked;
                  });
                }
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.arrow_drop_down,
                ),
              ),
              controller: TextEditingController(
                text: selectedTime.format(context),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget DateTextField({required BuildContext context, required selectedDate}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: TextFieldTheme(
          child: TextFormField(
            textAlign: TextAlign.right,
            readOnly: true,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 0,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.calendar_today),
            ),
            controller: TextEditingController(
              text:
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            ),
          ),
        ),
      );
    },
  );
}

Widget DropdownTextField({required List<String> dropdownList, String? hint}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: TextFieldTheme(
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: hint ?? '',
            hintStyle: GoogleFonts.cairo(
              color: const Color(0xffc9c9c9),
              fontSize: 12,
            ),
          ),
          items: dropdownList.map((String paymentMethod) {
            return DropdownMenuItem<String>(
              value: paymentMethod,
              child: Text(paymentMethod),
            );
          }).toList(),
          onChanged: (String? value) {
            // Handle the selected value
          },
        ),
      ),
    ),
  );
}

Widget RegularTextField({
  String? hint,
  String? initial_value,
  int? maxLines,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: TextFieldTheme(
      child: TextFormField(
        initialValue: initial_value?? '',
        maxLines: maxLines ?? 1,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: hint ?? '',
            hintStyle: GoogleFonts.cairo(
                color: const Color(0xffc9c9c9), fontSize: 12)),
      ),
    ),
  );
}



Widget TransparentTextField({
  String? hint,
  String? initial_value,
  int? maxLines,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Theme(
      data: ThemeData(
        primarySwatch: MINT_PRIMARY_COLOR,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xff9c9c9c))),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(LIGHT_GREY)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(MINT_GREEN)),
              borderRadius: BorderRadius.circular(16),
            )),
      ),
      child: TextFormField(
        initialValue: initial_value?? '',
        maxLines: maxLines ?? 1,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            filled: true,
            fillColor: Colors.transparent,
            hintText: hint ?? '',
            hintStyle: GoogleFonts.cairo(
                color: const Color(0xffc9c9c9), fontSize: 12)),
      ),
    ),
  );
}



Widget TransparentTextField2({
  String? hint,
  int? maxLines,
  TextEditingController? controller,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Theme(
      data: ThemeData(
        primarySwatch: MINT_PRIMARY_COLOR,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xff9c9c9c))),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(LIGHT_GREY)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(MINT_GREEN)),
              borderRadius: BorderRadius.circular(16),
            )),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            filled: true,
            fillColor: Colors.transparent,
            hintText: hint ?? '',
            hintStyle: GoogleFonts.cairo(
                color: const Color(0xffc9c9c9), fontSize: 12)),
      ),
    ),
  );
}
