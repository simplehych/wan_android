import 'package:flutter/material.dart';
import 'package:wan_andoird/page/cloud/Item.dart';

class SearchListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchListPageState();
  }
}

class SearchListPageState extends State<SearchListPage> {
  int curPage = 0;
  Map<String, String> map = Map();
  List dataList = List();
  int listTotalSize = 0;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScrollExtent2 = _controller.position.maxScrollExtent;
      var pixels2 = _controller.position.pixels;
      if (maxScrollExtent2 == pixels2 && dataList.length < listTotalSize) {
        _articleQuery();
      }
    });
    _articleQuery();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (dataList == null || dataList.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = ListView.builder(
          itemCount: dataList.length,
          controller: _controller,
          itemBuilder: (context, i) => buildItem(i));
      return RefreshIndicator(
        child: listView,
        onRefresh: () {
          curPage = 0;
          _articleQuery();
        },
      );
    }
  }

  _articleQuery() async {
//    Dio dio = new Dio();
//    dio.options.baseUrl = "http://www.wanandroid.com";
//    dio.options.connectTimeout = 5000;
//    dio.options.receiveTimeout = 3000;
//    var response = await dio.request("/article/query/$curPage/json",
//        data: {'k': ''}, options: new Options(method: "POST"));
//    print(response.data.toString());

//    Map<String, String> params = {"k": "1"};
//    var res = await HttpManager.fetch(
//        Address.getSearch(curPage), params, null, new Options(method: 'POST'));
//
//    Map<String, dynamic> data = json.decode(res.data);
//    setState(() {
//      listTotalSize = data['total'];
//      if (curPage == 0) {
//        dataList = data['datas'];
//      } else {
//        dataList.addAll(data['datas']);
//      }
//      curPage++;
//    });
  }

  buildItem(int i) {
    var itemData = dataList[i];
    return Item(itemData);
  }
}
