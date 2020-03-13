import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:helloflutter/demo/redux/pages/under_screen.dart';
import 'package:helloflutter/demo/redux/state/count_state.dart';

class TopScreen extends StatefulWidget{

  @override
  _TopScreenState createState() => _TopScreenState();

}

class _TopScreenState extends State<TopScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar:AppBar(
        title: new Text("Top Screen"),
      ),
      body: Center(
        child: _storeConnector(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context){
                  return UnderScreen();
                }
            ));
          },
        child: Icon(Icons.forward),
      ),
    );
  }

  ///在子页面中获取Store中的state
  ///要想获取store我们需要使用StoreConnector<S,ViewModel>。
  ///StoreConnector能够通过StoreProvider找到顶层的store。
  ///而且能够在state发生变化时rebuilt Widget。
  Widget _storeConnector(){
    ///首先这里需要强制声明类型，
    ///S代表我们需要从store中获取什么类型的state，
    ///ViewModel指的是我们使用这个State时的实际类型。
    return StoreConnector<CountState,int>(
      ///当我们ViewModel很复杂的时候，
      ///我们可以使用StoreConnector的distinct属性进行性能优化。
      distinct: true,
      ///然后我们需要声明一个converter<S,ViewModel>，
      ///它的作用是将Store转化成实际ViewModel将要使用的信息，
      ///比如我们这里实际上要使用的是count，所以这里将count提取出来。
      converter: (store) {
          return store.state.count;
      },
      ///builder是我们实际根据state创建Widget的地方，
      ///它接收一个上下文context，以及刚才我们转化出来的ViewModel，
      ///所以我们就只需要把拿到的count放进Text Widget中进行渲染就好了。
      builder: (context,count){
        return Text(
          count.toString(),
          style: Theme.of(context).textTheme.display1,
        );
      },
    );
  }

}