
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fp/screens/payScreen/cubit/stateCubit.dart';

class PayScreenCubit extends Cubit<PayScreenState>{
  PayScreenCubit():super (PayInitialState());
  static PayScreenCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  Color colorActive=Color(0xff1BE5BF);
  Color colorUnActive=Color(0xff0B3939).withOpacity(0.1);
  Color ?color;



  void changeIndex(int index){
    currentIndex=index;
    emit(PayChangeState());
  }

  void change(){
    emit(PayChangeState());
  }

   changeColor(int index){

    if(index==currentIndex){
     return colorActive;
    }
    else{
      return colorUnActive;
    }

  }

}
