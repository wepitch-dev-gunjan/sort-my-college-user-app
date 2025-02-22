import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/booking_page/booking_page.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/webinar_page/webinar_pastwebnar_page.dart';
import 'package:myapp/webinar_page/webinar_today_page.dart';
import 'package:myapp/webinar_page/webinar_upcoming_page.dart';
import 'package:myapp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebinarPage extends StatefulWidget {
  const WebinarPage({super.key});

  @override
  State<WebinarPage> createState() => _WebinarPageState();
}

class _WebinarPageState extends State<WebinarPage> {
  late PageController pageController;
  int selectedIndex = 1;
  String name = "";
  String username = "";
  var value;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    SessionDate.dateTimeDif();
  }

  void getAllInfo() async {
    await ApiService.get_profile().then((value) {
      if (!mounted) return; // Check if widget is still mounted
      getname_savedata();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffffffff),
          foregroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Webinar",
              style: SafeGoogleFont(
                "Inter",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTab(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                      pageController.jumpToPage(selectedIndex);
                    },
                    title: "My Webinar",
                    isSelected: selectedIndex == 0),
                CustomTab(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                      pageController.jumpToPage(selectedIndex);
                    },
                    title: "Today",
                    isSelected: selectedIndex == 1),
                CustomTab(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                      pageController.jumpToPage(selectedIndex);
                    },
                    title: "Upcoming",
                    isSelected: selectedIndex == 2),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  WebinarPastDataPage(),
                  WebinarTodayPage(),
                  WebinarUpcomingPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getname_savedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("name") ?? "user";
    setState(() {});
  }
}
