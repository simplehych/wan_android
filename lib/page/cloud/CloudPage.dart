import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:wan_andoird/bottom_app_bar.dart';
import 'package:wan_andoird/dao/DataResult.dart';
import 'package:wan_andoird/dao/UserDao.dart';
import 'package:wan_andoird/model/ArticleListResult.dart';
import 'package:wan_andoird/net/Address.dart';
import 'package:wan_andoird/net/HttpManager.dart';
import 'package:wan_andoird/net/ResultData.dart';
import 'package:wan_andoird/page/MainPage.dart';

class CloudPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CloudPageState();
  }
}

class CloudPageState extends State<CloudPage> {
  List listData = new List();
  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;

  ScrollController _controller = new ScrollController();

  CloudPageState() {
    _controller.addListener(() {
      var maxScrollExtent = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScrollExtent == pixels && listData.length < listTotalSize) {
        getList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBanner();
    getList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    getBanner();
    getList();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemBuilder: (context, i) => buildItem(i),
        itemCount: listData.length + 1,
        controller: _controller,
      );
      return RefreshIndicator(
        child: listView,
        onRefresh: _pullToRefresh,
      );
    }
  }

  buildItem(int i) {}

  getBanner() {}

  getList() {
    getListDao();
//    getListDao().then((res) {
//      if (res != null) {
//        print('getList $res');
//      }
//    });
//    var data = resultData.data;
//    Map<String, dynamic> map = json.decode(resultData);
//    var errorCode = map['errorCode'];
//    var errorMsg = map['errorMsg'];
//    var da = map['data'];
//    print('getList da: $da');
  }

  getListDao() async {
    var dio = Dio();
    Options option = new Options(method: "get");
    Response response =
        await dio.request(Address.getHomeArticleList(0), options: option);
    print('response: ${response.data}');
    ArticleListResult articleListResult =
        ArticleListResult.fromJson(response.data as Map<String, dynamic>);
    print(articleListResult.data.toString());
    print(articleListResult.data.pageCount);
  }
}
