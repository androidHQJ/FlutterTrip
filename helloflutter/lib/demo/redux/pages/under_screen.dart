import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:helloflutter/demo/redux/state/count_state.dart';

class UnderScreen extends StatefulWidget{
  @override
  _UnderScreenState createState() {
    // TODO: implement createState
    return _UnderScreenState();
  }

}

class _UnderScreenState extends State<UnderScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Under Screen"),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            _storeConnector()
          ],
        ),
      ),
      floatingActionButton: _storeConnectorButton(),
    );
  }

  Widget _storeConnector(){
    return StoreConnector<CountState,int>(
      ///当我们ViewModel很复杂的时候，
      ///我们可以使用StoreConnector的distinct属性进行性能优化。
      distinct: true,
      converter: (store)=> store.state.count,
      builder: (context,count){
        return Text(
          count.toString(),
          style: Theme.of(context).textTheme.display1,
        );
      },
    );
  }

  ///通过点击floatingActionButton发出了action，并通知reducer生成了新的状态。
  Widget _storeConnectorButton(){
    ///这里由于是发出了一个动作，所以是VoidCallback
    return StoreConnector<CountState,VoidCallback>(
      converter: (store){
        ///store.dispatch发起一个action，任何中间件都会拦截该操作,
        ///在运行中间件后，操作将被发送到给定的reducer生成新的状态，并更新状态树。
        return()=>store.dispatch(StateAction.increment);
      },
      builder: (context,callBack){
        return FloatingActionButton(
          onPressed: callBack,
          child: Icon(Icons.add),
        );
      },
    );
  }
}