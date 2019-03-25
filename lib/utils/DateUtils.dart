
class DateUtils{



  ///获取当前时间戳
   static getCurrentDateLong(){
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// 2019-03-23T13:28:07.000z=>  1553347687000
   static dateToLong(String date){
      return  DateTime.parse(date).millisecondsSinceEpoch;
   }

   ///date 获取年月日  2019:03:24
   static dateYMD(String date ){
     int year=DateTime.parse(date).year;
     int month=DateTime.parse(date).month;
     int day=DateTime.parse(date).day;
     return  "$year:${month<10?"0$month":month}:${day<10?"0$day":day}";
   }
}