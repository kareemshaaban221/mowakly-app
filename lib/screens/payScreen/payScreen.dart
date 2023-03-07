import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fp/component/components.dart';
import 'package:fp/screens/payScreen/Components.dart';
import 'package:fp/screens/payScreen/cubit/cubitPayScreen.dart';
import 'package:fp/screens/payScreen/cubit/stateCubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PayScreen extends StatelessWidget {
   PayScreen({Key? key}) : super(key: key);
  static String id = 'payScreen';
  bool vlau=false;




  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context) => PayScreenCubit(),
      child: BlocConsumer<PayScreenCubit,PayScreenState>(
        listener: (context, state){} ,
          builder: (context, state) {
         PayScreenCubit cubit=PayScreenCubit.get(context);

         List <Widget> listOfPayScreens=[
           widgetBuiltScreenVisa(
             controllerNumberCard: TextEditingController(),
             controllerDataCard: TextEditingController(),
             validationDataCard: (){ return 'kkk';},
             validationNumberCard: (){ return 'kkk';},
             valu: vlau,
             on: (value){
               vlau=value;
               cubit.change();

             }

           ),
           widgetBuiltScreenVisa(
             controllerNumberCard: TextEditingController(),
             controllerDataCard: TextEditingController(),
             validationDataCard: (){ return 'kkk';},
             validationNumberCard: (){ return 'kkk';},
               valu: vlau,
               on: (value){
                 vlau=value;
                 cubit.change();
               }
           ),
           widgetBuiltScreenVisa(
             controllerNumberCard: TextEditingController(),
             controllerDataCard: TextEditingController(),
             validationDataCard: (){ return 'kkk';},
             validationNumberCard: (){ return 'kkk';},
               valu: vlau,
               on: (value){
                 vlau=value;
                 cubit.change();
               }
           ),
           //widgetBuiltScreenMaster(),
           //widgetBuiltScreenVisa(),
         ];
          return Scaffold(
            backgroundColor: const Color(0xff0B3939),
            body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 13.81.h,
                            width: double.infinity,
                            child: Center(
                              child: SizedBox(
                                height: 5.23.h,
                                width: 81.30.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text('طرق الدفع',
                                      style: TextStyle(
                                        fontSize: 19.sp,
                                        color: Color(0xffFFFFFF),
                                        fontFamily: 'Cairo',
                                      ),
                                    ),

                                    Container(
                                      height: 4.12.h,
                                      width:21.72.w ,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFFFFF).withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(31.pt),
                                      ),
                                      child: const Center(
                                          child: Text(
                                            'تخطي',
                                            style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                            ),)
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Container(
                            height:86.18.h,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Color(0xffFFFFFF),
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(50.0),topRight: Radius.circular(50.0))
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 4.90.h,),
                                  // Row icons methods pay
                                  SizedBox(
                                    height: 12.4.h,
                                    width: 90.53.w,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 12.4.h,
                                          width: 80.53.w,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: listIconsPayScreen.length,
                                              itemBuilder:(context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                                  child: build_container_icon_pay(
                                                    color:  cubit.changeColor(index),
                                                    icon: listIconsPayScreen[index],
                                                    ontap: (){
                                                      cubit.changeIndex(index);
                                                    },
                                                  ),
                                                );
                                              },
                                          ),
                                        ),

                                        Container(
                                          height: 10.0.h,
                                          width:8.17.w ,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 4.0,
                                              ),
                                            ],
                                          ),

                                          child: SvgPicture.asset(assetIcons+'Group 322.svg',fit: BoxFit.none,),

                                        ),
                                      ],
                                    ),

                                    /*Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        build_container_icon_pay(
                                          icon: assetIcons+'Group 315.svg',
                                          ontap: (){
                                            cubit.changeIndex(0);
                                          },
                                        ),
                                        build_container_icon_pay(
                                          icon: assetIcons+'MasterCard-Logo-1979.svg',
                                          ontap: (){
                                            cubit.changeIndex(1);
                                          },
                                        ),
                                        build_container_icon_pay(
                                            icon: assetIcons+'MasterCard-Logo-1979.svg',
                                          ontap: (){},
                                        ),
                                        Container(
                                          height: 10.0.h,
                                          width:8.17.w ,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 4.0,
                                              ),
                                            ],
                                          ),

                                          child: SvgPicture.asset(assetIcons+'Group 322.svg',fit: BoxFit.none,),

                                        ),
                                      ],
                                    ),*/
                                  ),
                                  // Row icons methods pay
                                  SizedBox(height: 5.23.h,),
                                  ////////////////////////////////////////////////////////////
                                  listOfPayScreens[cubit.currentIndex],
                                  ///////////////////////////////////////////////////////////////
                                  SizedBox(height: 6.02.h,),
                                  build_button(title: 'التالــــــي',ontap: (){})
                                ],
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ),
          );

          } ,

          ),
    );
  }
}
