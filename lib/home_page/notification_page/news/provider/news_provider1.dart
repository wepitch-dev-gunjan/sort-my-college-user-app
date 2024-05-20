import 'package:flutter/cupertino.dart';
import 'package:myapp/home_page/notification_page/news/service/news_service.dart';

class NewsProvider1 extends ChangeNotifier {
  NewsService newsService;

  NewsProvider1({
    required this.newsService,
  });
}
