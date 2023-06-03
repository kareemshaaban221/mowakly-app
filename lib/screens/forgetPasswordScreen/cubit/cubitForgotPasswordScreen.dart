import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/network/end_point.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/network/remote/dio_helper.dart';
import 'package:fp/screens/forgetPasswordScreen/cubit/statesCubit.dart';

class ForgotPasswordScreenCubit extends Cubit<ForgotPasswordStates>{
  ForgotPasswordScreenCubit():super(ForgotLoadingState());

  static ForgotPasswordScreenCubit get(context)=>BlocProvider.of(context);



  void codeSent({@required String ? userType,@required String ?email,}){
    emit(ForgotLoadingState());
    DioHelper.PostData(
        url:userType=='client'?FORGOTPASSWORD_CLIENT:FORGOTPASSWORD_LAWER,
        data: {
          'email':email
        }
    ).then((value) {
      emit(ForgotSuccessState());
      print(value.data);
    }).catchError((onError){
      emit(ForgotErrorState());
      print(onError);
    });

  }

  void checkCodeSent({@required String ? userType,@required String ?email,@required String ? code,}){
    emit(ForgotLoadingState());
    DioHelper.PostData(
        url:userType=='client'?CHECKCODE_CLIENT:CHECKCODE_LAWER,
        data: {
          'email':email,
          'code':code,
        }
    ).then((value) {
      emit(ForgotSuccessState());
      tokenPassword=value.data['token'];
      print(tokenPassword);
      print(value.data);
    }).catchError((onError){
      emit(ForgotErrorState());
      print(onError);
    });

  }

  void newPassword({@required String ? userType,@required String ?email,@ required String ? token,@required String? newPassword,@required String ? conNewPassword}){
    emit(ForgotLoadingState());
    DioHelper.PostData(
        url: '/api/password/reset/'+token!+'?user_type=client',
        data: {
          'email':email,
          'new_password':newPassword,
          'new_password_confirmation':conNewPassword,
        }
    ).then((value) {
      emit(ForgotSuccessState());
      print(value.data);
    }).catchError((onError){
      emit(ForgotErrorState());
      print(onError);
    });
  }
}