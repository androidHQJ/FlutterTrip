import 'package:flutter/material.dart';
import 'package:helloflutter/utils/http/api_repository.dart';
import '../model/article.dart';

class ArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticlePageState();
  }
}

class _ArticlePageState extends State<ArticlePage> {
  List<Article> _list = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {//如果需要展示进度条，就必须try/catch捕获请求异常。
    showLoading();
    try {
      var list = await ApiRepository.articleList();
      setState(() {
        _list = list;
      });
    } catch (e) {}
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (ctx, index) {
                return Text(_list[index].articleTitle);
              })),
    );
  }

  void showLoading() {}

  void hideLoading() {}
}
