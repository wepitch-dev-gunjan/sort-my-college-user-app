import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home_page/notification_page/news/model/news_model.dart';
import 'package:myapp/home_page/notification_page/news/ui/news_information_screen.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';

class NewsAllInfoScreen extends StatefulWidget {
  NewsAllInfoScreen({required this.articles, super.key});

  Articles articles;

  @override
  State<NewsAllInfoScreen> createState() => _NewsAllInfoScreenState();
}

class _NewsAllInfoScreenState extends State<NewsAllInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsConst.appBarColor,
        foregroundColor: ColorsConst.whiteColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewsInformationScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        ),
        //titleSpacing: 120,
        title: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Text(
            widget.articles.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: SafeGoogleFont("Inter",

                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
        child: Column(
          children: [
            Text(
              formatTime(widget.articles.publishedAt!),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.articles.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.articles.description ?? '',
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.articles.content ?? '',
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
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
