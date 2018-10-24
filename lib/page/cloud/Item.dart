import 'package:flutter/material.dart';
import 'package:wan_andoird/model/NewsData.dart';
import 'package:wan_andoird/page/ArticleDetailPage.dart';

class Item extends StatefulWidget {
  NewsData itemData;

  Item(this.itemData);

  @override
  State<StatefulWidget> createState() {
    return ItemState();
  }
}

class ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    bool collect = widget.itemData.collect;

    Row author = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text('作者：${widget.itemData.author}'),
        ),
        Text(widget.itemData.niceDate),
      ],
    );

    Row title = Row(
      children: <Widget>[
        Expanded(
          child: Text.rich(
            TextSpan(text: widget.itemData.title),
            softWrap: true,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );

    Row chapterName = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            widget.itemData.chapterName,
            softWrap: true,
            style: new TextStyle(color: Theme.of(context).accentColor),
            textAlign: TextAlign.left,
          ),
        ),
        InkWell(
          child: Icon(
            collect ? Icons.favorite : Icons.favorite_border,
            color: collect ? Colors.red : null,
          ),
          onTap: () {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('collect')));
          },
        ),
      ],
    );

    Column column = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: author,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: chapterName,
        ),
      ],
    );

    return Card(
      elevation: 4.0,
      child: new InkWell(
        child: column,
        onTap: () {
          _itemClick(widget.itemData);
        },
      ),
    );
  }

  _itemClick(NewsData itemData) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailPage(
        title: itemData.title,
        url: itemData.link,
      );
    }));
  }
}
