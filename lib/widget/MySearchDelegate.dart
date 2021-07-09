import 'package:flutter/material.dart';
import 'package:news_api_app/components/my_future_builder.dart';
import 'dart:core';
import 'package:news_api_app/model/article_model.dart';
import 'package:news_api_app/services/api_serivce.dart';
import 'package:news_api_app/components/customListTile.dart';

class MySearchDelegate extends SearchDelegate {
  ApiService apiService;
  MySearchDelegate({this.apiService});

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            this.query = "";
          }),
    ];
  }

  Widget buildResults(BuildContext context) {
    if (query == '') return Container();
    return MyFutureBuilder<List<Article>>(
        future: this.apiService.getArticle(query),
        successWidget: (List<Article> articles) {
          return ListView.separated(
              itemCount: articles.length,
              separatorBuilder: (context, index) {
                return Divider(height: .1);
              },
              itemBuilder: (BuildContext context, int index) {
                return customListTile(articles[index], context);
              });
        });
  }

  buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          this.close(context, null);
        });
  }

  buildSuggestions(BuildContext context) {
    if (query == '') return Container();
    return MyFutureBuilder<List<Article>>(
        future: this.apiService.getArticle(query),
        successWidget: (List<Article> articles) {
          return ListView.separated(
              itemCount: articles.length,
              separatorBuilder: (context, index) {
                return Divider(height: .1);
              },
              itemBuilder: (BuildContext context, int index) {
                return customListTile(articles[index], context);
              });
        });
  }
}

buildMatch(String query, String found, BuildContext context) {
  var tabs = found.toLowerCase().split(query.toLowerCase());
  List<TextSpan> list = [];
  for (var i = 0; i < tabs.length; i++) {
    if (i % 2 == 1) {
      list.add(TextSpan(
          text: query,
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.w600, fontSize: 15)));
    }
    list.add(TextSpan(text: tabs[i]));
  }
  return RichText(
    text: TextSpan(style: TextStyle(color: Colors.black), children: list),
  );
}
