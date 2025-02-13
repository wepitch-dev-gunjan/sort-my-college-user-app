import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/news/model/news_response.dart';
import 'package:myapp/shared/api_end_point.dart';
import 'package:myapp/shared/string_const.dart';

class NewsApiService {
  final String apiKey = '608162a7221647ee988aae17953ad92f';

  Future<List<NewsArticle>> fetchCollegeNews() async {
    final response = await http.get(
      Uri.parse('${ApiEndPoint.newsUrl}=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['articles'];
      List<NewsArticle> articles =
          data.map((item) => NewsArticle.fromJson(item)).toList();

      return articles;
    } else {
      throw Exception(StringConst.exceptionText);
    }
  }
}
