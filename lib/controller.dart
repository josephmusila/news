


import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'model.dart';
import 'dart:convert';

class Controller extends GetxController with StateMixin{
  
Client client=http.Client();

@override
  void onInit() {
    fetchData();
    super.onInit();
  }



  Future<Article> fetchData() async{
    var articles;
    var response= await client.get(Uri.parse("https://newsapi.org/v2/everything?q=tesla&from=2022-02-18&sortBy=publishedAt&apiKey=b3c752589f794c76809aa0cf57573845"));
    
    if (response.statusCode==200){
      var jsonString=response.body;
      var jsonMap=json.decode(jsonString);
      articles=Article.fromJson(jsonMap);
    }else{
      return articles;
    }
    return articles;
  
  }
}