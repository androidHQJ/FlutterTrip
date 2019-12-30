import 'dart:async';
import 'package:dio/dio.dart';
import 'common_interceptor.dart';

/*
 * 网络管理：
 * Dio封装
 */
class HttpManager {
  static HttpManager _instance;

  static HttpManager getInstance() {
    if (_instance == null) {
      _instance = HttpManager();
    }
    return _instance;
  }

  Dio dio = Dio();

  HttpManager() {
    dio.options.baseUrl = "https://api.xxx.com/";
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 5000;
    dio.interceptors.add(CommonInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  static Future<Map<String, dynamic>> get(String path, Map<String, dynamic> map) async {
    var response = await getInstance().dio.get(path, queryParameters: map);
    return processResponse(response);
  }

  /*
    表单形式
   */
  static Future<Map<String, dynamic>> post(String path, Map<String, dynamic> map) async {
    var response = await getInstance().dio.post(path,
        data: map,
        options: Options(
            contentType: "application/x-www-form-urlencoded",
            headers: {"Content-Type": "application/x-www-form-urlencoded"}));
    return processResponse(response);
  }

//  {
//  code:0,
//  msg:"获取数据成功",
//  result:[] //或者{}
//  }
  static Future<Map<String, dynamic>> processResponse(Response response) async {
    if (response.statusCode == 200) {
      var data = response.data;
      int code = data["code"];
      String msg = data["msg"];
      if (code == 0) {//请求响应成功
        return data;
      }
      throw Exception(msg);
    }
    throw Exception("server error");
  }
}