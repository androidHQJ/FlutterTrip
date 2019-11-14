main(){
  var p = Point(100,200); // new 关键字可以省略
  p.printInfo();  // 输出(100, 200);
  Point.factor = 110;
  Point.printZValue(); // 输出10
}

class Point {
  num x, y;
  static num factor = 0;
  //语法糖，等同于在函数体内：this.x = x;this.y = y;
  Point(this.x,this.y);
  void printInfo() => print('($x, $y)');
  static void printZValue() => print('$factor');
}