import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/shared/network/endpoints.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String lang ='ar',
    String token,
  }) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'authorization': token,
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang ='ar',
    String token,
  }) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'authorization': token,
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

}