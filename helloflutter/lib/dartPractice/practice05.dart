/**
 * 运算符;
 * 运算符覆写机制;
 */
main(){
  var p;
//  p=Point();
  p?.printInfo();//表示 p 为 null 的时候跳过

  var a=0;
  const value=100;
  a ??= value;//如果 a 为 null，则给 a 赋值 value，否则跳过
  print(a);

  const b=99;
  var c;
  print(c ?? b);//如果 c 不为 null，返回 c 的值，否则返回 b

  final x = Vector(3, 3);
  final y = Vector(2, 2);
  final z = Vector(1, 1);
  print(x);
  print(y + z);
  print(x == (y + z)); //  输出true
}

class Point {
  num x = 0, y = 0;
  void printInfo() => print('($x,$y)');
}

///自定义“+”运算符和覆写"=="运算符;
/// operator 是 Dart 的关键字，与运算符一起使用，表示一个类成员运算符函数,
/// 在理解时，我们应该把 operator 和运算符作为整体，看作是一个成员函数名。
class Vector {
  num x, y;
  Vector(this.x, this.y);
  // 自定义相加运算符，实现向量相加
  Vector operator +(Vector v) =>  Vector(x + v.x, y + v.y);
  // 覆写相等运算符，判断向量相等
  bool operator == (dynamic v) => x == v.x && y == v.y;
}
