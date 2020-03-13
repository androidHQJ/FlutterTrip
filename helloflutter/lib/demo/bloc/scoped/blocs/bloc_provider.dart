import 'package:flutter/material.dart';
import 'count_bloc.dart';

///第二步：创建BLoC实例
///Scoped模式
///创建一个bloc provider类,这里我们需要借助InheritWidget,
///实现of方法并让updateShouldNotify返回true
///
/// 一个provider存多个bloc实例或者多个provider都可以
@immutable
class BlocProvider extends InheritedWidget{
  CountBLoC countBLoC=CountBLoC();

  BlocProvider({Key key,Widget child}):super(key:key,child:child);

  ///这里updateShouldNotify需要传入一个InheritedWidget oldWidget，
  ///但是我们强制返回true，所以传一个“_”占位。
  @override
  bool updateShouldNotify(_) => true;

  static CountBLoC of(BuildContext context)=>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).countBLoC;

}