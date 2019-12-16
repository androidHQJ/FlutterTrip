import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter CustomScrollView Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('CustomScrollView')),
      body: _customScrollView());

  ///封面头图和列表这两层视图的滚动联动起来，
  /// 当用户滚动列表时，头图会根据用户的滚动手势，进行缩小和展开
  Widget _customScrollView() {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        //SliverAppBar作为头图控件
        title: Text('CustomScrollView Demo'),
        //标题
//        floating: true,
        //设置悬浮样式
        flexibleSpace: Image.network(
            'https://upload-images.jianshu.io/upload_images/5361063-0d454e7147744315.jpeg?'
                'imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp',
            fit: BoxFit.cover),
        //设置悬浮头图背景
        expandedHeight: 300, //头图控件高度
      ),
      SliverList(
        //SliverList作为列表控件
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(title: Text('Item #$index')),
          //列表项创建方法
          childCount: 100, //列表元素个数
        ),
      ),
    ]);
    ;
  }
}
