import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/news/model/news_response.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';

class NewsAllDetailScreen extends StatefulWidget {
  const NewsAllDetailScreen({required this.newsArticle, super.key});

  final NewsArticle newsArticle;

  @override
  State<NewsAllDetailScreen> createState() => _NewsAllDetailScreenState();
}

class _NewsAllDetailScreenState extends State<NewsAllDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/page-1/images/back.png',
              color: ColorsConst.appBarColor,
            ),
          ),
        ),
        backgroundColor: ColorsConst.whiteColor,
        foregroundColor: ColorsConst.whiteColor,
        titleSpacing: 10,
        title: Text(
          "News Detail",
          style: SafeGoogleFont("Inter",
              fontSize: 18, fontWeight: FontWeight.w600,color: ColorsConst.appBarColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  widget.newsArticle.urlToImage ?? '',
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                formatTime(widget.newsArticle.publishedAt!),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.newsArticle.title!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(),
              const Text(
                'Description -',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.newsArticle.description!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedTime = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedTime;
  }
}
