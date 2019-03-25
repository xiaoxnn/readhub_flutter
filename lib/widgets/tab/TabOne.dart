import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
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
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  List<Data> _list=List();

  bool isRefresh=false;
  bool isShowArrowUp=true;

  ScrollController _scrollController=ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData("");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Container(
        child: Stack(
          children: <Widget>[
            NotificationListener<ScrollNotification>(
                 onNotification: (ScrollNotification note){
                    if(note.metrics.extentBefore>=300&&isShowArrowUp){
                      this.setState((){
                        isShowArrowUp=false;
                      });
                    }else if(note.metrics.extentBefore<300&&!isShowArrowUp){
                      this.setState((){
                        isShowArrowUp=true;
                      });
                    }
                 },
                child:    EasyRefresh(
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
                      controller: _scrollController,
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
                ))
         ,Offstage(
              offstage:isShowArrowUp,
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: FloatingActionButton(
                        child: Icon(Icons.arrow_upward),
                        onPressed: ()=>_scrollController.animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.linear)),
                  )
              ),
            )
          ],
        )
    );
  }

  Future<void> onRefresh()async {
    isRefresh=true;
    await loadData("");
  }

  Future<void> loadMore() async{
    await loadData(_list[_list.length-1].order);
  }

  loadData(dynamic lastCursor)async{
    await HttpsUtils.getInstance().getHttp(topic,{"lastCursor": lastCursor, "pageSize": pageSize},(data){
      debugPrint(data.toString());
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