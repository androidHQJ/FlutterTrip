main(){
//可选命名参数函数调用
  enable1Flags(bold: true, hidden: false); //true, false
  enable1Flags(bold: true); //true, null
  enable2Flags(bold: false); //false, false

//可忽略参数函数调用
  enable3Flags(true, false); //true, false
  enable3Flags(true); //true, null
  enable4Flags(true); //true, false
  enable4Flags(true,true); // true, true
}

//要达到可选命名参数的用法，那就在定义函数的时候给参数加上 {}
void enable1Flags({bool bold, bool hidden}) => print("$bold , $hidden");

//定义可选命名参数时增加默认值
void enable2Flags({bool bold = true, bool hidden = false}) => print("$bold ,$hidden");

//可忽略的参数在函数定义时用[]符号指定
void enable3Flags(bool bold, [bool hidden]) => print("$bold ,$hidden");

//定义可忽略参数时增加默认值
void enable4Flags(bool bold, [bool hidden = false]) => print("$bold ,$hidden");
