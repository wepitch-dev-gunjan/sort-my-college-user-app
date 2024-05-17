import 'package:flutter/material.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/webinar_page/webinar_model.dart';
import 'package:myapp/widget/custom_webniar_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../other/provider/counsellor_details_provider.dart';

class WebinarPastPage extends StatefulWidget {
  const WebinarPastPage({Key? key}) : super(key: key);

  @override
  State<WebinarPastPage> createState() => _WebinarPastPageState();
}

class _WebinarPastPageState extends State<WebinarPastPage> {
  void handleRegisterClick() {
    // Implement the logic you want when the "Register Now" button is clicked
    // For example, showing a message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Registration'),
        content: Text('You cannot register for past webinars.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<CounsellorDetailsProvider>().fetchWebinar_Data("Past");
    context.read<CounsellorDetailsProvider>().fetchMyWebinar();
  }

  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    return ListView.builder(
      itemCount: counsellorSessionProvider.webinarList.length,
      itemBuilder: (context, index) {
        WebinarModel webinarModel =
            counsellorSessionProvider.webinarList[index];
        return Padding(
          padding:
              EdgeInsets.only(top: index == 0 ? 30 : 6, right: 16, left: 16),
          child: CustomWebinarCard1(
            showDuration: false,
            title: "Learn more about CUET and IPMAT",
            isRegisterNow: false,
            btnTitle: "Happened 2 Days ago",
            time: "15 Sep @ 2:00 PM Onwards",
            duration: "60",
            participants: "Unlimited",
            bannerImg: "assets/page-1/images/webinarBanner.png",
            onRegisterClicked: handleRegisterClick, // Passing callback function
            webinarModel: webinarModel,
          ),
        );
      },
    );
  }
}

// Widget customEnrollButton(
//     {required VoidCallback onPresssed,
//     required String title,
//     required BuildContext context}) {
//   return SizedBox(
//     height: 30,
//     width: 60,
//     child: Container(
//       decoration: BoxDecoration(
//           color: const Color(0xff1F0A68),
//           borderRadius: BorderRadius.circular(5),
//           boxShadow: const [
//             BoxShadow(
//               blurRadius: 3,
//               color: Colors.grey,
//               spreadRadius: 0.1,
//               offset: Offset(0, 3),
//             )
//           ]),
//       child: Center(
//         child: Text(
//           title,
//           textAlign: TextAlign.center,
//           style: SafeGoogleFont(
//             "Inter",
//             color: Colors.white,
//             fontSize: 10,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     ),
//   );
// }

class WebinarDetailsPageWidget1 extends StatefulWidget {
  const WebinarDetailsPageWidget1({super.key});

  @override
  State<WebinarDetailsPageWidget1> createState() =>
      _WebinarDetailsPageWidget1State();
}

