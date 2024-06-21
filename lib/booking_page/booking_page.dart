import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/booking_page/booking_past.dart';
import 'package:myapp/booking_page/booking_today.dart';
import 'package:myapp/booking_page/booking_upcoming.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../other/api_service.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int selectedIndex = 1;
  late PageController _controller;
  var value;
  String username = "";

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: selectedIndex);
  }

  void getAllInfo() async {
    value = ApiService.get_profile();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", value["name"]);
    username = prefs.getString("name") ?? "N/A";
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double baseWidth = 430;
    // double fem = MediaQuery.of(context).size.width;
    // double ffem = fem * 0.97;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        // logic
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffffffff),
          foregroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "My Booking",
              style: SafeGoogleFont("Inter",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff1F0A68)),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 19,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTab(
                        onPressed: () {
                          selectedIndex = 0;
                          setState(() {});
                          _controller.jumpToPage(
                            selectedIndex,
                          );
                        },
                        title: "Past",
                        isSelected: selectedIndex == 0,
                      ),
                      CustomTab(
                        onPressed: () {
                          selectedIndex = 1;
                          setState(() {});
                          _controller.jumpToPage(
                            selectedIndex,
                          );
                        },
                        title: "Today",
                        isSelected: selectedIndex == 1,
                      ),
                      CustomTab(
                        onPressed: () {
                          selectedIndex = 2;
                          setState(() {});
                          _controller.jumpToPage(
                            selectedIndex,
                          );
                        },
                        title: "Upcoming",
                        isSelected: selectedIndex == 2,
                      ),
                    ]),
              ),
              const SizedBox(
                height: 36,
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) {
                    selectedIndex = value;

                    setState(() {});
                  },
                  children: const [
                    BookingPast(),
                    BookingToday(),
                    BookingUpcoming()
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onPressed});

  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: 36,
      width: 112,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            textStyle: SafeGoogleFont(
              'Inter',
              fontSize: mWidth * 0.03,
              fontWeight: FontWeight.w400,
            ),
            foregroundColor:
                isSelected ? const Color(0xffffffff) : Colors.black45,
            backgroundColor:
                isSelected ? const Color(0xff1F0A68) : Colors.white,
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 10),
          )),
    );
  }
}
