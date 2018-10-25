import 'package:flutter/material.dart';
import 'package:wan_andoird/page/cloud/CloudPage.dart';
import 'package:wan_andoird/page/mine/MinePage.dart';
import 'package:wan_andoird/page/search/SearchPage.dart';
import 'package:wan_andoird/page/tree/TreePage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int _tabIndex = 0;

  List<BottomNavigationBarItem> _navigationViews = List();

  List titles = [Text('home'), Text('cloud'), Text('mine')];
  List icons = [
    Icon(Icons.home),
    Icon(Icons.cloud),
    Icon(Icons.account_circle)
  ];

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < titles.length; i++) {
      _navigationViews.add(BottomNavigationBarItem(
        icon: icons[i],
        title: titles[i],
        backgroundColor: Theme.of(context).accentColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: titles[_tabIndex],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                navigatorKey.currentState
                    .push(new MaterialPageRoute(builder: (context) {
                  return new SearchPage();
                }));
              },
            ),
          ],
        ),
        body: IndexedStack(
          children: <Widget>[
            TreePage(),
            CloudPage(),
            MinePage(),
          ],
          index: _tabIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _navigationViews,
//              .map((BottomNavigationBarItem navigationView) => navigationView)
//              .toList(),
          currentIndex: _tabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
