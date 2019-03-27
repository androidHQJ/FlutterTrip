import 'package:fish_redux/fish_redux.dart';
import 'package:android_with_flutter/ui/todo/component/todo_adapter.dart';
import 'package:android_with_flutter/ui/todo/todo_effect.dart';
import 'package:android_with_flutter/ui/todo/todo_reducer.dart';
import 'package:android_with_flutter/ui/todo/todo_state.dart';
import 'package:android_with_flutter/ui/todo/todo_view.dart';

class TodoPage extends Page<TodoState, Map<String, dynamic>> {
  TodoPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TodoState>(adapter: TodoAdapter()));
}
