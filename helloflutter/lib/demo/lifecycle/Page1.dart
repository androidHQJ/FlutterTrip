import 'package:flutter/material.dart';
import 'Page2.dart';

class Page1 extends StatefulWidget {
  Page1({Key key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with WidgetsBindingObserver {
  //当Widget第一次插入到Widget树时会被调用。对于每一个State对象，Flutter只会调用该回调一次
  @override
  void initState() {
    super.initState();
    print("page1 initState......");
    WidgetsBinding.instance.addObserver(this); //注册监听器

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("单次Frame绘制回调"); //只回调一次
    });

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      print("实时Frame绘制回调"); //每帧都回调
    });
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print("page1 setState......");
  }

  /*
  *初始化时，在initState之后立刻调用
  *当State的依赖关系发生变化时，会触发此接口被调用
  */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("page1 didChangeDependencies......");
  }

  List<DropdownMenuItem> getListData(){
    List<DropdownMenuItem> items=new List();
    for (int i = 0; i < 10; i++) {
      DropdownMenuItem dropdownMenuItem=new DropdownMenuItem(
        child:new Text('${i+1}'),
        value: '${i+1}',
      );
      items.add(dropdownMenuItem);
    }
    return items;
  }

  var value;

  //绘制界面
  @override
  Widget build(BuildContext context) {
    print("page1 build......");

    TextStyle blackStyle = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 20,
        color: Colors.black); //黑色样式
    TextStyle redStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red); //红色样式
    TextStyle blueStyle = TextStyle(
        fontWeight: FontWeight.w200, fontSize: 20, color: Colors.blue); //蓝色样式
    TextStyle yellowStyle = TextStyle(
        fontWeight: FontWeight.w400, fontSize: 20, color: Colors.yellow); //黄色样式

    return Scaffold(
      appBar: AppBar(title: Text("Lifecycle demo")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("打开/关闭新页面查看状态变化"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Parent()),
              ),
            ),

            FloatingActionButton(
              onPressed: () => print('FloatingActionButton pressed'),
              child: Text('Btn'),
            ),
            FlatButton(
              onPressed: () => print('FlatButton pressed'),
              child: Text('Btn'),
            ),
            RaisedButton(
              onPressed: () => print('RaisedButton pressed'),
              child: Text('Btn'),
            ),

            DropdownButton(
              items: getListData(),
              hint:new Text('下拉选择你想要的数据'),//当没有默认值的时候可以设置的提示
              value: value,//下拉菜单选择完之后显示给用户的值
              onChanged: (T){//下拉菜单item点击之后的回调
                setState(() {
                  value=T;
                });
              },
              elevation: 24,//设置阴影的高度
              style: new TextStyle(//设置文本框里面文字的样式
                  color: Colors.red
              ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
              iconSize: 50.0,//设置三角标icon的大小
            ),

            SimpleDialogOption(
              onPressed: () => print('RaisedButton pressed'),
              child: Text('Btn'),
            ),

            FlatButton(
                color: Colors.yellow, //设置背景色为黄色
                shape:BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)), //设置斜角矩形边框
                colorBrightness: Brightness.light, //确保文字按钮为深色
                onPressed: () => print('FlatButton pressed'),
                child: Row(children: <Widget>[Icon(Icons.add), Text("Add")],)
            ),

            ///单一样式的文本 Text
            Text(
              '文本是视图系统中的常见控件，用来显示一段特定样式的字符串，就比如Android里的TextView，或是iOS中的UILabel。',
              textAlign: TextAlign.center, //居中显示
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue), //20号红色粗体展示
            ),

            ///混合展示样式 TextSpan：分片
            Text.rich(
              TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '文本是视图系统中常见的控件，它用来显示一段特定样式的字符串，类似',
                    style: redStyle), //第1个片段，红色样式
                TextSpan(text: 'Android', style: blackStyle), //第1个片段，黑色样式
                TextSpan(text: '中的', style: blueStyle),
                TextSpan(text: 'TextView', style: yellowStyle)
              ]),
              textAlign: TextAlign.right,
            ),
            Image.asset('assets/images/login_logo.png',
                width: 130,
                height: 100,
                fit: BoxFit.fitWidth,
                color: Theme.of(context).accentColor,
                colorBlendMode: BlendMode.srcIn),
            Image.network(
              'https://upload-images.jianshu.io/upload_images/5361063-e413832da0038304.png?'
              'imageMogr2/auto-orient/strip%7CimageView2/2/w/800',
              width: 800,
              height: 400,
              fit: BoxFit.fitWidth,
              colorBlendMode: BlendMode.srcIn,
            ),
            FadeInImage.assetNetwork(
//              placeholder: 'assets/loading.gif', //gif占位
              placeholder: 'assets/images/login_logo.png',
              //占位
              image:
                  'https://upload-images.jianshu.io/upload_images/5361063-0d454e7147744315.jpeg?'
                  'imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp',
              fit: BoxFit.cover,
              //图片拉伸模式
              width: 600,
              height: 400,
            ),
          ],
        ),
      ),
    );
  }

  //状态改变的时候会调用该方法,比如父类调用了setState
  @override
  void didUpdateWidget(Page1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("page1 didUpdateWidget......");
  }

  //当State对象从树中被移除时，会调用此回调
  @override
  void deactivate() {
    super.deactivate();
    print('page1 deactivate......');
  }

  //当State对象从树中被永久移除时调用；通常在此回调中释放资源
  @override
  void dispose() {
    super.dispose();
    print('page1 dispose......');
    WidgetsBinding.instance.removeObserver(this); //移除监听器
  }

  //监听App生命周期回调:
  ///resumed：可见的，并能响应用户的输入。
  ///inactive：处在不活动状态，无法处理用户响应。
  ///paused：不可见并不能响应用户的输入，但是在后台继续活动中。
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("$state");
    if (state == AppLifecycleState.resumed) {
      //do sth
    }
  }
}
