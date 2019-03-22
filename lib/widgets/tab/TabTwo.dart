import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:readhub/net/HttpsUtils.dart';
import 'package:readhub/constant/baseUrl.dart';
import 'package:readhub/bean/NewsBean.dart';
import 'Item.dart';
import 'package:readhub/utils/DateUtils.dart';
class TabTwo extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabTwo();
  }
}

class _TabTwo extends State<TabTwo> with AutomaticKeepAliveClientMixin{
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  List<Data> _list=List();
  bool isRefresh=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData(-1);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: EasyRefresh(
          key: _easyRefreshKey,
          refreshHeader: MaterialHeader(
          key: _headerKey,
          ),
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
           onRefresh: onRefresh,
           loadMore: loadMore,
      )
    );
  }

  Future<void> onRefresh() async{
    isRefresh=true;
    loadData(-1);
  }

  Future<void> loadMore() async{
    loadData(DateUtils.getCurrentDate());
    debugPrint("@@@@@@@@@@@@@@@@@${DateUtils.getCurrentDate()}");
  }

  loadData(dynamic lastCursor){
    HttpsUtils.getInstance().getHttp(news,{"lastCursor": lastCursor, "pageSize": pageSize},(data){
      debugPrint(data.toString());
      NewsBean newsBean= NewsBean.fromJson(data);
      debugPrint(newsBean.data[0].title);
      if(isRefresh){
        this.setState((){
          isRefresh=false;
          _list=newsBean.data;
        });
      }else{
        _list.addAll(newsBean.data);
        this.setState((){});
      }
    }) ;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}