class _WebinarDetailsPageWidget1State extends State<WebinarDetailsPageWidget1> {
  late SharedPreferences _prefs;
  bool _isRegistrationStarting = false;
  var value;
  var dataList;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    value = await ApiService.getWebinarDetailsData('');
    List<String> whatWill = ['what_will_you_learn'];
    dataList = whatWill.length;
    _prefs = await SharedPreferences.getInstance();
    bool isStarting = _prefs.getBool('isRegistrationStarting') ?? false;
    setState(() {
      _isRegistrationStarting = isStarting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 320,
                  child: Stack(
                    children: [
                      Container(
                        color: const Color(0xffffffff).withOpacity(0.8),
                        width: double.infinity,
                        height: 280,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xff1F0A68),
                                    size: 25,
                                  ),
                                ),
                                Text(
                                  'Webinar Details',
                                  style: SafeGoogleFont("Inter",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsConst.appBarColor),
                                ),
                                const Spacer(),
                                Image.asset(
                                  "assets/page-1/images/share.png",
                                  color: Color(0xff1F0A68),
                                  height: 23,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 28.0, right: 20, left: 20),
                            child: Container(
                              height: 196,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/page-1/images/webinarBanner.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11, 20, 12, 15),
                      child: Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Learn more about CUET and IPMAT",
                              style: SafeGoogleFont("Inter",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff414040)),
                            ),
                            Text(
                              "60 min",
                              style: SafeGoogleFont("Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: fontColor),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: Row(
                        children: [
                          Text(
                            "Webinar by",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 12,
                              color: fontColor,
                            ),
                          ),
                          Text(
                            " Allen Career Institute",
                            style: SafeGoogleFont("Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                color: fontColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11, 9, 15, 8),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/page-1/images/clock.png",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "02:00 PM Onwards \n 15th Sep",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // const Spacer(),
                          // Row(
                          //   children: [
                          //     Image.asset(
                          //       "assets/page-1/images/persons.png",
                          //     ),
                          //     const SizedBox(
                          //       width: 3,
                          //     ),
                          //     Text(
                          //       "44/100",
                          //       style: SafeGoogleFont(
                          //         "Inter",
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w500,
                          //         color: fontColor,
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: Container(
                        height: 1,
                        color: const Color(0xffAFAFAF).withOpacity(0.54),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Details -",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            "\u2022 Online seminars establish you as an expert,a\n  trustworthy and reliable source of information\n\u2022 people are demonstrating an interest in what you are\n  offering – they become qualified leads\n\u2022 valuable content for your domain",
                            style: SafeGoogleFont("Inter",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.64),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 19),
                      child: Text(
                        "What will you Learn?",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 88,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: index == 0 ? 20 : 17,
                            ),
                            height: 88,
                            width: 144,
                            decoration: BoxDecoration(
                              color: const Color(0xffD9D9D9).withOpacity(0.65),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 11, 0, 11),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: SafeGoogleFont(
                                          "Inter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    index == 0
                                        ? "dfdfgdfg\r\ngf33tt"
                                        : index == 1
                                            ? "sdffds"
                                            : "Interactive learning",
                                    style: SafeGoogleFont(
                                      "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff414040),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 19, 15, 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Speaker Profile",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Companies of all types and sizes rely on user experience (UX) designers to help..",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 11.0,
          ),
          child: Card(
            color: Colors.white,
            child: customButton(
              context: context,
              onPressed: () {
                if (_isRegistrationStarting) {
                  const Text('Happened 2 days ago');
                } else {
                  const Text('Join Now');
                }
              },
              title:
                  _isRegistrationStarting ? 'Happened 2 days ago' : 'Join Now',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

const fontColor = Color(0xff8E8989);

Widget customButton({
  required BuildContext context,
  required VoidCallback onPressed,
  required String title,
}) {
  return SizedBox(
    width: double.infinity,
    height: 47,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: title.contains('Happened 2 days ago')
            ? Colors.black
            : Colors.white10,
        backgroundColor: title.contains('Happened 2 days ago')
            ? Colors.white10
            : const Color(0xff1F0A68),
      ),
      child: Text(
        title,
        style: SafeGoogleFont(
          "Inter",
          fontSize: 20,
          color: title.contains('Happened 2 days ago')
              ? Colors.black
              : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}














// import 'package:flutter/material.dart';
// import 'package:myapp/other/api_service.dart';
// import 'package:myapp/shared/colors_const.dart';
// import 'package:myapp/utils.dart';
// import 'package:myapp/webinar_page/webinar_model.dart';
// import 'package:myapp/widget/custom_webniar_card_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../other/provider/counsellor_details_provider.dart';

// class WebinarPastPage extends StatefulWidget {
//   const WebinarPastPage({Key? key}) : super(key: key);

//   @override
//   State<WebinarPastPage> createState() => _WebinarPastPageState();
// }

// class _WebinarPastPageState extends State<WebinarPastPage> {
//   void handleRegisterClick() {
//     // Implement the logic you want when the "Register Now" button is clicked
//     // For example, showing a message
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Registration'),
//         content: Text('You cannot register for past webinars.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //context.read<CounsellorDetailsProvider>().fetchWebinar_Data("Past");
//     context.read<CounsellorDetailsProvider>().fetchMyWebinar();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
//     return ListView.builder(
//       itemCount: counsellorSessionProvider.webinarList.length,
//       itemBuilder: (context, index) {
//         WebinarModel webinarModel = counsellorSessionProvider.webinarList[index];
//         return Padding(
//           padding: EdgeInsets.only(top: index == 0 ? 30 : 6, right: 16, left: 16),
//           child: CustomWebinarCard1(
//             showDuration: false,
//             title: "Learn more about CUET and IPMAT",
//             isRegisterNow: false,
//             btnTitle: "Happened 2 Days ago",
//             time: "15 Sep @ 2:00 PM Onwards",
//             duration: "60",
//             participants: "Unlimited",
//             bannerImg: "assets/page-1/images/webinarBanner.png",
//             onRegisterClicked: handleRegisterClick, // Passing callback function
//            webinarModel: webinarModel,
//           ),
//         );
//       },
//     );
//   }
// }

// // Widget customEnrollButton(
// //     {required VoidCallback onPresssed,
// //     required String title,
// //     required BuildContext context}) {
// //   return SizedBox(
// //     height: 30,
// //     width: 60,
// //     child: Container(
// //       decoration: BoxDecoration(
// //           color: const Color(0xff1F0A68),
// //           borderRadius: BorderRadius.circular(5),
// //           boxShadow: const [
// //             BoxShadow(
// //               blurRadius: 3,
// //               color: Colors.grey,
// //               spreadRadius: 0.1,
// //               offset: Offset(0, 3),
// //             )
// //           ]),
// //       child: Center(
// //         child: Text(
// //           title,
// //           textAlign: TextAlign.center,
// //           style: SafeGoogleFont(
// //             "Inter",
// //             color: Colors.white,
// //             fontSize: 10,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //     ),
// //   );
// // }


// class WebinarDetailsPageWidget1 extends StatefulWidget {
//   const WebinarDetailsPageWidget1({super.key});

//   @override
//   State<WebinarDetailsPageWidget1> createState() =>
//       _WebinarDetailsPageWidget1State();
// }

// class _WebinarDetailsPageWidget1State extends State<WebinarDetailsPageWidget1> {
//   late SharedPreferences _prefs;
//   bool _isRegistrationStarting = false;
//   var value;
//   var dataList;

//   @override
//   void initState() {
//     super.initState();
//     _initializeSharedPreferences();
//   }

//   Future<void> _initializeSharedPreferences() async {
//     value = await ApiService.getWebinarDetailsData('');
//     List<String> whatWill = ['what_will_you_learn'];
//     dataList = whatWill.length;
//     _prefs = await SharedPreferences.getInstance();
//     bool isStarting = _prefs.getBool('isRegistrationStarting') ?? false;
//     setState(() {
//       _isRegistrationStarting = isStarting;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 320,
//                   child: Stack(
//                     children: [
//                       Container(
//                         color: const Color(0xffffffff).withOpacity(0.8),
//                         width: double.infinity,
//                         height: 280,
//                         child: SafeArea(
//                           child: Padding(
//                             padding: const EdgeInsets.all(18.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: const Icon(
//                                     Icons.arrow_back_ios,
//                                     color: Color(0xff1F0A68),
//                                     size: 25,
//                                   ),
//                                 ),
//                                 Text('Webinar Details',style: SafeGoogleFont("Inter",
//                                     fontSize: 18, fontWeight: FontWeight.w600,color: ColorsConst.appBarColor),),
//                                 const Spacer(),
//                                 Image.asset(
//                                   "assets/page-1/images/share.png",
//                                   color: Color(0xff1F0A68),
//                                   height: 23,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SafeArea(
//                         child: Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 bottom: 28.0, right: 20, left: 20),
//                             child: Container(
//                               height: 196,
//                               width: double.maxFinite,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: const DecorationImage(
//                                   image: AssetImage(
//                                     "assets/page-1/images/webinarBanner.png",
//                                   ),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(11, 20, 12, 15),
//                       child: Expanded(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Learn more about CUET and IPMAT",
//                               style: SafeGoogleFont("Inter",
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xff414040)),
//                             ),
//                             Text(
//                               "60 min",
//                               style: SafeGoogleFont("Inter",
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: fontColor),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 11),
//                       child: Row(
//                         children: [
//                           Text(
//                             "Webinar by",
//                             style: SafeGoogleFont(
//                               "Inter",
//                               fontSize: 12,
//                               color: fontColor,
//                             ),
//                           ),
//                           Text(
//                             " Allen Career Institute",
//                             style: SafeGoogleFont("Inter",
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 fontStyle: FontStyle.italic,
//                                 color: fontColor),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(11, 9, 15, 8),
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             "assets/page-1/images/clock.png",
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             "02:00 PM Onwards \n 15th Sep",
//                             style: SafeGoogleFont(
//                               "Inter",
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           // const Spacer(),
//                           // Row(
//                           //   children: [
//                           //     Image.asset(
//                           //       "assets/page-1/images/persons.png",
//                           //     ),
//                           //     const SizedBox(
//                           //       width: 3,
//                           //     ),
//                           //     Text(
//                           //       "44/100",
//                           //       style: SafeGoogleFont(
//                           //         "Inter",
//                           //         fontSize: 12,
//                           //         fontWeight: FontWeight.w500,
//                           //         color: fontColor,
//                           //       ),
//                           //     )
//                           //   ],
//                           // ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 7,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 11),
//                       child: Container(
//                         height: 1,
//                         color: const Color(0xffAFAFAF).withOpacity(0.54),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Details -",
//                             style: SafeGoogleFont(
//                               "Inter",
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 9,
//                           ),
//                           Text(
//                             "\u2022 Online seminars establish you as an expert,a\n  trustworthy and reliable source of information\n\u2022 people are demonstrating an interest in what you are\n  offering – they become qualified leads\n\u2022 valuable content for your domain",
//                             style: SafeGoogleFont("Inter",
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                                 height: 1.64),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 19),
//                       child: Text(
//                         "What will you Learn?",
//                         style: SafeGoogleFont(
//                           "Inter",
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 88,
//                       child: ListView.builder(
//                         physics: const BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         itemCount: 2,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             margin: EdgeInsets.only(
//                               left: index == 0 ? 20 : 17,
//                             ),
//                             height: 88,
//                             width: 144,
//                             decoration: BoxDecoration(
//                               color: const Color(0xffD9D9D9).withOpacity(0.65),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(14, 11, 0, 11),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 20,
//                                     width: 20,
//                                     decoration: BoxDecoration(
//                                       color: Colors.black,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "${index + 1}",
//                                         style: SafeGoogleFont(
//                                           "Inter",
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     index == 0
//                                         ? "dfdfgdfg\r\ngf33tt"
//                                         : index == 1
//                                         ? "sdffds"
//                                         : "Interactive learning",
//                                     style: SafeGoogleFont(
//                                       "Inter",
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xff414040),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 19, 15, 19),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Speaker Profile",
//                         style: SafeGoogleFont(
//                           "Inter",
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Text(
//                         "Companies of all types and sizes rely on user experience (UX) designers to help..",
//                         style: SafeGoogleFont(
//                           "Inter",
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 11.0,
//           ),
//           child: Card(
//             color: Colors.white,
//             child: customButton(
//               context: context,
//               onPressed: () {
//                 if (_isRegistrationStarting) {
//                   const Text('Happened 2 days ago');
//                 } else {
//                   const Text('Join Now');
//                 }
//               },
//               title:
//                   _isRegistrationStarting ? 'Happened 2 days ago' : 'Join Now',
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//       ],
//     );
//   }
// }

// const fontColor = Color(0xff8E8989);

// Widget customButton({
//   required BuildContext context,
//   required VoidCallback onPressed,
//   required String title,
// }) {
//   return SizedBox(
//     width: double.infinity,
//     height: 47,
//     child: OutlinedButton(
//       onPressed: onPressed,
//       style: OutlinedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         foregroundColor: title.contains('Happened 2 days ago')
//             ? Colors.black
//             : Colors.white10,
//         backgroundColor: title.contains('Happened 2 days ago')
//             ? Colors.white10
//             : const Color(0xff1F0A68),
//       ),
//       child: Text(
//         title,
//         style: SafeGoogleFont(
//           "Inter",
//           fontSize: 20,
//           color: title.contains('Happened 2 days ago')
//               ? Colors.black
//               : Colors.white,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ),
//   );
// }
