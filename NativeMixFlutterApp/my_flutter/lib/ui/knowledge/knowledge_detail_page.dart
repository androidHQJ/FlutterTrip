import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroid/model/article.dart';
import 'package:wanandroid/model/base_list_data.dart';
import 'package:wanandroid/model/knowledge_system.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/widget/article_widget.dart';
import 'package:wanandroid/widget/custom_refresh.dart';
import 'package:wanandroid/widget/page_widget.dart';
import 'package:wanandroid/widget/titlebar.dart';

class knowledgeDetailPage extends StatefulWidget {
  KnowledgeSystem knowledge;

  knowledgeDetailPage({@required this.knowledge});

  @override
  State<StatefulWidget> createState() {
    return _knowledgeDetailPageState();
  }
}

class _knowledgeDetailPageState extends State<knowledgeDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        length: widget.knowledge.children.length, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        isShowBack: true,
        title: widget.knowledge.name,
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            indicatorColor: ColorConst.color_primary,
            controller: _controller,
            isScrollable: true,
            tabs: _parseTabs(),
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              controller: _controller,
              children: _parsePages(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _parseTabs() {
    List<Widget> widgets = List();
    var children = widget.knowledge.children;
    for (KnowledgeSystem item in children) {
      var tab = Tab(
        text: item.name,
      );
      widgets.add(tab);
    }
    return widgets;
  }

  List<knowledgeArticlePage> _parsePages() {
    List<knowledgeArticlePage> pages = List();
    var children = widget.knowledge.children;
    for (KnowledgeSystem item in children) {
      var page = knowledgeArticlePage(cid: item.id);
      pages.add(page);
    }
    return pages;
  }
}

class knowledgeArticlePage extends StatefulWidget {
  int cid;

  knowledgeArticlePage({@required this.cid});

  @override
  State<StatefulWidget> createState() {
    return _knowledgeArticlePageState();
  }
}

class _knowledgeArticlePageState extends State<knowledgeArticlePage>
    with AutomaticKeepAliveClientMixin {
  int pageIndex = 0;
  List<Article> articles = List();
  PageStateController _pageStateController;

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

  void getList(bool isRefresh) {
    DioManager.singleton
        .get("article/list/${pageIndex}/json?cid=${widget.cid}")
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
          //_refreshController.sendBack(false, RefreshStatus.noMore);
        }
        setState(() {
          articles.addAll(Article.parseList(listdata.datas));
        });
      }else{
        _pageStateController.changeState(PageState.LoadFail);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      reload: (){
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
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleWidget(articles[index]);
              })),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
