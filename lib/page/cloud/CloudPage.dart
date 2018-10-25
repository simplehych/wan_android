import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:wan_andoird/bottom_app_bar.dart';
import 'package:wan_andoird/dao/DataResult.dart';
import 'package:wan_andoird/dao/UserDao.dart';
import 'package:wan_andoird/model/ArticleListData.dart';
import 'package:wan_andoird/model/ArticleListResult.dart';
import 'package:wan_andoird/model/HomeBannerResult.dart';
import 'package:wan_andoird/net/Address.dart';
import 'package:wan_andoird/net/HttpManager.dart';
import 'package:wan_andoird/net/ResultData.dart';
import 'package:wan_andoird/page/MainPageTest.dart';
import 'package:wan_andoird/page/cloud/Item.dart';
import 'package:wan_andoird/widget/SllideView.dart';

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
  SlideView bannerView;

  CloudPageState() {
    _controller.addListener(() {
      var maxScrollExtent = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScrollExtent == pixels && listData.length < listTotalSize) {
        print('_controller');
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
      RefreshIndicator refreshIndicator = RefreshIndicator(
        child: listView,
        onRefresh: _pullToRefresh,
      );
      return refreshIndicator;
    }
  }

  buildItem(int i) {
    if (i == 0) {
      return Container(
        height: 180.0,
        child: bannerView,
      );
    }
    i -= 1;
    return Item(listData[i]);
  }

  getBanner() async {
    var res =
        await HttpManager.fetch(Address.getHomeBanner(), null, null, null);
    print('getBanner ${res.data}');
    HomeBannerResult result =
        HomeBannerResult.fromJson(res.data as Map<String, dynamic>);
    setState(() {
      bannerView = SlideView(result.data);
    });
  }

  getList() async {
    var res = await HttpManager.fetch(
        Address.getHomeArticleList(curPage), null, null, null);
    ArticleListResult result =
        ArticleListResult.fromJson(res.data as Map<String, dynamic>);
    print(result.data);
    setState(() {
      listTotalSize = result.data.total;
      if (curPage == 0) {
        listData = result.data.datas;
      } else {
        listData.addAll(result.data.datas);
      }
      curPage++;
    });
  }
}
