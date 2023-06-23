// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fp/component/appbars/secondary_appbar.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/component/components.dart';
import 'package:fp/component/main_screens_components.dart';
import 'package:fp/component/side_drawer.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/component/themes/text_field_theme.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:fp/constants/dropdown_lists.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../component/form_components.dart';

class BookConsultation extends StatefulWidget {
  const BookConsultation({Key? key}) : super(key: key);

  @override
  State<BookConsultation> createState() => _BookConsultationState();
}

class _BookConsultationState extends State<BookConsultation> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedFromTime;
  late TimeOfDay _selectedToTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectClock(
      BuildContext context, TimeOfDay selectedTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedFromTime = TimeOfDay.now();
    _selectedToTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(LIGHT_GREY),
        appBar: SecondaryAppBar(label: 'حجز استشارة'),
        drawer: const SideDrawer(),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TFLabel(label: 'التاريخ'),
                          DateTextField(
                              context: context, selectedDate: _selectedDate),
                          Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TFLabel(label: 'موعد البدء'),
                                  ClockTextField(
                                      context: context,
                                      selectedTime: _selectedFromTime)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TFLabel(label: 'موعد الانتهاء'),
                                  ClockTextField(
                                      context: context,
                                      selectedTime: _selectedToTime)
                                ],
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              TFLabel(label: 'الوصف'),
                              const SizedBox(
                                width: 4,
                              ),
                              const TextWidget(
                                label: '(اختياري)',
                                color: Color(0xffadadad),
                                fontSize: 12,
                              )
                            ],
                          ),
                          RegularTextField(
                              hint:
                                  'يمكنك هنا كتابة وصف للاستشارة من أجل أن يقوم المحامي بقرائتها',
                              maxLines: 2),
                          TFLabel(label: 'طرق الدفع'),
                          DropdownTextField(dropdownList: PAYMENT_METHODS),
                        ],
                      )),
                ),
                
                ConsultationPrice(price: '500'),
                
                BuildButton(title: 'طلب الاستشارة',labelSize: 18,height: 40,width: 200, onPress:(){} ),

              ],
            ),
          ),
        ),
      ),
    ));
  }
}
