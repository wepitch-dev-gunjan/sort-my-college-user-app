import 'package:flutter/material.dart';
import 'package:myapp/home_page/entrance_preparation/components/app_bar.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: EpAppBar(
        title: "Announcements",
      ),
      body: Center(
        child: Text("Under Developement......."),
      ),
    );
  }
}
