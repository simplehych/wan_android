import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wan_andoird/net/Address.dart';
import 'package:wan_andoird/net/HttpManager.dart';
import 'package:wan_andoird/page/cloud/Item.dart';

class ArticleListPage extends StatefulWidget {
  String id;

  ArticleListPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return ArticleListPageState();
  }
}

class ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  int curPage = 0;
  Map<String, String> map = Map();
  List dataList = List();
  int totalSize = 0;
  ScrollController _controller = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getArticleList();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && dataList.length < totalSize) {
        _getArticleList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (dataList == null || dataList.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async{
          curPage = 0;
          _getArticleList();
          return null;
        },
        child: ListView.builder(
//          key: PageStorageKey(widget.id),
        physics: AlwaysScrollableScrollPhysics(),
          itemCount: dataList.length,
          controller: _controller,
          itemBuilder: (context, i) {
            return Card(
              margin: EdgeInsets.all(5.0),
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Text(dataList[i]['title']),
                    Text(dataList[i]['chapterName']),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  void _getArticleList() async {
    var res = await HttpManager.fetch(
        Address.getArticleList(curPage, widget.id), null, null, null);
    print(res.data);
    Map<String, dynamic> result = res.data;
    var datas = result['data']['datas'];
    totalSize = result['data']['total'];

    if (curPage == 0) {
      dataList.clear();
    }
    curPage++;
    dataList.addAll(datas);
    setState(() {});
  }
}
