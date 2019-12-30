import 'dart:async';
import 'package:helloflutter/model/article.dart';
import 'package:helloflutter/utils/http/httpmanager.dart';

///请求封装

class ApiRepository {
    static Future<List<Article>> articleList() async{
      var data = await HttpManager.get("articleList", {"page":1});
      return data["result"].map((Map<String,dynamic> json){
        return Article.fromJson(json);
      });
    }
}