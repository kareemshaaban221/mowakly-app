// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/models/classModels.dart';
import 'package:fp/network/end_point.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/network/remote/dio_helper.dart';
import 'package:fp/screens/signupScreen/cuibt/statesCuibt.dart';

class SignupScreenCubit extends Cubit<SignupStates> {
  SignupScreenCubit() : super(SignupInitialState());
  static SignupScreenCubit get(context) => BlocProvider.of(context);
  void userSignup(
      {@required user_type,
      @required fname,
      @required email,
      @required password,
      @required password_confirmation,
      @required lname,
      @required gender,
      @required date_of_birth,
      @required phone}) {
    emit(SignupLoadingState());
    DioHelper.PostData(url: SIGNUP, data: {
      'user_type': user_type,
      'fname': fname,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'lname': lname,
      'gender': gender,
      'date_of_birth': date_of_birth,
      'phone': phone,
    }).then((value) {
      emit(SignupSuccessState());
      loginmodel=LoginModel.fromJson(value.data);

      print(loginmodel!.message.toString());
    }).catchError((onError) {
      print(onError);
      emit(SignupErrorState());
    });
  }

  Future<String> lawerSignup({
    @required user_type,
    @required fname,
    @required email,
    @required password,
    @required password_confirmation,
    @required lname,
    @required gender,
    @required date_of_birth,
    @required phones0,
    @required description,
    @required card_id,
    @required filePathCard,
    @required fileNameCard,
    @required filePathAvatar,
    @required filenameAvatar,
    @required filePathAttachment,
    @required fileNameAttaachment,
    @required phones1,
    @required national_id,
  }) async {
    emit(SignupLoadingState());

    await DioHelper.PostData(url: SIGNUPLAWER, data: {
      'fname': fname,
      'lname': lname,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'user_type': user_type,
      'gender': gender,
      'description': description,
      'date_of_birth': date_of_birth,
      'card_id': card_id,
      'card': await MultipartFile.fromFileSync(filePathCard,
          filename: fileNameCard),
      //'avatar':await MultipartFile.fromFile(filePathCard.toString(),filename: fileNameCard),
      //'attachments[0]':await MultipartFile.fromFile(filePathAttachment.toString(),filename: fileNameAttaachment),
      'phones[0]': phones0,
      'phones[1]': phones1,
      'national_id': national_id,
    }).then((value) {
      print(value.data);

      emit(SignupSuccessState());

    }).catchError((onError) {
      emit(SignupErrorState());
      print(onError);
    });
    return '';
  }

  void change() {
    emit(SignupChangeState());
  }

  void uploadImage({
    @required user_type,
    @required fname,
    @required email,
    @required password,
    @required password_confirmation,
    @required lname,
    @required gender,
    @required date_of_birth,
    @required phones0,
    @required description,
    @required card_id,
    @required filePathCard,
    @required fileNameCard,
    @required filePathAvatar,
    @required filenameAvatar,
    @required filePathAttachment,
    @required fileNameAttaachment,
    @required phones1,
    @required national_id,
  }) async {
    FormData formData = FormData.fromMap({
      'fname': fname,
      'lname': lname,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'user_type': user_type,
      'gender': gender,
      'description': description,
      'date_of_birth': date_of_birth,
      'card_id': card_id,
      'card': await MultipartFile.fromFileSync(filePathCard,
          filename: fileNameCard),
      'avatar': await MultipartFile.fromFile(filePathCard.toString(),
          filename: fileNameCard),
      'attachments[0]': await MultipartFile.fromFile(
          filePathAttachment.toString(),
          filename: fileNameAttaachment),
      'phones[0]': phones0,
      'phones[1]': phones1,
      'national_id': national_id,
    });
     await DioHelper.PostData(url: SIGNUPLAWER, data: formData)
        .then((value) {
       loginmodel=LoginModel.fromJson(value.data);
      emit(SignupSuccessState());
    }).onError((error, stackTrace){
      print(error);
      emit(SignupErrorState());
     });

  }





  Future showCategories() async {
    emit(SignupLoadingState());
    await DioHelper.GetData(url: SHOW_CATEGORIES).then((value) {
      emit(SignupSuccessState());
      for (var item in value.data) {
        categories?.add(item['name']);
        //categories!.add(item['name']);
      }
      emit(SignupSuccessState());
      print(categories);
      print(value.data);
    }).catchError((onError) {
      emit(SignupErrorState());
      print(onError);
    });
  }
}
