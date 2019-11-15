/**
 * 复用：
 * 继承父类和接口实现;
 * “混入”（Mixin）;
 */
main(){
  var xxx = Vector();
  xxx
    ..x = 1
    ..y = 2
    ..z = 3; //级联运算符，等同于xxx.x=1; xxx.y=2;xxx.z=3;
  xxx.printInfo(); //输出(1,2,3)

  var yyy = Coordinate();
  yyy
    ..x = 1
    ..y = 2; //级联运算符，等同于yyy.x=1; yyy.y=2;
  yyy.printInfo(); //输出(1,2)
  print (yyy is Point); //true
  print(yyy is Coordinate); //true

  var yyyMinxin = CoordinateMixin();
  print (yyyMinxin is Point); //true
  print(yyyMinxin is CoordinateMixin); //true
}

class Point {
  num x = 0, y = 0;
  void printInfo() => print('($x,$y)');
}

//Vector继承自Point
class Vector extends Point{
  num z = 0;

  @override
  void printInfo() {
    //覆写了printInfo实现
    print('($x,$y,$z)');
  }
}

//Coordinate是对Point的接口实现
class Coordinate implements Point {
  //成员变量需要重新声明
  num x = 0, y = 0;

  //成员函数需要重新声明实现
  @override
  void printInfo() {
    // TODO: implement printInfo
    //成员变量需要重新声明
    print('($x,$y)');
  }
}

//混入
class CoordinateMixin with Point {
}