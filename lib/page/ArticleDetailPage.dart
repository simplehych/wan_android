import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleDetailPage extends StatefulWidget {
  String title;
  String url;

  ArticleDetailPage({@required this.title, @required this.url});

  @override
  State<StatefulWidget> createState() {
    return ArticleDetailPageState();
  }
}

class ArticleDetailPageState extends State<ArticleDetailPage> {
  var flutterWebViewPlugin = FlutterWebviewPlugin();
  bool finishLoad = false;

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (WebViewState.finishLoad == state.type) {
        setState(() {
          finishLoad = true;
        });
      } else if (WebViewState.startLoad == state.type) {
        finishLoad = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('ArticleDetailPage build');
    return new WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
            child: finishLoad
                ? Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  )
                : LinearProgressIndicator(),
            preferredSize: Size.fromHeight(0.5)),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      clearCache: true,
      clearCookies: true,
    );
  }
}
