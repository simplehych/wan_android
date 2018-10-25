import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wan_andoird/net/Address.dart';
import 'package:wan_andoird/net/HttpManager.dart';

class HotSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotSearchPageState();
  }
}

class HotSearchPageState extends State<HotSearchPage> {
  List<Widget> hotWidgets = List<Widget>();
  List<Widget> webWidgets = List<Widget>();

  @override
  void initState() {
    super.initState();
    _getRecommendWeb();
    _getSearchHot();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 0.0),
          child: Text('大家都在搜',
              style: TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 20.0)),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Wrap(
            runSpacing: 5.0,
            spacing: 5.0,
            children: hotWidgets,
            alignment: WrapAlignment.center,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 0.0),
          child: Text('推荐网站',
              style: TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 20.0)),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Wrap(
            runSpacing: 5.0,
            spacing: 5.0,
            children: webWidgets,
            alignment: WrapAlignment.center,
          ),
        ),
      ],
    );
  }

  _getSearchHot() async {
    var res = await HttpManager.fetch(Address.getSearchHot(), null, null, null);
    Map<String, dynamic> jsonMap = res.data;
    List dataList = jsonMap['data'];
    hotWidgets.clear();
    for (var value in dataList) {
      Widget item = ActionChip(
        backgroundColor: Theme.of(context).accentColor,
        label: Text(
          value['name'],
          style: new TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      );
      hotWidgets.add(item);
    }
    print(hotWidgets.toString());
    setState(() {});
  }

  _getRecommendWeb() async {
    var res =
        await HttpManager.fetch(Address.getRecommendWeb(), null, null, null);
    Map<String, dynamic> jsonMap = res.data;
    List dataList = jsonMap['data'];
    webWidgets.clear();
    for (var value in dataList) {
      Widget item = ActionChip(
        backgroundColor: Theme.of(context).accentColor,
        label: Text(
          value['name'],
          style: new TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      );
      webWidgets.add(item);
    }
    print(webWidgets.toString());
    setState(() {});
  }
}
