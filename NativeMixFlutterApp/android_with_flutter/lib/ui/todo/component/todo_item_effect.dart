import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:android_with_flutter/generated/i18n.dart';
import 'package:android_with_flutter/model/todo.dart';
import 'package:android_with_flutter/net/dio_manager.dart';
import 'package:android_with_flutter/ui/todo/component/todo_item_action.dart';
import 'package:android_with_flutter/ui/todo/todo_action.dart';
import 'package:android_with_flutter/utils/color.dart';
import 'package:android_with_flutter/utils/common.dart';

Effect<Todo> buildEffect() {
  return combineEffects(<Object, Effect<Todo>>{
    TodoItemAction.onCheck: _onCheck,
    TodoAction.onDelete: _onDelete,
  });
}

void _onCheck(Action action, Context<Todo> ctx) {
  bool payload = action.payload;
  CommonUtils.showLoadingDialog(ctx.context);
  DioManager.singleton
      .post("lg/todo/done/${ctx.state.id}/json",
          data: FormData.from({"status": payload ? 1 : 0}))
      .whenComplete(() {
    Navigator.pop(ctx.context);
  }).then((result) {
    if (result != null) {
      ctx.dispatch(TodoItemCreator.check(ctx.state.id));
    }
  });
}

void _onDelete(Action action, Context<Todo> ctx) {
  CommonUtils.showCommitOptionDialog(
      ctx.context,
      S.of(ctx.context).prompt,
      S.of(ctx.context).delete_prompt,
      [S.of(ctx.context).ok, S.of(ctx.context).cancel], (index) {
    if (index == 0) {
      CommonUtils.showLoadingDialog(ctx.context);
      DioManager.singleton
          .post("lg/todo/delete/${ctx.state.id}/json")
          .whenComplete(() {
        Navigator.pop(ctx.context);
      }).then((result) {
        if (result != null) {
          ctx.dispatch(TodoActionCreator.deleteAction(ctx.state));
        }
      });
    }
  }, bgColorList: [Colors.black26, ColorConst.color_primary]);
}
