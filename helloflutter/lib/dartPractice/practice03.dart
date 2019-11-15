/**
 * 类
 */
main(){
  var p = Point(100,200); // new 关键字可以省略
  p.printInfo();  // 输出(100, 200);
  Point.factor = 110;
  Point.printZValue(); // 输出10

  var p2 = Point2.bottom(100);
  p2.printInfo(); // 输出(100,0,0)
}

class Point {
  num x, y;
  static num factor = 0;
  //语法糖，等同于在函数体内：this.x = x;this.y = y;
  Point(this.x,this.y);
  void printInfo() => print('($x, $y)');
  static void printZValue() => print('$factor');
}


class Point2 {
  num x, y, z;
  Point2(this.x, this.y) : z = 0; // 初始化变量z
  Point2.bottom(num x) : this(x, 0); // 重定向构造函数
  void printInfo() => print('($x,$y,$z)');
}
