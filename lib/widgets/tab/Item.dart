import 'package:flutter/material.dart';
import 'package:readhub/bean/NewsBean.dart';
import 'package:readhub/widgets/MyWebView.dart';
import 'package:readhub/utils/ToastUtils.dart';
class Item extends StatefulWidget{
  final  Data _data;
  Item(this._data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Item(_data);
  }
}

class _Item extends State<Item> with  TickerProviderStateMixin{
  AnimationController controller;
  CurvedAnimation curvedAnimation;

  final  Data _data;
  _Item(this._data);


  bool visible=true;

  changeTextMaxLines(){
    this.setState((){
      _data.isShowAll=!_data.isShowAll ;
    });
  }

  show(){
    this.setState((){
      visible=!visible;
    });
  }

  showDetail(String url){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context){
          return MyWebView(url);
        }
    ));
  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(vsync: this ,duration: Duration(seconds: 3));
    curvedAnimation=CurvedAnimation(parent: controller, curve: Curves.linear);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("ddd:${_data.newsArray!=null&&_data.newsArray.length!=0}");
    return Container(
        padding: EdgeInsets.only(left: 15,right: 15,top: 10),
        color: Colors.white,
        child: InkWell(
          onTap: ()=>changeTextMaxLines(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_data.title,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600)),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(_data.summary,maxLines:_data.isShowAll?10:3,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 12)),
              ),
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("8分钟"),
                    Row(
                      children: <Widget>[
                        _data.newsArray!=null&&_data.newsArray.length!=0? IconButton(icon: Icon(Icons.open_with),padding: EdgeInsets.only(right: 0),iconSize: 14, onPressed: ()=>show()):Container(height: 0,),
                        IconButton(icon: Icon(Icons.remove_red_eye),padding: EdgeInsets.only(left: 0) ,iconSize: 14, onPressed: ()=>showDetail(_data.mobileUrl!=null?_data.mobileUrl:_data.newsArray[0].mobileUrl))
                      ],
                    )

                  ],
                ),
              ),
              Offstage(
                offstage:visible,
                child: _data.newsArray==null?Container(height: 0): Container(
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:  Radius.circular(10)),
                  ),
                  child: Column(
                    children: hideView(_data.newsArray),
                  ),
                ),
              ) ,
            ],
          ),
        )
    );
  }

  List<Widget> hideView(List<NewsArray> newsArray) {
    return  List.generate(newsArray.length, (int index){
         if(index<=2){
           return Container(
             margin: EdgeInsets.only(top: 4,bottom: 6),
             child: Row(
               children: <Widget>[
                 Container(
                   margin: EdgeInsets.only(right: 10),
                   child:  Text('$index',style: TextStyle(color: Colors.green),),
                 ),
                 Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text(newsArray[index].title,style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.w400),),
                         Text(newsArray[index].siteName,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),)
                       ],
                     )
                 )
               ],
             ),
           );
         }else if(index==3){
           return GestureDetector(
             onTap: ()=>ToastUtils.showLongToast("详情还在开发不要急"),
             child:  Column(
               children: <Widget>[
                 Divider(),
                 Text("查看剩余 ${newsArray.length-3} 条",style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.w500))
               ],
             ),
           );
         }else{
           return Container(

           );
         }
      });
    }
}