import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MyWebView extends StatefulWidget{

  final String url;
  MyWebView(this.url);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyWebView();
  }
}

class _MyWebView extends State<MyWebView>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text("ReadHub"),
      ),
      withZoom: true,
    );
  }

}