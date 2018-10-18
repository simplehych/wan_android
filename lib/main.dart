import 'package:flutter/material.dart';
import 'package:wan_andoird/bottom_app_bar.dart';
import 'package:wan_andoird/page/MainPage.dart';

void main() => runApp(new MainPage());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'WanAndroid',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPageWidget(),
    );
  }
}
