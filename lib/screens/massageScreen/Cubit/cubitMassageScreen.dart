
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fp/network/models/models.dart';
import 'package:fp/network/remote/dio_helper.dart';
import 'package:fp/screens/chatbotScreen/chat_model.dart';
import 'package:fp/screens/massageScreen/Cubit/statesCubit.dart';
import 'package:fp/screens/massageScreen/chatModel.dart';

class MassageCubit extends Cubit<MassageStates>{
  MassageCubit():super(MassageInitialState());

  static MassageCubit get(context)=>BlocProvider.of(context);


   Future? geAllMassage({@required int ?id})async{
    emit(MassageLoadingState());
    await DioHelper.GetData(url: '/api/chat/$id?user_type=client',tokien: 'Bearer ${loginmodel!.token}').then((value){
      print(value.data);
      chatData=ChatData.fromJson(value.data);
      chat=[];
      chatWho=[];
      chatData?.data?.forEach((element) {
        chat.add( element['message']);
        chatWho.add(element['context']);
      });
      emit(MassageSuccessState());
      print(chat);
      print(chatWho);

    }).onError((error, stackTrace){
      emit(MassageErrorState());
      print(error);
    });
  }

  void sendMassage({@required int ?id,@required String? message,})async{
     emit(MassageLoadingState());
   await DioHelper.PostData(
         tokien: 'Bearer ${loginmodel!.token}',
         url: '/api/chat/$id?user_type=client',
         data: {
           'message':message
         }
     ).then((value){

       chat.add(message);
       chatWho.add('me');
       emit(MassageSuccessState());
     }).onError((error, stackTrace) {
       print(error);
       emit(MassageErrorState());
     });
  }
  
  void getMessageLawyers()async{
    emit(MassageLoadingState());
    await DioHelper.GetData(url: '/api/consultations?user_type=client',tokien: 'Bearer ${loginmodel!.token}').then((value) {
      lawyerForUser=value.data['data'][0]['lawyer'];
      print(lawyerForUser);
      emit(MassageSuccessState());
    }).onError((error, stackTrace) {
      print(error);
      emit(MassageErrorState());

    });
  }

  void getMessageClients()async{
     emit(MassageLoadingState());
     await DioHelper.GetData(url: '/api/lawyer/consultations?user_type=lawyer',tokien: 'Bearer ${loginmodel!.token}').then((value) {
       clientForLawyer=value.data['data'][0]['client'];
       print(clientForLawyer);
       emit(MassageSuccessState());
     }).onError((error, stackTrace) {
       print(error);
       emit(MassageErrorState());

     });
  }

  Future? geAllMassageLawyer({@required int ?id})async{
    emit(MassageLoadingState());
    await DioHelper.GetData(url: '/api/lawyer/chat/$id?user_type=lawyer',tokien: 'Bearer ${loginmodel!.token}').then((value){
      print(value.data);
      chatData=ChatData.fromJson(value.data);
      chat=[];
      chatWho=[];
      chatData?.data?.forEach((element) {
        chat.add( element['message']);
        chatWho.add(element['context']);
      });
      emit(MassageSuccessState());
      print(chat);
      print(chatWho);

    }).onError((error, stackTrace){
      emit(MassageErrorState());
      print(error);
    });
  }

  void sendMassageLawyer({@required int ?id,@required String? message,})async{
    emit(MassageLoadingState());
    await DioHelper.PostData(
        tokien: 'Bearer ${loginmodel!.token}',
        url: '/api/lawyer/chat/$id?user_type=lawyer',
        data: {
          'message':message
        }
    ).then((value){

      chat.add(message);
      chatWho.add('me');
      emit(MassageSuccessState());
    }).onError((error, stackTrace) {
      print(error);
      emit(MassageErrorState());
    });
  }
}