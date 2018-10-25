import 'package:flutter/material.dart';
import 'package:wan_andoird/page/home/HomePage.dart';
import 'package:wan_andoird/page/tree/ArticleListPage.dart';

class TabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabPageState();
  }

  TabPage(this.data);

  var data;
}

class TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> _tabs = List();
  List<dynamic> dataList;

  @override
  void initState() {
    super.initState();
    dataList = widget.data['children'];
    _tabController = TabController(length: dataList.length, vsync: this);
    for (var value in dataList) {
      _tabs.add(Tab(text: value['name']));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: dataList.length,
          child: Scaffold(
            appBar: TabBar(
              tabs: _tabs,
              isScrollable: true,
              controller: _tabController,
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Colors.black,
              indicatorColor: Theme.of(context).accentColor,
            ),
            body: TabBarView(
              controller: _tabController,
              children: dataList.map((itemData) {
                return ArticleListPage(itemData['id'].toString());
              }).toList(),
            ),
          )),
    );
  }
}
