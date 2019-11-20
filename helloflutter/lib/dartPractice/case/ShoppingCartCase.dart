/// 1.类抽象改造：
/// 优化1.1：删掉了构造函数函数体
/// 优化1.2：抽象出一个新的基类 Meta，用于存放 price 属性与 name 属性。
/// 2.方法改造：
/// 优化2.1:重载 Item 类的“+”运算符，并通过对列表对象进行归纳合并操作即可实现
//operator+：
// 把两个Item对象合并为一个。
// 新Item对象的name为这两个对象的name拼接而成，price为他们的price相加而成。
//get price：对列表数据采用累加的方式进行求和。这里用到了reduce方法。reduce是函数迭代方法，
// 需要传递一个二元函数进行列表的合并工作。list[0...n].reduce(f)等于：
//a0 = list[0]
//a1 = f(a0,list[1])
//a2 = f(a1,list[2])
//an = f(an-1,list[n])
//在这里我们的f是求和函数f(x,y)=x+y，可以理解成an=list[0]+list[1]+list[n-1]+list[n]

/// 优化2.2：对字符串插入变量或表达式，并使用多行字符串声明的方式，
///         来完全抛弃不优雅的字符串拼接，实现字符串格式化组合。
/// 3.对象初始化方式的优化：
/// 优化3.1：让调用者以“参数名: 参数键值对”的方式指定调用参数，让调用者明确传递的初始化参数的意义
///         可以通过给参数增加{}实现
/// 优化3.2：对于购物车对象的初始化，我们还需要提供一个不含优惠码的初始化方法，
///         并且需要确定多个初始化方法与父类的初始化方法之间的正确调用顺序。
/// 4.由于优惠码可以为空，我们还需要对 getInfo 方法进行兼容处理：
///   用到了 a??b 运算符，这个运算符能够大量简化在其他语言中三元表达式 (a != null)? a : b 的写法：


abstract class PrintHelper {
  printInfo() => print(getInfo());
  getInfo();
}

class Meta {
  double price;
  String name;

  Meta(this.name, this.price);
}

class Item2 extends Meta with PrintHelper{
  double num;

  // Item2(String name, double price) : super(name, price);
//  Item2(name, price,this.num) : super(name, price);
  Item2(name, price, {double num = 1.0}): super(name, price) {
    this.num = num;
  }

  //优化2.1:重载了+运算符，将商品对象合并为套餐商品
//  Item2 operator +(Item2 item) => Item2(name + item.name, price + item.price);
  Item2 operator+(Item2 item) => Item2(name + item.name, price * num + (item.price * item.num));

  @override
  getInfo() =>'''
    商品名: $name
    单价: $price
    数量: $num
    ---------------
''';
}

class ShoppingCart2 extends Meta with PrintHelper{
  DateTime date;
  String code;
  List<Item2> bookings;

  //ShoppingCart2(String name, double price) : super(name, price);
//  ShoppingCart2(name, this.code): date = DateTime.now(),super(name, 0);

  //优化3.2：默认初始化方法，转发到withCode里
  ShoppingCart2({name}) : this.withCode(name:name, code:null);
  //优化3.1：withCode初始化方法，使用语法糖和初始化列表进行赋值，并调用父类初始化方法
  ShoppingCart2.withCode({name, this.code}) : date = DateTime.now(), super(name,0);

  //优化2.1：把迭代求和改写为归纳合并
  double get price => bookings.reduce((value, element) => value + element).price;

//  double get price {
//    double sum = 0.0;
//    for (var i in bookings) {
//      sum += i.price;
//    }
//    return sum;
//  }

  getBookingInfo() {
    String str = "";
    for (Item2 item in bookings) {
      str += item.getInfo();
    }
    return str;
  }

  //优化2.2：去掉了多余的字符串转义和拼接代码
  //优化4：??运算符表示为code不为null，则用原值，否则使用默认值"没有"
  getInfo () => '''
购物车信息:
-----------------------------
  用户名: $name
  优惠码: ${code??"没有"}
  总价: $price
  Date: $date
  商品列表：
    ---------------
${getBookingInfo()}
----------------------------
''';

//  getInfo() {
//    return '购物车信息:' +
//        '\n-----------------------------' +
//        '\n用户名: ' +
//        name +
//        '\n优惠码: ' +
//        code +
//        '\n总价: ' +
//        price().toString() +
//        '\n日期: ' +
//        date.toString() +
//        '\n-----------------------------';
//  }
}

//定义商品Item类
class Item {
  double price;
  String name;

  //优化1.1：删掉了构造函数函数体
  Item(this.name, this.price);

//  Item(name, price) {
//    this.name = name;
//    this.price = price;
//  }

}

//定义购物车类
class ShoppingCart {
  String name;
  DateTime date;
  String code;
  List<Item> bookings;

  price() {
    double sum = 0.0;
    for (var i in bookings) {
      sum += i.price;
    }
    return sum;
  }

  //优化1.1：删掉了构造函数函数体
  ShoppingCart(this.name, this.code) : date = DateTime.now();

//  ShoppingCart(name, code) {
//    this.name = name;
//    this.code = code;
//    this.date = DateTime.now();
//  }

  getInfo() {
    return '购物车信息:' +
        '\n-----------------------------' +
        '\n用户名: ' +
        name +
        '\n优惠码: ' +
        code +
        '\n总价: ' +
        price().toString() +
        '\n日期: ' +
        date.toString() +
        '\n-----------------------------';
  }
}

void main() {
  ShoppingCart sc = ShoppingCart('张三', '123456');
  sc.bookings = [Item('苹果', 10.0), Item('鸭梨', 20.0)];
  print(sc.getInfo());

//  ShoppingCart2 sc2 = ShoppingCart2.withCode(name:'张三', code:'123456');
//  sc2.bookings = [Item2('苹果',10.0), Item2('鸭梨',20.0)];
//  print(sc2.getInfo());
  ///使用级联运算符“..”，在同一个对象上连续调用多个函数以及访问成员变量。
  /// 使用级联操作符可以避免创建临时变量，让代码看起来更流畅
  ShoppingCart2.withCode(name:'张三', code:'123456')
  ..bookings= [Item2('苹果',10.0,num: 10.2), Item2('鸭梨',20.0,num: 16.8)]
  ..printInfo();

//  ShoppingCart2 sc3 = ShoppingCart2(name:'李四');
//  sc3.bookings = [Item2('香蕉',15.0), Item2('西瓜',40.0)];
//  print(sc3.getInfo());
  ShoppingCart2(name:'李四')
  ..bookings=[Item2('香蕉',15.0), Item2('西瓜',40.0)]
  ..printInfo();
}
