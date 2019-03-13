import 'package:flutter/material.dart';

class TabOne extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabOne();
  }
}

class _TabOne extends State<TabOne> with AutomaticKeepAliveClientMixin{



   List<int> list=List.generate(50, (int index){
      return index;
  });
  Future<Null> _pullToRefresh() async {
//    curPage = 1;
    //下拉刷新做处理
    setState(() {
      ////改变数据，这里随意发挥
      list = List<int>.generate(30, (i) =>i);
    });
    return null;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context,int index){
              return Text("条目$index");
            }
        ),
        onRefresh: ()=>_pullToRefresh());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}