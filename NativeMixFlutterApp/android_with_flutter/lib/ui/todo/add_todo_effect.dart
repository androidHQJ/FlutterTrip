import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:android_with_flutter/net/dio_manager.dart';
import 'package:android_with_flutter/ui/todo/add_todo_action.dart';
import 'package:android_with_flutter/ui/todo/add_todo_state.dart';
import 'package:android_with_flutter/utils/common.dart';
import 'package:android_with_flutter/utils/time.dart';

Effect<AddTodoState> buildEffect() {
  return combineEffects(<Object, Effect<AddTodoState>>{
    Lifecycle.initState: _init,
    AddTodoAction.onAdd: _onAdd,
    AddTodoAction.onEdit: _onEdit,
  });
}

void _init(Action action, Context<AddTodoState> ctx) {
  if (ctx.state.todo != null) {
    ctx.state.titleEditController.text = ctx.state.todo.title;
    ctx.state.contentEditController.text = ctx.state.todo.content;
  }
}

void _onAdd(Action action, Context<AddTodoState> ctx) {
  Map<String, String> map = action.payload;
  var data = FormData.from({
    "title": map["title"],
    "content": map["content"],
    "date": TimeUtils.getCurrentDate()
  });
  CommonUtils.showLoadingDialog(ctx.context);
  DioManager.singleton.post("lg/todo/add/json", data: data).whenComplete(() {
    Navigator.pop(ctx.context);
  }).then((result) {
    if (result != null) {
      Navigator.pop(ctx.context, "yes");
    } else {
      Fluttertoast.showToast(msg: "添加失败");
    }
  });
}

void _onEdit(Action action, Context<AddTodoState> ctx) {
  Map<String, String> map = action.payload;
  var data = FormData.from({
    "title": map["title"],
    "content": map["content"],
    "date": TimeUtils.getCurrentDate(),
    "status": ctx.state.todo.status
  });
  CommonUtils.showLoadingDialog(ctx.context);
  DioManager.singleton
      .post("lg/todo/update/${ctx.state.todo.id}/json", data: data)
      .whenComplete(() {
    Navigator.pop(ctx.context);
  }).then((result) {
    if (result != null) {
      Navigator.pop(ctx.context, "yes");
    } else {
      Fluttertoast.showToast(msg: "修改失败");
    }
  });
}
