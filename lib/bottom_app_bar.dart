import 'package:flutter/material.dart';

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WanAndroid'),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 88.0),
        children: <Widget>[],
      ),
      floatingActionButton: FloatingActionButton(onPressed: null),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}

class BottomAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> bottomIcons = <Widget>[];
    List<Widget> bottomIcon = <Widget>[
      IconButton(
        icon: Icon(Icons.home),
      ),
      IconButton(
        icon: Icon(Icons.home),
      ),
      IconButton(
        icon: Icon(Icons.home),
      ),
      IconButton(
        icon: Icon(Icons.home),
      ),
    ];

    bottomIcons.add(Expanded(
      child: SizedBox(),
    ));

    bottomIcons.addAll(bottomIcon);

    return BottomAppBar(
      color: Colors.pink,
      child: Row(
        children: bottomIcons,
      ),
      shape: CircularNotchedRectangle(),
    );
  }
}
