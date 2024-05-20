import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:provider/provider.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({required this.id, super.key});

  final String id;

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  String title =
      "Dear MBBS Prof 1st Year 2024 Students,Today's \n live class of Vivek sir has been scheduled at \n 10:00 AM. Don't forget to watch. Stay tuned!!! ";

  @override
  void initState() {
    context.read<CounsellorDetailsProvider>().fetchAnnouncements(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var counsellorDetailController = context.watch<CounsellorDetailsProvider>();
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        surfaceTintColor: ColorsConst.whiteColor,
        backgroundColor: ColorsConst.whiteColor,
        titleSpacing: -10,
        title: const Text(
          'Announcements',
          style: TextStyle(color: ColorsConst.appBarColor),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsConst.appBarColor,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Text(
              '23rd March 2024',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ColorsConst.appBarColor),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                  itemCount:
                      counsellorDetailController.announcementsList.length,
                  itemBuilder: (context, index) {
                    var announcements =
                        counsellorDetailController.announcementsList[index];

                    return Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Card(
                        elevation: 1,
                        color: ColorsConst.whiteColor,
                        surfaceTintColor: ColorsConst.whiteColor,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                announcements.update.toString(),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          const Center(
              child: Text(
            'View All',
            style: TextStyle(fontSize: 14, color: ColorsConst.appBarColor),
          )),
        ],
      ),
    );
  }
}
