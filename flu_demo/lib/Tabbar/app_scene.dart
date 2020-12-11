import 'package:flu_demo/BaseDefine/sq_color.dart';
import 'package:flu_demo/Tabbar/root_scene.dart';
import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '舒淇story',
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.purple,
          dividerColor: Color(0xffeeeeee),
          scaffoldBackgroundColor: Color(0xFFF5F5F5),
          textTheme: TextTheme(bodyText1: TextStyle(color: SQColor.darkGray))),
      home: RootScene(),
    );
  }
}
