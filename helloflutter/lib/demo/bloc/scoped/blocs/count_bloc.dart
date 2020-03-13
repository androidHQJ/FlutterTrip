import 'dart:async';

///第一步：创建BLoC
///创建一条能够通过int类型数据的流
class CountBLoC{
  ///私有变量“_”
  int _count=0;

  ///控制台抛出了这个异常。
  ///flutter: Bad state: Stream has already been listened to.
  ///这是由于流被重复监听导致的。
  ///创建StreamController的时候，默认是创建的单订阅流。
  ///两个页面中都需要显示这个数字，那么就使用了两个StreamBuilder。
  ///而StreamBuilder都监听的同一个流，所以导致了流被重复监听了。
  ///所以我们需要将流改成广播流。
  var _countController=StreamController<int>.broadcast();

  Stream<int> get stream => _countController.stream;
  int get value => _count;

  increment(){
    _countController.sink.add(++_count);
  }

  dispose(){
    _countController.close();
  }
}