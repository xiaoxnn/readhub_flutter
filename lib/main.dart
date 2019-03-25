import 'package:flutter/material.dart';
import 'package:readhub/widgets/Home.dart';
import 'package:readhub/widgets/MyWebView.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Home(),
      routes: {
        "/MyWebView": (_) => MyWebView("")
      },

    );
  }
}


