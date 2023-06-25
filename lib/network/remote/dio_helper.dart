



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
      'Accept':'application/json',
     // 'Content-Type':'application/x-www-form-urlencoded',
      //'Cookie':'XSRF-TOKEN=eyJpdiI6ImhOa0dpekI5Rkk2Vjk2dUZwYmFSQUE9PSIsInZhbHVlIjoiYm9lT2xEYVE2eGtYOXgyUUNVMG5rSlcrZjJQbmFrVVd1N2QwNVByRnJxQTg0L2tUbGlENzlkZFFEVklEdEwxM3N6SUtjcEVOQ2VQemdidWl0M0JIei9ic09CZmlib2Q4UlRQWVdEdlhpRTJLREx5TXVyNFBzcTI1WHRVcStSOHkiLCJtYWMiOiI2MmMyZjRkNTFiZWVjNjI4ZDY0N2ZmNzg1ZjMxYWI5MmQzNGI4YjkzNDg0YzU1MjhmNjcxNTg4ZTAwMDgxNzEwIiwidGFnIjoiIn0%3D; mowakly_session=eyJpdiI6Ik9WcThqSDB3TURaUEp4SDBmaXJxaUE9PSIsInZhbHVlIjoiT1RvTVdZZ2R4Q1g2eUVybE8rNGk0RTZrVmNCVERRd1FpTDA4OFJuYk1hWnM5UHIwbFpDd3MxT0ZqaS9ndE9vUzVsTGt5Y0RURU1qeUlMblluT05EMFYzdkhhbXZMM3NTY2lnRnl4dTNzQ25NdktVUXNGR2ZYMm42RWh6V1hpVVMiLCJtYWMiOiI0MTlkNTg4ODgxOGI4MjM5ZGQyMjUxMzdiZjU4NzM2NThkNGYyOWM2ZDA1MjNmZjZlYjc1OTc0MzhiMzQwMzNiIiwidGFnIjoiIn0%3D'
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