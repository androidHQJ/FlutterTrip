import 'package:fish_redux/fish_redux.dart';
import 'package:android_with_flutter/model/todo.dart';
import 'package:android_with_flutter/ui/todo/add_todo_effect.dart';
import 'package:android_with_flutter/ui/todo/add_todo_state.dart';
import 'add_todo_view.dart';

class AddTodoPage extends Page<AddTodoState, Todo> {
  AddTodoPage()
      : super(initState: initState, view: buildView, effect: buildEffect());
}
