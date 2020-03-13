import 'package:flutter/material.dart';
import 'package:helloflutter/demo/bloc/scoped/blocs/bloc_provider.dart';
import 'package:helloflutter/demo/bloc/scoped/pages/top_page.dart';

void main()=> runApp(MyApp());

/**
 * scoped 入口
 */
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: "scoped",
        theme: ThemeData.dark(),
        home: TopPage(),
      ),
    );
  }

}