import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/other/api_service.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = true;
  dynamic data;

  @override
  void initState() {
    super.initState();
    getNotification();
  }

  getNotification() async {
    final notifications = await ApiService.getUserNotification();
    setState(() {
      data = notifications;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Notifications$data");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child: SingleChildScrollView(),
            )
          : data['notifications'].isEmpty
              ? const Center(
                  child: Text("No Data"),
                )
              : ListView.builder(
                  itemCount: data['notifications'].length,
                  itemBuilder: (context, index) {
                    final notification = data['notifications'][index];
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.notifications,
                            color: Colors.deepPurple),
                        title: Text(
                          notification['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notification['messege']),
                            const SizedBox(height: 4),
                            // Text(
                            //   DateFormat('dd MMM yyyy, hh:mm a')
                            //       .format(notification.dateTime),
                            //   style: TextStyle(
                            //       fontSize: 12, color: Colors.grey[600]),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
