import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'simple_page_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //将原生的flutter页面注册到flutterboost:以key,value的形式，其中key就是页面名，value就是目标flutter页面
    FlutterBoost.singleton.registerPageBuilders({
      'firstFlutter': (pageName, params, _) => FirstRouteWidget(),
      'secondFlutter': (pageName, params, _) => SecondRouteWidget(),
      'flutterFragment': (pageName, params, _) => FragmentRouteWidget(params),

      ///可以在native层通过 getContainerParams 来传递参数
      'flutterPage': (pageName, params, _) {
        print("flutterPage params:$params");
        return FlutterRouteWidget();
      },
    });

    ///query current top page and load it
    FlutterBoost.handleOnStartPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: "Flutter Boost demo",
      builder: FlutterBoost.init(),//初始化FlutterBoost
      home: Container(),      
    );
  }
}
