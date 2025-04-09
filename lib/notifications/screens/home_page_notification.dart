import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "Welcome to the App!",
      description: "Thanks for signing up. Let’s get started.",
      dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    NotificationItem(
      title: "Update Available",
      description: "A new version of the app is available. Please update.",
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      title: "Scheduled Maintenance",
      description: "We’ll be down for maintenance at 2:00 AM.",
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            // color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading:
                  const Icon(Icons.notifications, color: Colors.deepPurple),
              title: Text(
                notification.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.description),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd MMM yyyy, hh:mm a')
                        .format(notification.dateTime),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final DateTime dateTime;

  NotificationItem({
    required this.title,
    required this.description,
    required this.dateTime,
  });
}
