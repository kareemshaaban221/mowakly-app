import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/screens/massageScreen/Cubit/cubitMassageScreen.dart';
import 'package:fp/screens/massageScreen/Cubit/statesCubit.dart';
import 'package:fp/screens/massageScreen/containerMassage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MassageScreen extends StatelessWidget {
   MassageScreen({Key? key}) : super(key: key);

TextEditingController ?textEditingController;
  @override



  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => MassageCubit(),
    child: BlocConsumer<MassageCubit,MassageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        MassageCubit cuibt=MassageCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF0B3939),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xFF1BE5BF),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Color(0xFF1BE5BF),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  'شات بوت موكلي',
                  style: GoogleFonts.cairo(
                    height: 2.8,
                    color: const Color(0xffffffff),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                  top: 12,
                  bottom: 12,
                  right: 12.w,
                ),
                child: Image.asset('asset/chatbot-white.png'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height: 80.h,
                    width: 100.w,
                    child: ListView.builder(
                        itemCount: chat.length,
                        itemBuilder: (context, index) => ContainerMessage(text: chat[index],chatwho: chatWho[index].toString())),
                  ),


/////////////////////////////////////////////////////
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffeeeeee),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: 76.w,
                                child: TextField(


                                  textAlign: TextAlign.right,
                                  style: const TextStyle(color: Colors.black,),
                                  controller: textEditingController,
                                  onSubmitted: (value) async {
                                    // await sendMessageFCT();
                                  },
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'اكتب رسالتك هنا',
                                      hintTextDirection: TextDirection.rtl,
                                      hintStyle: GoogleFonts.cairo(
                                        color: Colors.grey,
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xff0B3939),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  cuibt.sendMassage(id: 1, message: textEditingController?.text);
                                },
                                icon: Transform.rotate(
                                  angle: 315 * 3.14 / 180, // 45 degrees in radians
                                  child: const Icon(
                                    Icons.send_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],

              ),
            ),
          ),
        );
      },
    ),
    );

  }
}
