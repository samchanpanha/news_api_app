import "dart:convert";
import 'package:http/http.dart' as http;
import 'package:news_api_app/model/article_model.dart';

class ApiService {
  Future<List<Article>> getArticle(String query) async {
    final endPointUrl = "newsapi.org";
    final client = http.Client();
    final queryParameters = {
      'country': 'us',
      'category': 'technology',
      'apiKey': '3c93b47711784ce78eb5f2f8e35fb71d'
    };

    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];

      return body
          .map((dynamic item) => Article.fromJson(item))
          .where((article) {
        final titleLower = article.title.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<Article>> fetchAll() async {
    final endPointUrl = "newsapi.org";
    final client = http.Client();
    final queryParameters = {
      'country': 'us',
      'category': 'technology',
      'apiKey': '3c93b47711784ce78eb5f2f8e35fb71d'
    };

    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return Future.delayed(Duration(seconds: 2), () {
        return articles;
      });
    } else {
      throw Exception();
    }
  }
}
