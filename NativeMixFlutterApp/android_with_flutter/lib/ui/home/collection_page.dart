import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:android_with_flutter/generated/i18n.dart';
import 'package:android_with_flutter/model/article.dart';
import 'package:android_with_flutter/model/base_list_data.dart';
import 'package:android_with_flutter/net/dio_manager.dart';
import 'package:android_with_flutter/widget/collection_article_widget.dart';
import 'package:android_with_flutter/widget/custom_refresh.dart';
import 'package:android_with_flutter/widget/page_widget.dart';
import 'package:android_with_flutter/widget/titlebar.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CollectionPageState();
  }
}

class _CollectionPageState extends State<CollectionPage> {
  PageStateController _pageStateController;
  List<Article> articles = List();
  int pageIndex = 0;

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  @override
  void initState() {
    super.initState();
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
        isShowBack: true,
        title: S.of(context).my_collection,
      ),
      body: PageWidget(
        controller: _pageStateController,
        reload: () {
          getList(true);
        },
        child: CustomRefresh(
            easyRefreshKey: _easyRefreshKey,
            onRefresh: () {
              _onRefresh(true);
            },
            loadMore: () {
              _onRefresh(false);
            },
            child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return CollectionArticleWidget(articles[index]);
                })),
      ),
    );
  }

  void getList(bool isRefresh) {
    DioManager.singleton
        .get("lg/collect/list/${pageIndex}/json")
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
