import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class FirstPlugin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Plugin Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: PluginTest(title: "Hello Plugin")
    );
  }
}
class  PluginTest extends StatefulWidget{
  String title;
  PluginTest({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PluginTestState();
  }
}

class _PluginTestState extends State<PluginTest> {
  
  /**
   * （1）MethodChannel：Flutter App调用Native APIs 
   *  创建通道名称 必须唯一
   */
  static const MethodChannel platform=const MethodChannel('samples.flutter.io/battery');

  //电池电量
  String _batteryLevel = 'Unknown battery level.';
  Future<Null> _getBatteryLevel() async {
      String batteryLevel;
      try{
        final int result = await platform.invokeMethod('getBatteryLevel');
        batteryLevel = "Battery level at $result%.";

      } on PlatformException catch (e){
        batteryLevel = "Failed to get battery level: '${e.message}'.";
      }
      //状态更新
      setState((){
        _batteryLevel = batteryLevel;
      });

    }
  
  /**
   * （2）EventChannel：Native调用Flutter App
   */
  static const EventChannel _eventChannel = const EventChannel('samples.flutter.io/charging');
  String _chargingStatus='Battery status: unknown.';

  void listenNativeEvent() {
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError:_onError);
  }

  void _onEvent(Object event) {
    String result="Battery status: ${event == 'charging' ? '' : 'dis'}charging.";
    print(result);
    setState(() {
      _chargingStatus =result;
    });
  }

  void _onError(Object error) {
    String result='Battery status: unknown.';
    print(result);
    setState(() {
      _chargingStatus =result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenNativeEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_batteryLevel, key: const Key('Battery level label')),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  child: const Text('Refresh'),
                  onPressed: _getBatteryLevel,
                ),
              ),
            ],
          ),
          Text(_chargingStatus),
        ],
      ),
    );
  } 
}