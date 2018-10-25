import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wan_andoird/net/Address.dart';
import 'package:wan_andoird/net/HttpManager.dart';
import 'package:wan_andoird/page/tree/TabPage.dart';

class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TreePageState();
  }
}

class TreePageState extends State<TreePage> {
  var dataList;

  @override
  void initState() {
    super.initState();
    _getTree();
  }

  @override
  Widget build(BuildContext context) {
    if (dataList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, i) {
          var itemData = dataList[i];

          String strContent = '';
          List list = itemData['children'];
          for (var v in list) {
            strContent += '${v['name']}  ';
          }

          return Card(
            elevation: 4.0,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              itemData['name'],
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            strContent,
                            softWrap: true,
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return TabPage(itemData);
                }));
              },
            ),
          );
        },
      );
    }
  }

  _getTree() async{
    var res = await HttpManager.fetch(Address.getTree(), null, null, null);
    Map<String, dynamic> result = res.data;
    dataList = result['data'];
    setState(() {});
  }
}
