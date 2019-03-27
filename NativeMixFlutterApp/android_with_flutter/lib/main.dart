import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:android_with_flutter/flash_page.dart';
import 'package:android_with_flutter/generated/i18n.dart';
import 'package:android_with_flutter/main_page.dart';
import 'package:android_with_flutter/redux/main_redux.dart';
import 'package:android_with_flutter/utils/color.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store =
      Store<MainRedux>(appReducer, initialState: MainRedux(user: null));
  @override
  Widget build(BuildContext context) {
    return StoreProvider<MainRedux>(
      store: store,
      child: MaterialApp(
        title: "玩Android",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(ColorConst.primaryColor),
        ),
        localizationsDelegates: [
          S.delegate,
          // You need to add them if you are using the material library.
          // The material components usses this delegates to provide default
          // localization
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
//        localeListResolutionCallback:
//        S.delegate.listResolution(fallback: const Locale('zh', 'CN')),
        initialRoute: "main",
        routes: {
          "/": (context) => FlashPage(),
          "main": (context) => MainPage(),
        },
      ),
    );
  }
}
