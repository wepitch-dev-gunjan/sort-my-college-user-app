import 'package:flutter/material.dart';
import 'package:myapp/booking_page/booking_page.dart';
import 'package:myapp/home_page/counsellor_page/counsellor_screen.dart';
import 'package:myapp/news/ui/news_screen.dart';
import 'package:myapp/profile_page/profile_page.dart';
import 'package:myapp/home_page/homepage.dart';
import 'package:myapp/webinar_page/webinar_page.dart';
import '../notifications/notification_handler.dart';

class HomePageContainer extends StatefulWidget {
  const HomePageContainer({super.key});

  @override
  State<HomePageContainer> createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {
  int selectedIndex = 0;

  final Widget _home = const HomePage();
  final Widget _webNar = const WebinarPage();
  final Widget _booking = const BookingPage();
  final Widget _news = const NewsScreen();
  final Widget _profile = const ProfilePage();
  @override
  void initState() {
    super.initState();
    retryPendingSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        iconSize: 22.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        selectedItemColor: const Color(0xff512DA8),
        unselectedItemColor: const Color(0xff565656),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home_outlined,
              size: 26,
            ),
          ),
          BottomNavigationBarItem(
            label: "Webinar",
            icon: Icon(
              Icons.smart_display_outlined,
              size: 26,
            ),
          ),
          BottomNavigationBarItem(
            label: "Booking",
            icon: Icon(
              Icons.calendar_month_outlined,
              size: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/page-1/images/newspaper-1-s6H.png"),
            ),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 26,
            ),
            label: "Profile",
          ),
        ],
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget getBody() {
    switch (selectedIndex) {
      case 0:
        return _home;
      case 1:
        return _webNar;
      case 2:
        return _booking;
      case 3:
        return _news;
      case 4:
        return _profile;
      default:
        return _home;
    }
  }

  void onTapgotocounsellor(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CounsellorScreen(),
      ),
    );
  }
}

class HomePageContainerAfterBooking extends StatefulWidget {
  const HomePageContainerAfterBooking({super.key});

  @override
  State<HomePageContainerAfterBooking> createState() =>
      _HomePageContainerAfterBookingState();
}

class _HomePageContainerAfterBookingState
    extends State<HomePageContainerAfterBooking> {
  int selectedIndex = 2;

  final Widget _home = const HomePage();
  final Widget _webNar = const WebinarPage();
  final Widget _booking = const BookingPage();
  final Widget _news = const NewsScreen();
  final Widget _profile = const ProfilePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        iconSize: 22.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        selectedItemColor: const Color(0xff512DA8),
        unselectedItemColor: const Color(0xff565656),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home_outlined,
              size: 26,
            ),
          ),
          BottomNavigationBarItem(
            label: "Webinar",
            icon: Icon(
              Icons.smart_display_outlined,
              size: 26,
            ),
          ),
          BottomNavigationBarItem(
              label: "Booking",
              icon: Icon(
                Icons.calendar_month_outlined,
                size: 24,
              )),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/page-1/images/newspaper-1-s6H.png"),
            ),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 26,
            ),
            label: "Profile",
          ),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _home;
    } else if (selectedIndex == 1) {
      return _webNar;
    } else if (selectedIndex == 2) {
      return _booking;
    } else if (selectedIndex == 3) {
      return _news;
    } else if (selectedIndex == 4) {
      return _profile;
    } else {
      return _home;
    }
  }
}
