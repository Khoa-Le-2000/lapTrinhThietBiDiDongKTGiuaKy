import 'dart:convert';

import 'package:http/http.dart' as http;

class Source {
  final String? id;
  final String? name;

  Source({this.id, required this.name});
}

class Article {
  final Source source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content
  });
}

class News {
  final String status;
  final int totalResults;
  final List<Article> articles;

  News({required this.status, required this.totalResults, required this.articles});

  static Future<News> fecthData(String url) async {
    var client = http.Client();
    print("OK");
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200){
      var result = response.body;
      var jsonData = jsonDecode(result);
      List<Article> ls = [];
      print(jsonData["status"]);
      int cnt = 0;
      for (var item in jsonData["articles"]){
        Source source = Source(id: item["source"]["id"], name: item["source"]["name"]);
        Article article = Article(
          source: source,
          author: item["author"],
          title: item["title"],
          description: item["description"],
          url: item["url"],
          urlToImage: item["urlToImage"],
          publishedAt: DateTime.parse(item["publishedAt"]),
          content: item["content"],
        );
        print("load " + (++cnt).toString());
        ls.add(article);
      }
      News news = News(
        status: jsonData["status"],
        totalResults: jsonData["totalResults"],
        articles: ls,
      );
      print(news.totalResults);
      return news;
    } else {
      throw Exception("Lỗi");
    }
  }
}