import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/home_page/notification_page/news/model/news_model.dart';
import 'package:myapp/home_page/notification_page/news/provider/news_provider1.dart';
import 'package:myapp/home_page/notification_page/news/ui/news_all_info_screen.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/shared/string_const.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

class NewsInformationScreen extends StatefulWidget {
  const NewsInformationScreen({super.key});

  @override
  State<NewsInformationScreen> createState() => _NewsInformationScreenState();
}

class _NewsInformationScreenState extends State<NewsInformationScreen> {
  late NewsProvider1 newsProvider1;

  @override
  void initState() {
    newsProvider1 = Provider.of<NewsProvider1>(context, listen: false);
    super.initState();
  }

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
                    builder: (context) => const HomePageContainer()));
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        ),
        //titleSpacing: 120,
        title: Padding(
          padding: const EdgeInsets.only(left: 54),
          child: Text(
            StringConst.notifications,
            style: SafeGoogleFont("Inter",
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: FutureBuilder<List<Articles>>(
        future: newsProvider1.newsService.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Articles>? articles = snapshot.data;
            return ListView.builder(
              itemCount: articles?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsAllInfoScreen(articles: articles![index]),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            articles?[index].title ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            articles?[index].description ?? '',
                            maxLines: 1,
                          ),
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: const Center(
                                  child: Icon(Icons.notifications,color: ColorsConst.whiteColor,size: 20,)),
                            ),
                          ),
                          trailing:  Text(
                            formatTime(articles?[index].publishedAt ?? ''),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
  String formatTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedTime = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedTime;
  }
}
