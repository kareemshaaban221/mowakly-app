

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/network/end_point.dart';
import 'package:fp/network/remote/dio_helper.dart';
import 'package:fp/screens/loginScreen/cubit/statesCubit.dart';

class LoginScreenCubit extends Cubit<LoginStates>{

  LoginScreenCubit():super (LoginInitialState());

  static LoginScreenCubit get(context)=>BlocProvider.of(context);

  void userLogin({@required String ?email,@required String ? password,@required String ? userType,}){

    emit(LoginLoadingState());
    DioHelper.PostData(
        url: LOGIN,
        data: {
          'user_type':userType,
          'email':email,
          'password':password,
        },
    ).then((value){
      print(value.data);
      emit(LoginSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(LoginErrorState());
    });
  }
}