import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/home_page/entrance_preparation/components/commons.dart';
import 'package:intl/intl.dart';
import 'package:myapp/other/api_service.dart'; // Import the intl package

class AnnouncementScreen extends StatefulWidget {
  final String id;
  const AnnouncementScreen({super.key, required this.id});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  bool isLoading = true;
  List<Announcement> data = [];

  @override
  void initState() {
    super.initState();
    getAnnouncements(widget.id);
  }

  getAnnouncements(String id) async {
    final res = await ApiService.getInstituteAnnouncements(id: id);

    setState(() {
      // Map the API response to the Announcement class
      data = res.map<Announcement>((item) {
        return Announcement(
          date: DateTime.parse(item['createdAt']),
          message: item['update'],
        );
      }).toList();

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("announcements: $data");

    // Sort and group announcements
    data.sort((a, b) => b.date.compareTo(a.date)); // Sort by date descending

    Map<DateTime, List<Announcement>> groupedAnnouncements = {};
    for (var announcement in data) {
      DateTime dateOnly = DateTime(
        announcement.date.year,
        announcement.date.month,
        announcement.date.day,
      );
      if (groupedAnnouncements.containsKey(dateOnly)) {
        groupedAnnouncements[dateOnly]!.add(announcement);
      } else {
        groupedAnnouncements[dateOnly] = [announcement];
      }
    }

    return Scaffold(
      appBar: const EpAppBar(title: "Announcements"),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : data.isEmpty
              ? const Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var date in groupedAnnouncements.keys)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 26, top: 5),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        DateFormat('dd MMMM yyyy').format(date),
                                    style: const TextStyle(
                                      color: Color(0xff1F0A68),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xff1F0A68),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              ...groupedAnnouncements[date]!
                                  .map((announcement) => AnnouncementCard(
                                      message: announcement.message))
                                  .toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class Announcement {
  final DateTime date;
  final String message;

  Announcement({required this.date, required this.message});
}

class AnnouncementCard extends StatelessWidget {
  final String message;

  const AnnouncementCard({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 6, left: 8),
              child: Icon(Icons.circle, size: 8, color: Colors.black),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff595959),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
