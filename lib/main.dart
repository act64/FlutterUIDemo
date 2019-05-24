import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

import 'fluttermain.dart';

void main() => runApp(MyMixApp());

class MyMixApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyMixApp> {
  @override
  void initState() {
    super.initState();

    ///register page widget builders,the key is pageName
    FlutterBoost.singleton.registerPageBuilders({
      'sample://firstPage': (pageName, params, _) => RealFlutterWidget(),
      'sample://secondPage': (pageName, params, _) => RealFlutterWidget(),
    });

    ///query current top page and load it
    FlutterBoost.handleOnStartPage();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter Boost example',
      builder: FlutterBoost.init(), ///init container manager
      home: Container());
}