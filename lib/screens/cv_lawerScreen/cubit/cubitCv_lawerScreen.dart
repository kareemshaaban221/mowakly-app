
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/network/end_point.dart';
import 'package:fp/network/remote/dio_helper.dart';
import 'package:fp/screens/cv_lawerScreen/cubit/statesCubit.dart';

class Cv_lawerCubit extends Cubit<Cv_lawerStates>{


  Cv_lawerCubit():super(InitialState());

  static Cv_lawerCubit get(context)=>BlocProvider.of(context);

  void showCategories(){

    emit(LoadingState());
    DioHelper.GetData(url: SHOW_CATEGORIES).then((value){
      emit(SuccessState());
      print(value);
    }).catchError((onError){
      emit(ErrorState());
      print(onError);
    });

  }

}