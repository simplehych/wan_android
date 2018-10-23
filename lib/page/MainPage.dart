import 'package:flutter/material.dart';
import 'package:wan_andoird/page/cloud/CloudPage.dart';
import 'package:wan_andoird/page/home/HomePage.dart';
import 'package:wan_andoird/page/mine/MinePage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<NavigationIconView> _bottomNavigationBarItemList;
  int _curIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;

  initData() {
    var _body = IndexedStack(
      children: <Widget>[
        HomePage(),
        CloudPage(),
        MinePage(),
      ],
      index: _curIndex,
    );
  }

  @override
  void initState() {
    super.initState();
    Color bgColor = Colors.white;
    Color selectColor = Colors.blue;
    Color unSelectColor = Colors.grey;
    _bottomNavigationBarItemList = <NavigationIconView>[
      NavigationIconView(
        icon: Icon(
          Icons.home,
          color: unSelectColor,
        ),
        activeIcon: Icon(
          Icons.home,
          color: selectColor,
        ),
        title: "home",
        color: bgColor,
        vsync: this,
        centerView: HomePage(),
      ),
      NavigationIconView(
        icon: Icon(
          Icons.cloud,
          color: unSelectColor,
        ),
        activeIcon: Icon(
          Icons.cloud,
          color: selectColor,
        ),
        title: "cloud",
        color: bgColor,
        vsync: this,
        centerView: CloudPage(),
      ),
      NavigationIconView(
        icon: Icon(
          Icons.account_circle,
          color: unSelectColor,
        ),
        activeIcon: Icon(
          Icons.account_circle,
          color: selectColor,
        ),
        title: "mine",
        color: bgColor,
        vsync: this,
        centerView: MinePage(),
      ),
    ];

    for (NavigationIconView view in _bottomNavigationBarItemList) {
      view.controller.addListener(_rebuild);
    }

    _bottomNavigationBarItemList[_curIndex].controller.value = 1.0;
  }

  void _rebuild() {
    setState(() {});
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
        body: Center(
          child: _buildTransitionStack(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _curIndex,
          items: _bottomNavigationBarItemList
              .map((NavigationIconView navigationView) => navigationView.item)
              .toList(),
          onTap: (index) {
            setState(() {
              _bottomNavigationBarItemList[_curIndex].controller.reverse();
              _curIndex = index;
              _bottomNavigationBarItemList[_curIndex].controller.forward();
            });
          },
        ),
      ),
    );
  }

  Widget _buildTransitionStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _bottomNavigationBarItemList) {
      transitions.add(view.transition(_type, context));
    }

    transitions.sort((FadeTransition a, FadeTransition b) {
      Animation<double> aAnimation = a.opacity;
      Animation<double> bAnimation = b.opacity;
      double aValue = aAnimation.value;
      double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(
      children: transitions,
    );
  }
}

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
    Widget centerView,
  })  : _color = color,
        _title = title,
        item = BottomNavigationBarItem(
            icon: icon,
            activeIcon: activeIcon,
            title: Text(title),
            backgroundColor: color),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ),
        centerView = centerView {
    _animation = controller.drive(CurveTween(
      curve: Interval(0.2, 0.5, curve: Curves.fastOutSlowIn),
    ));
  }

  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;
  final Widget centerView;

  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;

    if (BottomNavigationBarType.shifting == type) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween(
            begin: Offset(0.0, 0.02),
            end: Offset.zero,
          ),
        ),
        child: centerView,
      ),
    );
  }
}
