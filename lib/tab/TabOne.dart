import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:readhub/net/HttpsUtils.dart';
import 'package:readhub/constant/baseUrl.dart';
import 'package:readhub/bean/NewsBean.dart';
import 'Item.dart';
class TabOne extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabOne();
  }
}

class _TabOne extends State<TabOne> with AutomaticKeepAliveClientMixin{


  List<Data> _list=List();
  Future<dynamic> _pullToRefresh() async {
//    curPage = 1;

    return dynamic;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        child: ListView.separated(
            itemCount: _list.length,
            itemBuilder: (BuildContext context,int index){
              return Container(
                child: Item(_list[index]),
              );
            },
            separatorBuilder:(BuildContext context,int index){
              return Container(
                height: 10,
                color: Colors.blueGrey,
              );
            }
        ),
        onRefresh: ()=>_pullToRefresh());
  }
  
  loadData(){
    HttpsUtils.getInstance().getHttp(topic,{"lastCursor":"", "pageSize": pageSize},(data){
        debugPrint(data.toString());
         NewsBean newsBean= NewsBean.fromJson(data);
         debugPrint(newsBean.data[0].title);
         this.setState((){
           _list=newsBean.data;
         });
    }) ;
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

