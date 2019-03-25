import 'package:flutter/material.dart';

class Setting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
         margin: EdgeInsets.only(top: 30),
         child: RaisedButton(onPressed: ()=>changeTextSize(context))
    );
  }

  changeTextSize(BuildContext context){
    
    MediaQuery.of(context).copyWith(
        textScaleFactor:10.0 );
  }

}