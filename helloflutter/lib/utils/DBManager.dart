import 'package:helloflutter/model/article.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DBManager {
  static const int _VSERION = 1;
  static const String _DB_NAME = "database.db";
  static Database _db;
  static const String TABLE_NAME = "t_article";
  static const String createTableSql = '''
    create table $TABLE_NAME(
        article_id int,
        article_title text,
        article_link text,
        user_id int,
        primary key(article_id,user_id)
    );
  ''';

  static init() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, _DB_NAME);
    _db = await openDatabase(path, version: _VSERION, onCreate: _onCreate);
  }

  static _onCreate(Database db, int newVersion) async {
    await db.execute(createTableSql);
  }

  static Future<int> insertArticle(Article item, int userId) async {
    var map = item.toMap();
    map["user_id"] = userId;
    return _db.insert("$TABLE_NAME", map);
  }
}
