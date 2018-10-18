import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  List<BottomNavigationBarItem> _bottomNavigationBarItemList;
  int _curIndex = 0;

  @override
  void initState() {
    super.initState();
    Color bgColor = Colors.white;
    Color selectColor = Colors.blue;
    Color unSelectColor = Colors.grey;
    _bottomNavigationBarItemList = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: unSelectColor,
          ),
          title: Text("home"),
          activeIcon: Icon(
            Icons.home,
            color: selectColor,
          ),
          backgroundColor: bgColor),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.cloud,
            color: unSelectColor,
          ),
          title: Text("cloud"),
          activeIcon: Icon(
            Icons.cloud,
            color: selectColor,
          ),
          backgroundColor: bgColor),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            color: unSelectColor,
          ),
          title: Text("mine"),
          activeIcon: Icon(
            Icons.account_circle,
            color: selectColor,
          ),
          backgroundColor: bgColor),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("WanAndroid"),
        ),
        body: Center(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _curIndex,
          items: _bottomNavigationBarItemList,
        ),
      ),
    );
  }
}
