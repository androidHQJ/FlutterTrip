import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Page1.dart';

void main() {
  ///一般来说跟文字排版中的baseline和decent有关系，
  /// 你可以设置下面的属性把border都画出来看看问题出在哪儿
  debugPaintLayerBordersEnabled=true;
  debugPaintBaselinesEnabled=true;

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'lifecycle demo',
        theme: ThemeData(
            primaryColor: Colors.blue
        ),
      home: Page1(),
    );
  }
}