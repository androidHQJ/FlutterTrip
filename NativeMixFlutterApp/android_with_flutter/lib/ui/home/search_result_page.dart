import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:android_with_flutter/model/article.dart';
import 'package:android_with_flutter/model/base_list_data.dart';
import 'package:android_with_flutter/net/dio_manager.dart';
import 'package:android_with_flutter/widget/article_widget.dart';
import 'package:android_with_flutter/widget/custom_refresh.dart';
import 'package:android_with_flutter/widget/page_widget.dart';
import 'package:android_with_flutter/widget/titlebar.dart';

class SearchResultPage extends StatefulWidget {
  String keyWord = "";

  SearchResultPage(this.keyWord);

  @override
  State<StatefulWidget> createState() {
    return _SearchResultPageState();
  }
}

class _SearchResultPageState extends State<SearchResultPage> {
  int pageIndex = 0;
  List<Article> articles = List();
  PageStateController _pageStateController;
  ScrollController _scrollController;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pageStateController = PageStateController();
    getList(true);
  }

  void _onRefresh(bool up) {
    if (up) {
      pageIndex = 0;
      getList(true);
    } else {
      pageIndex++;
      getList(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: widget.keyWord,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor.withAlpha(180),
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            _scrollController.animateTo(0,
                duration: Duration(milliseconds: 1000), curve: Curves.linear);
          }),
      body: PageWidget(
        reload: () {
          getList(true);
        },
        controller: _pageStateController,
        child: CustomRefresh(
            easyRefreshKey: _easyRefreshKey,
            onRefresh: () {
              _onRefresh(true);
            },
            loadMore: () {
              _onRefresh(false);
            },
            child: ListView.builder(
                controller: _scrollController,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticleWidget(articles[index]);
                })),
      ),
    );
  }

  void getList(bool isRefresh) {
    DioManager.singleton
        .post("article/query/${pageIndex}/json",
            data: FormData.from({
              "k": widget.keyWord,
            }))
        .then((result) {
      _easyRefreshKey.currentState.callRefreshFinish();
      _easyRefreshKey.currentState.callLoadMoreFinish();
      if (result != null) {
        _pageStateController.changeState(PageState.LoadSuccess);
        var listdata = BaseListData.fromJson(result.data);
        print(listdata.toString());
        if (pageIndex == 0) {
          articles.clear();
        }
        if (listdata.hasNoMore) {
          // _refreshController.sendBack(false, RefreshStatus.noMore);
        }
        setState(() {
          articles.addAll(Article.parseList(listdata.datas));
        });
      } else {
        _pageStateController.changeState(PageState.LoadFail);
      }
    });
  }
}
