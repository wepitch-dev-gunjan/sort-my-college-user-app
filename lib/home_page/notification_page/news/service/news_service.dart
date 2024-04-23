import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/home_page/notification_page/news/model/news_model.dart';
import 'package:myapp/shared/string_const.dart';

class NewsService {
  Future<List<Articles>> fetchNews() async {
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=9d194998f6b248b887462572e7a6bf8e'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['articles'];
      List<Articles> articles =
          data.map((item) => Articles.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception(StringConst.exceptionText);
    }
  }
}
