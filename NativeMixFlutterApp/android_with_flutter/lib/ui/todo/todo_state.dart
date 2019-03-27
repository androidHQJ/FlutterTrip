import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:android_with_flutter/model/todo.dart';
import 'package:android_with_flutter/widget/page_widget.dart';

class TodoState implements Cloneable<TodoState> {
  PageStateController pageStateController;
  GlobalKey<EasyRefreshState> easyRefreshKey;

  var pageIndex = 1;
  List<Todo> todos = [];

  @override
  TodoState clone() {
    return TodoState()
      ..pageStateController = pageStateController
      ..easyRefreshKey = easyRefreshKey
      ..pageIndex = pageIndex
      ..todos = todos;
  }
}

TodoState initState(Map<String, dynamic> args) {
  var state = TodoState();
  state.pageStateController = PageStateController();
  state.easyRefreshKey = GlobalKey<EasyRefreshState>();
  return state;
}
