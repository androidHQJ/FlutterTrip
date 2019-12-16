import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter List Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('ListView')),
//        body: _listView(),
//        body: _listViewDirection(),
//        body: _listView2(),
        body: _listViewSeparated(),
      );

  Widget _listView() {
    return ListView(children: <Widget>[
      //设置ListTile组件的标题与图标
      ListTile(leading: Icon(Icons.map), title: Text('Map')),
      ListTile(leading: Icon(Icons.mail), title: Text('Mail')),
      ListTile(leading: Icon(Icons.message), title: Text('Message')),
    ]);
  }

  Widget _listView2() {
    return ListView.builder(
        itemCount: 100, //元素个数
        ///指定 itemExtent 比让子 Widget 自己决定自身高度会更高效
//        itemExtent: 40.0, //列表项高度
        itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text("title $index"),
            subtitle: Text("body $index")));
  }

  ///使用ListView.separated设置分割线
  Widget _listViewSeparated() {
    return ListView.separated(
        itemCount: 100,
        separatorBuilder: (BuildContext context, int index) => index % 2 == 0
            ? Divider(color: Colors.green,thickness:10,indent: 10,endIndent: 10,)
            : Divider(color: Colors.red), //index为偶数，创建绿色分割线；index为奇数，则创建红色分割线
        itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text("title $index"),
            subtitle: Text("body $index")),//创建子Widget
        );
  }

  Widget _listViewDirection() {
    return ListView(
        scrollDirection: Axis.horizontal,
        itemExtent: 140, //item延展尺寸(宽度)
        children: <Widget>[
          Container(color: Colors.black),
          Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.green),
          Container(color: Colors.yellow),
          Container(color: Colors.orange),
        ]);
  }
}
