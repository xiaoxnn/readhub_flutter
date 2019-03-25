import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:readhub/net/HttpsUtils.dart';
import 'package:readhub/constant/baseUrl.dart';
import 'package:readhub/bean/NewsBean.dart';
import 'Item.dart';
import 'package:readhub/utils/DateUtils.dart';
class TabThree extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabThree();
  }
}

class _TabThree extends State<TabThree> with AutomaticKeepAliveClientMixin{
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  List<Data> _list=List();
  bool isRefresh=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData(DateUtils.getCurrentDateLong());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Container(
        child: EasyRefresh(
          key: _easyRefreshKey,
          refreshHeader: MaterialHeader(
            key: _headerKey,
          ),
          refreshFooter: ClassicsFooter(
            key: _footerKey,
            bgColor: Colors.transparent,
            textColor: Colors.black87,
            moreInfoColor: Colors.black54,
            showMore: true,
          ),
          autoLoad: true,
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

  Future<void> onRefresh()async {
    isRefresh=true;
    await loadData(DateUtils.getCurrentDateLong());
  }

  Future<void> loadMore() async{
    await loadData(DateUtils.dateToLong(_list[_list.length-1].publishDate));
  }

  loadData(dynamic lastCursor)async{
    await HttpsUtils.getInstance().getHttp(technews,{"lastCursor": lastCursor, "pageSize": pageSize},(data){
      NewsBean newsBean= NewsBean.fromJson(data);
      if(isRefresh){
        this.setState((){
          isRefresh=false;
          _list=newsBean.data;
          this.setState((){});
        });
      }else{
        this.setState((){
          _list.addAll(newsBean.data);
        });
      }
    }) ;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}