

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/models/classModels.dart';
import 'package:fp/network/end_point.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/network/remote/dio_helper.dart';
import 'package:fp/screens/loginScreen/cubit/statesCubit.dart';

class LoginScreenCubit extends Cubit<LoginStates>{

  LoginScreenCubit():super (LoginInitialState());

  static LoginScreenCubit get(context)=>BlocProvider.of(context);

    Future userLogin({@required String ?email,@required String ? password,@required String ? userType,})async{

    emit(LoginLoadingState());
    return
    await DioHelper.PostData(
        url: userType=='client'? LOGIN:'/api/lawyer/login',
        data: {
          'user_type':userType,
          'email':email,
          'password':password,
        },

    ).then((value){
      print(value.data);
      loginmodel=LoginModel.fromJson(value.data);

      print(loginmodel!.message.toString());
      done=true;
      emit(LoginSuccessState());

      return value.data;
    }).catchError((onError){
       done=false;
      print(onError.toString());

      emit(LoginErrorState());
      return 'dd';
    },

    );
  }
}