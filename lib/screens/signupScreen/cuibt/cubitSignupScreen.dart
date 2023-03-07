import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/network/end_point.dart';
import 'package:fp/network/remote/dio_helper.dart';
import 'package:fp/screens/signupScreen/cuibt/statesCuibt.dart';

class SignupScreenCubit extends Cubit<SignupStates>{

  SignupScreenCubit():super(SignupInitialState());

  static SignupScreenCubit get(context)=>BlocProvider.of(context);

  void userSignup({@required user_type,@required fname,@required email,@required password,@required password_confirmation,@required lname,@required gender,@required date_of_birth,@required phone}){
    emit(SignupLoadingState());
    DioHelper.PostData(url: SIGNUP,
        data: {'user_type':user_type,
          'fname':fname,
          'email':email,
          'password':password,
          'password_confirmation':password_confirmation,
          'lname':lname,
          'gender':gender,
          'date_of_birth': date_of_birth,
          'phone':phone,
        }).then((value) {
      print(value.data);
      emit(SignupSuccessState());
    }).catchError((onError){
      emit(SignupErrorState());
      print(onError);
    });
  }

  void change(){
    emit(SignupChangeState());
  }
}