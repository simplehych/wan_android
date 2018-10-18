import 'package:flutter/material.dart';

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var fabLocation = FloatingActionButtonLocation.centerDocked;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('WanAndroid'),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 88.0),
        children: <Widget>[],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.android),
          onPressed: () {
            setState(() {
              _scaffoldKey.currentState
                  .showSnackBar(SnackBar(content: Text("fab")));
            });
          }),
      floatingActionButtonLocation: fabLocation,
      bottomNavigationBar: BottomAppBarWidget(
        fabLocation: fabLocation,
      ),
    );
  }
}

class BottomAppBarWidget extends StatefulWidget {
  FloatingActionButtonLocation fabLocation;

  BottomAppBarWidget({this.fabLocation});

  @override
  State<StatefulWidget> createState() {
    return new BottomAppBarState(fabLocation);
  }
}

class BottomAppBarState extends State<BottomAppBarWidget> {
  BottomAppBarState(this.fabLocation);

  FloatingActionButtonLocation fabLocation;
  final String home = "home";
  final String dashboard = "dashboard";
  final String library = "library";
  final String account = "account";
  String curText = "home";

  void _handleChanged(String text) {
    setState(() {
      curText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childs = <Widget>[
      BottomTab(
        isSelect: curText == home ? true : false,
        icon: Icons.home,
        text: home,
        onChanged: _handleChanged,
      ),
      BottomTab(
        isSelect: curText == dashboard ? true : false,
        icon: Icons.dashboard,
        text: dashboard,
        onChanged: _handleChanged,
      ),
      Expanded(child: Text("")),
      BottomTab(
        isSelect: curText == library ? true : false,
        icon: Icons.library_books,
        text: library,
        onChanged: _handleChanged,
      ),
      BottomTab(
        isSelect: curText == account ? true : false,
        icon: Icons.account_circle,
        text: account,
        onChanged: _handleChanged,
      ),
    ];
    return BottomAppBar(
      color: Colors.blue,
      child: Row(
        children: childs,
      ),
      shape: CircularNotchedRectangle(),
    );
  }
}

class BottomTab extends StatelessWidget {
  BottomTab({
    this.isSelect,
    this.icon,
    this.text,
    this.selectColor: Colors.white,
    this.unSelectColor: Colors.grey,
    @required this.onChanged,
  });

  Color selectColor;
  Color unSelectColor;
  bool isSelect;
  IconData icon;
  String text;
  final ValueChanged<String> onChanged;

  void _handleTap() {
    debugDumpLayerTree();
    onChanged(text);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70,
        child: Column(
          children: <Widget>[
            IconButton(
              onPressed: _handleTap,
              icon: Icon(icon),
              color: isSelect ? selectColor : unSelectColor,
            ),
            Text(
              text,
              style: TextStyle(
                color: isSelect ? selectColor : unSelectColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showSnackBar(BuildContext context, String msg) {
  return () {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  };
}
