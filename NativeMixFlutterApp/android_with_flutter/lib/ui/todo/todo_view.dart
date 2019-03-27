import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:android_with_flutter/ui/todo/add_todo_page.dart';
import 'package:android_with_flutter/ui/todo/todo_action.dart';
import 'package:android_with_flutter/ui/todo/todo_state.dart';
import 'package:android_with_flutter/utils/color.dart';
import 'package:android_with_flutter/utils/common.dart';
import 'package:android_with_flutter/widget/custom_refresh.dart';
import 'package:android_with_flutter/widget/page_widget.dart';
import 'package:android_with_flutter/widget/titlebar.dart';

Widget buildView(TodoState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter todoAdapter = viewService.buildAdapter();
  return Scaffold(
    appBar: TitleBar(
      isShowBack: true,
      title: "TODO",
      rightButtons: <Widget>[
        TitleBar.iconButton(
            icon: Icons.add,
            color: ColorConst.color_white,
            press: () {
              CommonUtils.push(
                      viewService.context, AddTodoPage().buildPage(null))
                  .then((value) {
                if (value == "yes") {
                  dispatch(TodoActionCreator.onRefreshAction());
                }
              });
            })
      ],
    ),
    body: PageWidget(
        controller: state.pageStateController,
        reload: () {
          dispatch(TodoActionCreator.onRefreshAction());
        },
        child: CustomRefresh(
          easyRefreshKey: state.easyRefreshKey,
          onRefresh: () {
            dispatch(TodoActionCreator.onRefreshAction());
          },
          loadMore: () {
            dispatch(TodoActionCreator.onLoadMoreAction());
          },
          child: ListView.builder(
              itemBuilder: todoAdapter.itemBuilder,
              itemCount: todoAdapter.itemCount),
        )),
  );
}
