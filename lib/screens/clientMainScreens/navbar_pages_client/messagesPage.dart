import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/component/complete_widgets/messages_widget.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/screens/massageScreen/Cubit/cubitMassageScreen.dart';
import 'package:fp/screens/massageScreen/Cubit/statesCubit.dart';
import 'package:fp/screens/massageScreen/massageScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => MassageCubit()..getMessageLawyers(),
    child: BlocConsumer<MassageCubit,MassageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
       MassageCubit cubit= MassageCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [

                MessagesWidget(),
                SizedBox(
                  width: 100.w,
                  height: 62.h,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async{
                         await cubit.geAllMassage(id: lawyerForUser?['id']);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MassageScreen(),));
                        },
                        child: MessagesItem(
                            event: '${lawyerForUser?['fname']} ${lawyerForUser?['lname']}',
                            dayWeek: '20-6-2023',
                            date: '16-3-2-23',
                            hour: '10:15'),
                      );
                    },
                  ),
                ),
                SizedBox(height: 140,) //خليها دايما مسافة من تحت عشان الاب بار ميغطيش ع الكونتنت
              ],
            ),
          ),
        );
      },
    ),
    );
  }
}
