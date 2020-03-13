import 'package:flutter/material.dart';
import 'package:helloflutter/demo/bloc/scoped/blocs/bloc_provider.dart';
import 'package:helloflutter/demo/bloc/scoped/blocs/count_bloc.dart';
import 'package:helloflutter/demo/bloc/scoped/pages/under_page.dart';
///第三步：在页面中使用StreamBuilder
///
class TopPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final bloc=BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Top Page"),
      ),
      body: Center(
        child: _streamBuilder(bloc),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: ()=>
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UnderPage())),
      ),
    );
  }

  Widget _streamBuilder(CountBLoC bloc) {
    return StreamBuilder<int>(
      ///StreamBuilder中stream参数代表了这个stream builder监听的流，
      ///我们这里监听的是countBloc的value（它是一个stream）。
      stream: bloc.stream,
      ///initData代表初始的值，因为当这个控件首次渲染的时候，还未与用户产生交互，
      ///也就不会有事件从流中流出。
      ///所以需要给首次渲染一个初始值。
      initialData: bloc.value,
      ///builder函数接收一个位置参数BuildContext 以及一个snapshot。
      ///snapshot就是这个流输出的数据的一个快照。
      ///我们可以通过snapshot.data访问快照中的数据。
      ///也可以通过snapshot.hasError判断是否有异常，并通过snapshot.error获取这个异常。
      builder:(BuildContext context,AsyncSnapshot<int> snapshot){
        ///StreamBuilder中的builder是一个AsyncWidgetBuilder，
        ///它能够异步构建widget，当检测到有数据从流中流出时，将会重新构建。
        return Text(
          "You hit me:${snapshot.data} times",
          style: Theme.of(context).textTheme.display1,
        );
      },
    );
  }

}