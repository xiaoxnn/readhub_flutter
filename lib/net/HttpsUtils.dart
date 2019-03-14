import 'package:dio/dio.dart';

class HttpsUtils{
     static HttpsUtils _httpsUtils;

     static HttpsUtils getInstance(){
       if(_httpsUtils==null){
         _httpsUtils=new HttpsUtils() ;
       }
       return _httpsUtils ;
     }

     getHttp(String url,Map<String, dynamic> queryParameters, Function callBack) async{
       Response  response;
        try{
            response= await Dio().get(url,queryParameters: queryParameters) ;
            if(callBack!=null){
              callBack(response.data);
            }
        }catch(e){
           print(e);
        }
     }
}