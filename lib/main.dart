import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:news/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:news/controller.dart';
import 'package:news/model.dart';
import 'package:get/get.dart';
//import 'article.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:NewsApp(),
    );
  }
}




class NewsApp extends StatefulWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  var controller=Get.put(Controller());

  Future<Article>? _article;

  @override
  void initState() {
    _article=Controller().fetchData();
    super.initState();
   
  }




//added code






  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title:const Text('News App')
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.fetchData();
            },
          child: SizedBox(
            height:double.infinity,
            width: double.infinity,
            child: FutureBuilder<Article>(
              future:_article,
              builder: (context,snapshot){
                if (snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.articles.length,
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          Text(snapshot.data!.articles[index].title),
                         const Divider(color: Colors.black,),
                          Text(snapshot.data!.articles[index].description),
                          Image.network(snapshot.data!.articles[index].urlToImage),
                           const Divider(color: Colors.black,),
                           const SizedBox(height: 10,)
                          //add all the other properties of the article you need here
                          //like source,auther,image,published at and content
                        ],
                      );
                      
                    }
                    );
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ),
        ),

    );
  }
}


