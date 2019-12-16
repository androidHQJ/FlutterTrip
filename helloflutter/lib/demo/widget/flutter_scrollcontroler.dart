import 'package:flutter/material.dart';

///问1：在 ListView.builder 方法中，ListView 根据 Widget 是否将要出现在可视区域内，按需创建。
/// 对于一些场景，为了避免 Widget 渲染时间过长（比如图片下载），
/// 我们需要提前将可视区域上下一定区域内的 Widget 提前创建好。那么，在 Flutter 中，如何才能实现呢？
///答：预加载：使用cacheExtent
///问2：使用 NotificationListener，来实现 ScrollController 示例中同样的功能？
///答：double offsetY = scrollNotification.metrics.pixels;滚动过程中通过偏移量更改isTop即可。
///
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  => MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.lightBlue[800],//主题色为蓝色
    ),
    home: MyHomePage(title: 'Custom UI'),
  );

}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            ParallelWidget(),
            ScrollNotificationWidget(),
            ScrollControllerWidget(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home),text: "视差",),
            Tab(icon: Icon(Icons.rss_feed),text: "Notification",),
            Tab(icon: Icon(Icons.perm_identity),text: "Controller",)
          ],
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}

///封面头图和列表这两层视图的滚动联动起来，
/// 当用户滚动列表时，头图会根据用户的滚动手势，进行缩小和展开
class ParallelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(//SliverAppBar 作为头图控件
              title: Text('CustomScrollView Demo'),// 标题
              floating: true,// 设置悬浮样式
              flexibleSpace: Image.network("https://media-cdn.tripadvisor.com/media/photo-s/13/98/8f/c2/great-wall-hiking-tours.jpg",fit:BoxFit.cover),// 设置悬浮头图背景
              expandedHeight: 280,// 头图控件高度
            ),
            SliverList(//SliverList 作为列表控件
              delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(title: Text('Item #$index')),// 列表项创建方法
                childCount: 100,// 列表元素个数
              ),
            ),
          ]);
  }

}


///如何获取 ScrollNotification 通知，从而感知 ListView 的各类滚动事件。
///ScrollNotification 通知的获取是通过 NotificationListener 来实现的。
/// 与 ScrollController 不同的是，NotificationListener 是一个 Widget，
/// 为了监听滚动类型的事件，我们需要将 NotificationListener 添加为 ListView 的父容器，
/// 从而捕获 ListView 中的通知。
/// 而这些通知，需要通过 onNotification 回调函数实现监听逻辑
class ScrollNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scroll Notification Demo',
        home: Scaffold(
            appBar: AppBar(title: Text('ScrollController Demo')),
            body: NotificationListener<ScrollNotification>(// 添加 NotificationListener 作为父容器
              onNotification: (scrollNotification) {// 注册通知回调

                ///滚动过程中通过偏移量更改isTop即可。
                double offsetY = scrollNotification.metrics.pixels;

                if (scrollNotification is ScrollStartNotification) {// 滚动开始
                  print('Scroll Start');
                } else if (scrollNotification is ScrollUpdateNotification) {// 滚动位置更新
                  print('Scroll Update');
                } else if (scrollNotification is ScrollEndNotification) {// 滚动结束
                  print('Scroll End');
                }
                return true;
              },
              child: ListView.builder(
                itemCount: 30,// 列表元素个数
                itemBuilder: (context, index) => ListTile(title: Text("Index : $index")),// 列表项创建方法
              ),
            )
        )
    );
  }
}

///ListView 的组件控制器则是 ScrollControler，
/// 我们可以通过它来获取视图的滚动信息，更新视图的滚动位置。

///一般而言，获取视图的滚动信息往往是为了进行界面的状态控制，
/// 因此 ScrollController 的初始化、监听及销毁需要与 StatefulWidget 的状态保持同步。
class ScrollControllerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=> _ScrollControllerState();
}

class _ScrollControllerState extends State<ScrollControllerWidget> {
  ScrollController _controller;//ListView 控制器
  bool isToTop = false;// 标示目前是否需要启用 "Top" 按钮
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {// 为控制器注册滚动监听方法
      if(_controller.offset > 1000) {// 如果 ListView 已经向下滚动了 1000，则启用 Top 按钮
        setState(() {isToTop = true;});
      } else if(_controller.offset < 300) {// 如果 ListView 向下滚动距离不足 300，则禁用 Top 按钮
        setState(() {isToTop = false;});
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scroll Controller Widget")),
      body: Column(
        children: <Widget>[
          Container(
            height: 40.0,
            child: RaisedButton(onPressed: (isToTop ? () {
              if (isToTop) {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease
                ); // 做一个滚动到顶部的动画
              }
            } : null), child: Text("Top"),),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller, // 初始化传入控制器
              itemCount: 100, // 列表元素总数
              itemBuilder: (context, index) =>
                  ListTile(title: Text("Index : $index")), // 列表项构造方法
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose(); // 销毁控制器
    super.dispose();
  }
}