import 'package:flutter/material.dart';
import 'package:news_api_app/model/article_model.dart';
import 'package:news_api_app/services/api_serivce.dart';
import 'package:news_api_app/widget/MySearchDelegate.dart';

import 'components/customListTile.dart';
import 'components/my_future_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = '';
  Future<List<Article>> articlesFuture;
  ApiService apiService;

  @override
  initState() {
    super.initState();
    apiService = new ApiService();
    articlesFuture = apiService.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("News App", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: MySearchDelegate(apiService: this.apiService));
                }),
          ]),
      body: MyFutureBuilder<List<Article>>(
          future: articlesFuture,
          successWidget: (List<Article> articles) {
            return ListView.separated(
              itemCount: articles.length,
              separatorBuilder: (context, index) {
                return Divider(height: .1);
              },
              itemBuilder: (BuildContext context, int index) {
                return customListTile(articles[index], context);
              },
            );
          }),
    );
  }
}
