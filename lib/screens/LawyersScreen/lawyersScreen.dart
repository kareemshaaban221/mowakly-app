import 'package:flutter/material.dart';
import 'package:fp/component/appbars/secondary_appbar.dart';
import 'package:fp/component/buildButton.dart';
import 'package:fp/component/complete_widgets/messages_widget.dart';
import 'package:fp/component/side_drawer.dart';
import 'package:fp/component/text_widget.dart';
import 'package:fp/constants/constant_colors.dart';
import 'package:fp/constants/constants.dart';
import 'package:fp/constants/lawyers.dart';
import 'package:fp/models/LawyerModel.dart';
import 'package:fp/screens/book_consultation/book_consultation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LawyersScreen extends StatefulWidget {
  LawyersScreen({Key? key, required this.category}) : super(key: key);

  String category;

  @override
  State<LawyersScreen> createState() => _LawyersScreenState();
}

class _LawyersScreenState extends State<LawyersScreen> {
  @override
  var selectValue = 'أسرة';
  var selectValue1 = 'غيرمحدد';
  var selectValue2 = '400-500';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(LIGHT_GREY),
      appBar: SecondaryAppBar(label: widget.category,),
      drawer: const SideDrawer(),
      body: Column(
        children: [
          FilterAppliedWidget(
              selectValue: widget.category,
              selectValue1: selectValue1,
              selectValue2: selectValue2),


          SizedBox(
            height: 66.h,
            width: 100.w,
            child:ListView.builder(
              itemCount: lawyers.length,
              itemBuilder: (context, index) {
                if (index >= lawyers.length) {
                  // This index is not valid, return an empty widget
                  return SizedBox.shrink();
                }
                // Check if the lawyer's major matches the current category
                if (lawyers[index].major == widget.category) {
                  // Return a LawyerViewItem widget for this lawyer
                  return LawyerViewItem(
                    lawyer:lawyers[index],
                   context: context,
                  );
                } else {
                  // The lawyer's major doesn't match the category, return an empty widget
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}







Widget FilterAppliedWidget(
    {required selectValue, required selectValue1, required selectValue2}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'التصنيف',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: DropdownButton(
                      underline: SizedBox(),
                      value: selectValue,
                      onChanged: (value) {
                        setState(() {
                          selectValue = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                            value: "أسرة",
                            child: Text(
                              "أسرة",
                              style: TextStyle(fontSize: 12),
                            )),
                        DropdownMenuItem(
                            value: "مدني",
                            child: Text(
                              "مدني",
                              style: TextStyle(fontSize: 12),
                            )),
                        DropdownMenuItem(
                            value: "جنح",
                            child: Text(
                              "جنح",
                              style: TextStyle(fontSize: 12),
                            )),
                        DropdownMenuItem(
                            value: "جرائم إلكترونية",
                            child: Text(
                              "جرائم إلكترونية",
                              style: TextStyle(fontSize: 12),
                            )),
                        DropdownMenuItem(
                            value: "عمال",
                            child: Text(
                              "عمال",
                              style: TextStyle(fontSize: 12),
                            )),
                        DropdownMenuItem(
                            value: "تجاري وشركات",
                            child: Text(
                              "تجاري وشركات",
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 20),
                  child: Text(
                    'المحافظة',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: DropdownButton(
                      underline: SizedBox(),
                      value: selectValue1,
                      onChanged: (value) {
                        setState(() {
                          selectValue1 = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                            value: "الدقهلية",
                            child: Text(
                              "الدقهلية",
                              style: TextStyle(fontSize: 12),
                            )),
                        DropdownMenuItem(
                            value: "غيرمحدد",
                            child: Text(
                              "غيرمحدد",
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                SizedBox(
                  width: 3.w,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'السعر',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: DropdownButton(
                      underline: SizedBox(),
                      value: selectValue2,
                      onChanged: (value) {
                        setState(() {
                          selectValue2 = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                            value: "300-400",
                            child: Text(
                              "300-400",
                              style: TextStyle(fontSize: 12),
                            )),
                        DropdownMenuItem(
                            value: "400-500",
                            child: Text(
                              "400-500",
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      );
    },
  );
}


Widget LawyerViewItem({required LawyerModel lawyer, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),


      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CircleAvatar(
                  backgroundColor: const Color(0xff0B3939),
                  radius: 28,
                  child: ClipOval(
                      child: Image.asset(
                        userAvatar,
                        fit: BoxFit.cover,
                      )),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ' المحامي ${lawyer.name}',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff0B3939),
                    ),
                  ),

                  Text(
                    'محامي ${lawyer.major}',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff9c9c9c),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    TextWidget(label: 'جنيه', color: Color(MINT_GREEN), fontSize: 10,fontWeight: FontWeight.w800,),
                    const SizedBox(width: 4,),
                    TextWidget(label: lawyer.price, color: Color(MINT_GREEN), fontWeight: FontWeight.w600,fontSize: 24,),
                  ],
                ),
                BuildButton(
                  title: 'استشير',
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookConsultation(lawyerModel: lawyer,),));
                  },
                  height: 28,
                  width: 72,
                  labelSize: 12,
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
