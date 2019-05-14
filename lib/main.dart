import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'study/calculator_view.dart';
import 'study/zhifubao_view.dart';

import 'study/touch_move_view.dart';
import 'study/animation_view.dart';

void main() {
  runApp(MaterialApp(
    localizationsDelegates: [
      // ... app-specific localization delegate[s] here
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    locale: const Locale(
      'zh',
    ),
    supportedLocales: [
      const Locale(
        'zh',
      )
    ],
    home: Scaffold(
      appBar: AppBar(
        title: Text("UI效果"),
      ),
      body: HomeWidget(),
    ),
    theme: ThemeData(
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.blueAccent)),
  ));
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        RaisedButton(
            child: Text("密码控件"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("密码控件"),
                  ),
                  body: ZZView(),
                );
              }));
            }),
        RaisedButton(
            child: Text("属性动画"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("属性动画"),
                  ),
                  body: AnimationView(),
                );
              }));
            }),
        RaisedButton(
            child: Text("控件拖动"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("控件拖动"),
                  ),
                  body: TouchMoveView(),
                );
              }));
            }),
        RaisedButton(
            child: Text("计算器"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("计算器"),
                  ),
                  body: CalculateMainView(),
                );
              }));
            }),
      ],
    );
  }
}


