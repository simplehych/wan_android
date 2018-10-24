import 'package:flutter/material.dart';
import 'package:wan_andoird/page/search/HotSearchPage.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: '搜索关键词'),
          controller: _searchController,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ],
      ),
      body: Center(
        child: HotSearchPage(),
      ),
    );
  }
}
