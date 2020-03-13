import 'package:flutter/material.dart';
import 'package:helloflutter/demo/FadeAnimationDemo.dart';
import 'package:helloflutter/plugin/_MyTestPlugin.dart';

import 'demo/StartUp.dart';

void main() => runApp(StartUpApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hello Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  _MyHomePageState():super() {
    print("Constructor");
  }

  @override
  void initState(){
    super.initState();
    print("initState");
    WidgetsBinding.instance.addObserver(this);//注册监听器

    WidgetsBinding.instance.addPostFrameCallback((_){
      print("单次Frame绘制回调");//只回调一次
    });

    WidgetsBinding.instance.addPersistentFrameCallback((_){
      print("实时Frame绘制回调");//每帧都回调
    });
  }

  ///resumed：可见的，并能响应用户的输入。
  ///inactive：处在不活动状态，无法处理用户响应。
  ///paused：不可见并不能响应用户的输入，但是在后台继续活动中。
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print("$state");
    if (state == AppLifecycleState.resumed) {
      //do sth
    }else if(state == AppLifecycleState.paused){

    }else if(state == AppLifecycleState.inactive){

    }
  }
  @override
  void setState(fn) {
    super.setState(fn);
    print("setState $fn");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    WidgetsBinding.instance.removeObserver(this);//移除监听器
  }
}
