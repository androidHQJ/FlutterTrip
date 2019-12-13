import 'package:flutter/material.dart';
import 'Page1.dart';

void main() => runApp(MyApp());

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