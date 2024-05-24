
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/booking_page/booking_page.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/webinar_page/webinar_pastwebnar_page.dart';
import 'package:myapp/webinar_page/webinar_today_page.dart';
import 'package:myapp/webinar_page/webinar_upcoming_page.dart';
import 'package:myapp/utils.dart';
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
    // TODO: implement initState
    super.initState();
    //getAllInfo();
    pageController = PageController(initialPage: selectedIndex);
    SessionDate.dateTimeDif();
  }

  void getAllInfo() async {
    await ApiService.get_profile().then((value) => getname_savedata());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop){
        // logic
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffffffff),
          foregroundColor: Colors.white,
          // titleSpacing: 60,
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const HomePageContainer()));
          //     },
          //     child: Image.asset(
          //       'assets/page-1/images/back.png',
          //     ),
          //   ),
          // ),
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Webinar",
              style: SafeGoogleFont("Inter",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1F0A68)),
            ),
          ),
        ),
        body: Scaffold(
          backgroundColor: ColorsConst.whiteColor,
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
                    //WebinarPastPage(),
                    WebinarPastDataPage(),
                    WebinarTodayPage(),
                    WebinarUpcomingPage(),
                  ],
                ),
              ),
            ],
          ),
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

Widget customButton({
  required VoidCallback onPressed,
  required String title,
  required bool isPressed,
}) {
  return Card(
    elevation: 1,
    shadowColor: ColorsConst.whiteColor,
    child: SizedBox(
      height: 35,
      width: 100,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          backgroundColor: Colors.white,
          foregroundColor: isPressed ? Colors.black : const Color(0xff747474),
        ),
        child: Text(
          title,
          style: SafeGoogleFont(
            "Inter",
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

// Widget customButton(
//     {required VoidCallback onPressed,
//     required String title,
//     required bool isPressed}) {
//   return SizedBox(
//     height: 35,
//     width: 110,
//     child: OutlinedButton(
//         onPressed: onPressed,
//         style: OutlinedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(3),
//             ),
//             backgroundColor: const Color(0xffE7E7EB),
//             foregroundColor:
//                 isPressed ? Colors.black : const Color(0xff747474)),
//         child: Text(
//           title,
//           style: SafeGoogleFont("Inter",
//               fontSize: 12, fontWeight: FontWeight.w500),
//         )),
//   );
// }



















// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:myapp/booking_page/booking_page.dart';
// import 'package:myapp/other/api_service.dart';
// import 'package:myapp/shared/colors_const.dart';
// import 'package:myapp/webinar_page/webinar_pastwebnar_page.dart';
// import 'package:myapp/webinar_page/webinar_today_page.dart';
// import 'package:myapp/webinar_page/webinar_upcoming_page.dart';
// import 'package:myapp/utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class WebinarPage extends StatefulWidget {
//   const WebinarPage({super.key});

//   @override
//   State<WebinarPage> createState() => _WebinarPageState();
// }

// class _WebinarPageState extends State<WebinarPage> {
//   late PageController pageController;
//   int selectedIndex = 1;
//   String name = "";
//   String username = "";
//   var value;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //getAllInfo();
//     pageController = PageController(initialPage: selectedIndex);
//     SessionDate.dateTimeDif();
//   }

//   void getAllInfo() async {
//     await ApiService.get_profile().then((value) => getname_savedata());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked : (didPop){
//         // logic
//         SystemNavigator.pop();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: const Color(0xffffffff),
//           foregroundColor: Colors.white,
//           // titleSpacing: 60,
//           // leading: Padding(
//           //   padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
//           //   child: GestureDetector(
//           //     onTap: () {
//           //       Navigator.pushReplacement(
//           //           context,
//           //           MaterialPageRoute(
//           //               builder: (context) => const HomePageContainer()));
//           //     },
//           //     child: Image.asset(
//           //       'assets/page-1/images/back.png',
//           //     ),
//           //   ),
//           // ),
//           title: Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Text(
//               "Webinar",
//               style: SafeGoogleFont("Inter",
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xff1F0A68)),
//             ),
//           ),
//         ),
//         body: Scaffold(
//           backgroundColor: ColorsConst.whiteColor,
//           body: Column(
//             children: [
//               const SizedBox(
//                 height: 12,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTab(
//                       onPressed: () {
//                         setState(() {
//                           selectedIndex = 0;
//                         });
//                         pageController.jumpToPage(selectedIndex);
//                       },
//                       title: "My Webinar",
//                       isSelected: selectedIndex == 0),
//                   CustomTab(
//                       onPressed: () {
//                         setState(() {
//                           selectedIndex = 1;
//                         });
//                         pageController.jumpToPage(selectedIndex);
//                       },
//                       title: "Today",
//                       isSelected: selectedIndex == 1),
//                   CustomTab(
//                       onPressed: () {
//                         setState(() {
//                           selectedIndex = 2;
//                         });
//                         pageController.jumpToPage(selectedIndex);
//                       },
//                       title: "Upcoming",
//                       isSelected: selectedIndex == 2),
//                 ],
//               ),
//               Expanded(
//                 child: PageView(
//                   controller: pageController,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: const [
//                     //WebinarPastPage(),
//                     WebinarPastDataPage(),
//                     WebinarTodayPage(),
//                     WebinarUpcomingPage(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   getname_savedata() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     username = prefs.getString("name") ?? "user";
//     setState(() {});
//   }

// }

// Widget customButton({
//   required VoidCallback onPressed,
//   required String title,
//   required bool isPressed,
// }) {
//   return Card(
//     elevation: 1,
//     shadowColor: ColorsConst.whiteColor,
//     child: SizedBox(
//       height: 35,
//       width: 100,
//       child: TextButton(
//         onPressed: onPressed,
//         style: TextButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(3),
//           ),
//           backgroundColor: Colors.white,
//           foregroundColor: isPressed ? Colors.black : const Color(0xff747474),
//         ),
//         child: Text(
//           title,
//           style: SafeGoogleFont(
//             "Inter",
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// // Widget customButton(
// //     {required VoidCallback onPressed,
// //     required String title,
// //     required bool isPressed}) {
// //   return SizedBox(
// //     height: 35,
// //     width: 110,
// //     child: OutlinedButton(
// //         onPressed: onPressed,
// //         style: OutlinedButton.styleFrom(
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(3),
// //             ),
// //             backgroundColor: const Color(0xffE7E7EB),
// //             foregroundColor:
// //                 isPressed ? Colors.black : const Color(0xff747474)),
// //         child: Text(
// //           title,
// //           style: SafeGoogleFont("Inter",
// //               fontSize: 12, fontWeight: FontWeight.w500),
// //         )),
// //   );
// // }
