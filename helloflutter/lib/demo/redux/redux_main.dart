import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:helloflutter/demo/redux/pages/top_screen.dart';
import 'package:helloflutter/demo/redux/state/count_state.dart';
import 'package:redux/redux.dart';

void main() {
  ///第四步：创建store
  ///Store接收一个reducer，以及初始化State，
  ///我们想用Redux管理全局的状态的话，需要将store储存在应用的入口才行
  final store=Store<CountState>(
      reducer,
      initialState: CountState.initState()
  );
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget{
  final Store<CountState> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    ///第五步：将Store放入顶层
    ///flutter_redux提供了一个很棒的widget叫做StoreProvider，
    ///它的用法也很简单，接收一个store，和child Widget。
    return StoreProvider<CountState>(
      store: store,
      child: new MaterialApp(
        title: "Redux Demo",
        theme: new ThemeData(
          primarySwatch: Colors.blue
        ),
        home: TopScreen(),
      ),
    );
  }

}