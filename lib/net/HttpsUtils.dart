import 'package:dio/dio.dart';

class HttpsUtils{
     static HttpsUtils _httpsUtils;

     static HttpsUtils getInstance(){
       if(_httpsUtils==null){
         _httpsUtils=new HttpsUtils() ;
       }
       return _httpsUtils ;
     }

     Future<Response> getHttp(String url) async{
       Response  response;
        try{
            response= await Dio().get(url) ;
        }catch(e){
        }
       return response ;
     }
}