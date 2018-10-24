import 'package:flutter/material.dart';
import 'package:wan_andoird/model/HomeBannerData.dart';
import 'package:wan_andoird/page/ArticleDetailPage.dart';

class SlideView extends StatefulWidget {
  List<HomeBannerData> dataList;

  SlideView(this.dataList);

  @override
  State<StatefulWidget> createState() {
    return SlideViewState(dataList);
  }
}

class SlideViewState extends State<SlideView>
    with SingleTickerProviderStateMixin {
  List<HomeBannerData> dataList;

  SlideViewState(this.dataList);

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: dataList == null ? 0 : dataList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (dataList != null && dataList.length > 0) {
      dataList.forEach((data) {
        String imagePath = data.imagePath;
        String title = data.title;
        String url = data.url;
        items.add(new InkWell(
          child: AspectRatio(
            aspectRatio: 2.0 / 1.0,
            child: Stack(
              children: <Widget>[
                Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 1000.0,
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: 1000.0,
                    color: Color(0x50000000),
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            _handleClick(data);
          },
        ));
      });
    }

    return TabBarView(
      children: items,
      controller: tabController,
    );
  }

  void _handleClick(HomeBannerData data) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(title: data.title, url: data.url);
    }));
  }
}
