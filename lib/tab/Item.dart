import 'package:flutter/material.dart';
import 'package:readhub/bean/NewsBean.dart';

class Item extends StatefulWidget{
  final  Data _data;
  Item(this._data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Item(_data);
  }
}

class _Item extends State<Item>{

  final  Data _data;
  _Item(this._data);

  bool visible;

  changeTextMaxLines(){
    this.setState((){
      _data.isShowAll=!_data.isShowAll ;
    });
  }

  show(){
    this.setState((){
      _data.isShowAllNews=!_data.isShowAllNews ;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(left: 15,right: 15,top: 10),
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
                    IconButton(icon: Icon(Icons.open_with) ,iconSize: 14, onPressed: ()=>show())
                  ],
                ),
              ),
              Offstage(
                offstage:_data.isShowAllNews,
                child:  Container(
                  child: Column(
                    children: hideView(_data.newsArray),
                  ),
                ),
              )

            ],
          ),
        )
    );
  }

  hideView(List<NewsArray> newsArray) {
    return  List.generate(newsArray.length, (int index){
         return Container(
           margin: EdgeInsets.only(bottom: 10),
           child: Row(
             children: <Widget>[
               Text('$index',style: TextStyle(color: Colors.green),),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(newsArray[index].title),
                   Text(newsArray[index].siteName)
                 ],
               )
             ],
           ),
         );
      });
    }
}