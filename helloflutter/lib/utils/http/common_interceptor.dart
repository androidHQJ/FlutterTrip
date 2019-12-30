import 'package:dio/dio.dart';
import 'package:helloflutter/model/constants.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

//通用拦截器
class CommonInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    options.queryParameters = options.queryParameters ?? {};
    options.queryParameters["app_id"] = "1001";
    var pref = await SharedPreferences.getInstance();
    options.queryParameters["user_id"] = pref.get(Constants.keyLoginUserId);
    options.queryParameters["device_id"] = pref.get(Constants.keyDeviceId);
    return super.onRequest(options);
  }
}
