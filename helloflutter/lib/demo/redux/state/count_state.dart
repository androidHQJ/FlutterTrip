///第一步：创建State
///状态是由reducer生成并储存在Store里面的。
///Store更新状态的时候，并不是更改原来的状态对象，
///而是直接将reducer生成的新的状态对象替换掉老的状态对象。
///所以，我们的状态应该是immutable的。

import 'package:meta/meta.dart';

///State中所有属性都应该是只读的
@immutable
// ignore: must_be_immutable
class CountState{
    final int _count;
    int get count => _count;

    CountState(this._count);

    ///在应用打开时要先初始化一次应用的状态。
    ///所以在State中添加一个初始化的函数。
    CountState.initState():_count=0;

}

///第二步：创建action
///定义操作该State的全部Action
///这里只有增加count一个动作
enum StateAction {increment}

///第三步：创建reducer
///reducer会根据传进来的action生成新的CountState
///reducer是我们的状态生成器，
///它接收一个我们原来的状态，然后接收一个action，再匹配这个action生成一个新的状态。
CountState reducer(CountState countState,action){
  //匹配Action
  if(action==StateAction.increment){
    return CountState(countState._count+1);
  }
  return countState;
}

