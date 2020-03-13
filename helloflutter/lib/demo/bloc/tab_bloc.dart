import 'package:flutter/material.dart';
import 'dart:async';
///如果我的Tabar的内容是通过网络动态获取的，
///Tabbar在构建时tabs必须要有内容，不能为空，
///那么在获取到网络的数据之前就可能引发异常（因为监听的stream没有数据），
///请问BLoC模式下如何解决这种情况？
///方案：streambuilder判断一下，数据到了在开始渲染小部件
///这里是一个参考的代码：
///解决bloc中延迟构建tab的问题
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      theme: ThemeData.light(),
      home: FirstScreen(),);
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State with SingleTickerProviderStateMixin {
  TabController _controller;
  StreamController _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, AsyncSnapshot snapshot){
        ///streambuilder判断一下是否有数据
      if (!snapshot.hasData) return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
            _streamController.sink.add(["tab1", "tab2", "tab3", "tab4", "tab5",]);
        }),
      );
      List tabTitle = snapshot.data;
      List tabs = tabTitle.map((tab) =>
          Tab(text: tab, icon: Icon(Icons.print),)).toList();
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: TabBar(
            tabs: tabs, controller: _controller,
          ),
        ),
        body: TabBarView(
        children: [
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
        ], controller: _controller,),);
    }, );
  }
}