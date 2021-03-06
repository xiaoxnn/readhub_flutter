import 'package:flutter/material.dart';
import 'tab/TabOne.dart';
import 'tab/TabTwo.dart';
import 'tab/TabThree.dart';
import 'tab/TabFour.dart';
class Home extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}
class _Home extends State<Home>{
  final List<String> titles= ["热门话题","科技动态","开发者","区块链"];

  set(BuildContext context){
    Scaffold.of(context).openEndDrawer();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: titles.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("ReadHub"),
            elevation: 0,
            bottom: TabBar(
                labelColor:Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.w600),
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.blueGrey,
                indicatorPadding:EdgeInsets.only(top: 10),
                tabs: List.generate(titles.length, (int index){
                  return  Container(
                    child:Tab(text:titles[index]),
                  );
                })),
          ),
          body: TabBarView(
            children: <Widget>[
              TabOne(),
              TabTwo(),
              TabThree(),
              TabFour()
            ],
          ),
        ));
  }

}