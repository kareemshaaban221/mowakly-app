



import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{

  static Dio? dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl:'https://ektml.cloud/mowakly/public',
        receiveDataWhenStatusError: true,
        headers:{
          'Content-Type':'application/json'
        }
      )
    );
  }

  static Future<Response>PostData({
    @required String ?url,
    @required data,
    Map<String,dynamic>? query,
    String  ?tokien,
    //String ?tokien,
})async{
    // dio!.options=BaseOptions(headers: {
    //   'Authorization':tokien?? null
    // });
    dio!.options.headers={
      'Authorization':tokien?? null,
      'Accept':'application/json'
    };
    return await dio!.post(
    url!,
    data: data!,
    queryParameters: query,
    );
}

static Future<Response>GetData({
  @required String ?url,
  Map<String,dynamic>? query,
  String  ?tokien,
})async{
    dio!.options.headers={
      'Authorization':tokien?? null,
      'Accept':'application/json'
    };
     return await dio!.get(
       url!,
       queryParameters: query?? null,
     );
}

}