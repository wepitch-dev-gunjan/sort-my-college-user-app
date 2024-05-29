import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notification2 extends StatefulWidget {
  const Notification2({
    super.key,
  });

  @override
  State<Notification2> createState() => _Notification2State();
}

class _Notification2State extends State<Notification2> {
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    getAllInfo();
    super.initState();
  }

  void getAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String title = prefs.getString("title") ?? "N/A";
    String body = prefs.getString("body") ?? "N/A";
    String date = prefs.getString("date") ?? "N/A";

    DateTime notificationDate = DateTime.parse(date);
    if (DateTime.now().difference(notificationDate).inDays <= 60) {
      notifications.insert(0, {
        'title': title,
        'body': body,
        'date': date,
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () { Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePageContainer(),
            ),
          ); }, icon: const Icon( Icons.arrow_back_ios_new,
            color: Color(0xff1F0A68),),
                  ),
               ),
             title: Text(
                "Notification",
                style: SafeGoogleFont(
                  "Inter",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff1F0A68),
                ),
              ),
          ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg1dIOAjqRZTG33LCikcTs75d2G2OJH9vnTA&usqp=CAU',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text(
                'Sandeep Mehra',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Posted 3 more pictures',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ListTile(
              leading: Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg1dIOAjqRZTG33LCikcTs75d2G2OJH9vnTA&usqp=CAU',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text(
                'Dinesh Joshi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Posted 1 more pictures',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ListTile(
              leading: Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg1dIOAjqRZTG33LCikcTs75d2G2OJH9vnTA&usqp=CAU',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text(
                'Kashish Sharma',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Added new session on CUET at 4:00 PM',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
      /*body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return buildNotificationTile(notifications[index]);
        },
      ),*/
    );
  }

  Widget buildNotificationTile(Map<String, String> notification) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(formatTime(notification['date'] ?? '')),
          const SizedBox(
            height: 6,
          ),
          ListTile(
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
                  child: Icon(
                    Icons.notifications,
                    color: ColorsConst.whiteColor,
                    size: 20,
                  ),
                ),
              ),
            ),
            title: Text(
              notification['title'] ?? '',
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              notification['body'] ?? '',
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(String timestamp) {
    try {
      DateTime dateTime = DateTime.parse(timestamp);
      String formattedTime = DateFormat('MMM dd, yyyy').format(dateTime);
      return formattedTime;
    } catch (e) {
      print("Error formatting time: $e");
      return "Invalid Date";
    }
  }
}
