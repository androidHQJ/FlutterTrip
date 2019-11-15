/**
 * 基本数据类型；
 * 集合
 */
main() {
  var a;
  const b = 2;
  a = 'Jack';
  a = 0048;
  printInteger(b);
  print("*************1*************");
  test();
  print("*************2*************");
  testCollection();
}

void testCollection() {
//  var arr1 = ["Tom", "Andy", "Jack"];
//  var arr2 = List.of([1,2,3]);
//  arr2.add(499);
//  arr1.forEach((v) => print('$v'));
//  arr2.forEach((v) => print('$v'));
//
//  var map1 = {"name": "Tom", 'sex': 'male'};
//  var map2 = new Map();
//  map2['name'] = 'Tom';
//  map2['sex'] = 'male';
//  map2.forEach((k,v) => print('$k: $v'));

  var arr2 = new List<int>.of([1, 2, 3]);
  arr2.add(499);
  arr2.forEach((v) => print('${v}'));
  print(arr2 is List<String>); // false

  var map2 = new Map<String, String>();
  map2['name'] = 'Tom';
  map2['sex'] = 'male';
  map2.forEach((k, v) => print('${k}: ${v}'));
  print(map2 is Map<String, String>); // true

  /**
   * 内部元素支持多种类型（比如，int、double）
   */
  var arr1 = <num>[2, 3.78, 20];
  var arrDyn = <dynamic>["test", 2, 3.9];
  arrDyn.forEach((v) => print('arrDyn is ${v}'));

  var map1 = <String, num>{'name': 2, 'sex': 3.9};
  var mapDyn = <String, dynamic>{'name': 2, 'sex': 3.9, 'age': "18"};
}

void test() {
  int x = 1;
  /**
   * 十六进制数 以0x开头表示 以0开头表示8进制数 如 ：0666
   */
  int hex = 0xEEADBEEF;
  print(hex);
  double y = 5.7345;
  double exponents = 1.13e5; //1.13*10 的五次方
  print(exponents);
  int roundY = y.round(); //四舍五入
  print(roundY);
  if (y != 0) {
    print(y);
  }

  var s = 'cat';
  var s1 = 'this is a uppercased string: ${s.toUpperCase()}';
  print(s1);

  var s3 = """
This is a 
multi-line 
string.""";
  print(s3);
}

void printInteger(var a) {
  print('Hello Dart. My name is $a!');
}
