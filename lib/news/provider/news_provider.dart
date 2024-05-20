import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/news/service/news_api_service.dart';

class NewsProvider with ChangeNotifier {
  NewsApiService newsApiService;

  NewsProvider({
    required this.newsApiService,
  });

  Duration duration = const Duration(minutes: 2);
  Timer? timer;
  bool isResendOtpEnabled = false;
  void addTime() {
    const subSeconds = 1;
      if (duration.inMinutes == 0 && duration.inSeconds == 0) {
        isResendOtpEnabled = true;
        timer!.cancel();
      } else {
        final seconds = duration.inSeconds - subSeconds;
        duration = Duration(seconds: seconds);
      }
    notifyListeners();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => addTime());
  }
}
