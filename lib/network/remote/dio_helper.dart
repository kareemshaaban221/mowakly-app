



import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{

  static Dio? dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl:'https://3481-197-43-91-94.ngrok.io',
        receiveDataWhenStatusError: true,
        headers:{
          'Content-Type':'application/json'
        }
      )
    );
  }

  static Future<Response>PostData({
    @required String ?url,
    @required Map<String,dynamic> ?data,
    Map<String,dynamic>? query
})async{
    return await dio!.post(
    url!,
    data: data!,
    queryParameters: query,
    );
}

static Future<Response>GetData({
  @required String ?url,
  Map<String,dynamic>? query,
})async{
     return await dio!.get(
       url!,
       queryParameters: query?? null,
     );
}

}