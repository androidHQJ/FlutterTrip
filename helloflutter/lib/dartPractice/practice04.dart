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

  Motor()
      ..carryCargo()
      ..passengerService();
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

//mixins多继承模型实现
abstract class Vehicle {}

abstract class MotorVehicle extends Vehicle {}

abstract class NonMotorVehicle extends Vehicle {}

//将各自的能力抽成独立的Mixin类
mixin PetrolDriven {//使用mixin关键字代替class声明一个Mixin类
void petrolDriven() => print("汽油驱动");
}

mixin PassengerService {//使用mixin关键字代替class声明一个Mixin类
void passengerService() => print('载人');
}

mixin CargoService {//使用mixin关键字代替class声明一个Mixin类
void carryCargo() => print('载货');
}

mixin ElectricalDriven {//使用mixin关键字代替class声明一个Mixin类
void electricalDriven() => print("电能驱动");
}

class Motor extends MotorVehicle with PetrolDriven, PassengerService, CargoService {}//利用with关键字使用mixin类

class Bus extends MotorVehicle with PetrolDriven, ElectricalDriven, PassengerService {}//利用with关键字使用mixin类

class Truck extends MotorVehicle with PetrolDriven, CargoService {}//利用with关键字使用mixin类

class Bicycle extends NonMotorVehicle with ElectricalDriven, PassengerService {}//利用with关键字使用mixin类

class Bike extends NonMotorVehicle with PassengerService {}//利用with关键字使用mixin类
