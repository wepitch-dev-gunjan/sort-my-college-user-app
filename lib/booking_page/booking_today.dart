import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/booking_page/booking_confirmatoin_today.dart';
import 'package:myapp/utils.dart';

import '../other/api_service.dart';

class BookingToday extends StatefulWidget {
  const BookingToday({super.key});

  @override
  State<BookingToday> createState() => _BookingTodayState();
}

class _BookingTodayState extends State<BookingToday> {
  bool isLoading = true;
  List bookings = [];

  late var apiTime;
  late var todayTime;
  var currentTime;
  var remaning_time = "";

  @override
  void initState() {
    super.initState();

    getPastData();

    // todayTime = DateTime.now();
  }

  getPastData() async {
    final todayData = await ApiService.getUserBookings(
        past: false, today: true, upcoming: false);

    setState(() {
      bookings = todayData;
      isLoading = false;
    });
  }

  // Future<void> _refresh() async {
  //   return Future.delayed(const Duration(seconds: 1), () {
  //     context
  //         .read<UserBookingProvider>()
  //         .fetchUserBookings(past: false, today: true, upcoming: false);
  //   });
  // }

  // DateTime parseTiming(String time) {
  //   List<String> parts = time.split(":");

  //   return DateTime(
  //     DateTime.now().year,
  //     DateTime.now().month,
  //     DateTime.now().day,
  //     int.parse(parts[0]),
  //     int.parse(parts[1]),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    log("Today Data=>>>>>>$bookings");
    var mWidth = MediaQuery.sizeOf(context).width;

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : bookings.isEmpty
            ? Center(
                child: Text(
                  "No Bookings...",
                  style: SafeGoogleFont("Inter"),
                ),
              )
            : ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  var time =
                      "${bookings[index]['booking_data']["session_time"]}";
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Stack(
                        // fit: StackFit.expand,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            shadowColor: Colors.white,
                            // semanticContainer: false,
                            margin: const EdgeInsets.only(top: 5),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                    '${bookings[index]["booked_entity"]['profile_pic']}')),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${bookings[index]["booked_entity"]['name']}',
                                                  // bookings[index]
                                                  //         .booked_entity
                                                  //         ?.name ??
                                                  //     "Coming",
                                                  style: SafeGoogleFont(
                                                    "Inter",
                                                    fontSize: mWidth * 0.045,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  '${bookings[index]["booked_entity"]['designation']}',
                                                  // bookings[index]
                                                  //         .booked_entity
                                                  //         ?.email ??
                                                  //     'N/A',
                                                  // textAlign: TextAlign.left,
                                                  style: SafeGoogleFont(
                                                    "Inter",
                                                    color:
                                                        const Color(0xff747474),
                                                    fontSize: mWidth * 0.035,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Session starts at",
                                              style: SafeGoogleFont("Inter",
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: bookings[index][
                                                                      'booking_data']
                                                                  [
                                                                  "session_time"] !=
                                                              null
                                                          ? '${(bookings[index]['booking_data']["session_time"]! ~/ 60) % 12 == 0 ? 12 : (bookings[index]['booking_data']["session_time"]! ~/ 60) % 12}:${(bookings[index]['booking_data']["session_time"]! % 60).toString().padLeft(2, '0')} ${(bookings[index]['booking_data']["session_time"]! ~/ 60) < 12 ? 'AM' : 'PM'}'
                                                          : 'N/A',
                                                      style: SafeGoogleFont(
                                                          "Inter",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 20,
                                                          color: Colors.black)),
                                                  // TextSpan(
                                                  //     text: "m",
                                                  //     style: SafeGoogleFont("Inter",
                                                  //         fontWeight: FontWeight.w600,
                                                  //         fontSize: 14,
                                                  //         color: Colors.black))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            bookings[index]['booking_data']
                                                        ['session_type'] ==
                                                    'Group'
                                                ? SizedBox(
                                                    width: 118,
                                                    child: Text(
                                                      "${bookings[index]['booking_data']['session_topic']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: SafeGoogleFont(
                                                          "Inter",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              mWidth * 0.038,
                                                          color: const Color(
                                                              0xff1F0A68)),
                                                    ),
                                                  )
                                                : Text(
                                                    "${bookings[index]['booking_data']['session_type']}",
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                        "Inter",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize:
                                                            mWidth * 0.038,
                                                        color: const Color(
                                                            0xff1F0A68)),
                                                  ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: mWidth * 0.34,
                                              height: 24,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BookingConfirmationToday(
                                                        id: bookings[index]
                                                            ['_id'],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "View booking",
                                                      style: SafeGoogleFont(
                                                          "Inter",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              mWidth * 0.032,
                                                          color: Colors.black),
                                                    ))),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 7,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black54,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              width: 58,
                              height: 17,
                              child: Center(
                                child: Text(
                                  "Counsellor",
                                  style: SafeGoogleFont(
                                    "Inter",
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });

    //      return ListView(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 16),
    //       child: Container(
    //         margin: const EdgeInsets.only(bottom: 15),
    //         child: Stack(
    //           // fit: StackFit.expand,
    //           alignment: Alignment.bottomCenter,
    //           children: [
    //             Card(
    //               // semanticContainer: false,
    //               margin: const EdgeInsets.only(top: 5),
    //               elevation: 5,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(15)),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(12.0),
    //                 child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                             children: [
    //                               Image.asset(
    //                                 "assets/page-1/images/profile_booking.png",
    //                                 width: mWidth * 0.15,
    //                                 height: 60,
    //                               ),
    //                               const SizedBox(
    //                                 width: 7,
    //                               ),
    //                               Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     "Sandeep Mehra",
    //                                     style: SafeGoogleFont(
    //                                       "Inter",
    //                                       fontSize: mWidth * 0.045,
    //                                       fontWeight: FontWeight.w600,
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     "designer at wepitch",
    //                                     // textAlign: TextAlign.left,

    //                                     style: SafeGoogleFont(
    //                                       "Inter",
    //                                       color: const Color(0xff747474),
    //                                       fontSize: mWidth * 0.035,
    //                                       fontWeight: FontWeight.w600,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               )
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                       Row(
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Text(
    //                                 "Session starts in",
    //                                 style: SafeGoogleFont("Inter",
    //                                     fontSize: 12,
    //                                     color: Colors.black,
    //                                     fontWeight: FontWeight.bold),
    //                               ),
    //                               RichText(
    //                                   text: TextSpan(children: <TextSpan>[
    //                                 TextSpan(
    //                                     text: time,
    //                                     style: SafeGoogleFont("Inter",
    //                                         fontWeight: FontWeight.w600,
    //                                         fontSize: 20,
    //                                         color: Colors.black)),
    //                                 TextSpan(
    //                                     text: "m",
    //                                     style: SafeGoogleFont("Inter",
    //                                         fontWeight: FontWeight.w600,
    //                                         fontSize: 14,
    //                                         color: Colors.black))
    //                               ]))
    //                             ],
    //                           ),
    //                           const Spacer(),
    //                           Column(
    //                             children: [
    //                               Text(
    //                                 "Personal Session",
    //                                 style: SafeGoogleFont("Inter",
    //                                     fontWeight: FontWeight.w600,
    //                                     fontSize: mWidth * 0.038,
    //                                     color: const Color(0xff1F0A68)),
    //                               ),
    //                               const SizedBox(
    //                                 height: 5,
    //                               ),
    //                               SizedBox(
    //                                 width: mWidth * 0.34,
    //                                 height: 24,
    //                                 child: GestureDetector(
    //                                   onTap: () {
    //                                     // Navigator.push(
    //                                     //     context,
    //                                     //     MaterialPageRoute(
    //                                     //         builder: (context) =>
    //                                     //             const BookingConfirmationPage(
    //                                     //                 isUpcoming: false,
    //                                     //                 isConfirmed: true,
    //                                     //                 time: "25:15")));
    //                                   },
    //                                   child: Container(
    //                                       decoration: BoxDecoration(
    //                                         border: Border.all(),
    //                                         borderRadius:
    //                                             BorderRadius.circular(20),
    //                                  ),
    //                                       child: Center(
    //                                           child: Text(
    //                                         "View details",
    //                                         style: SafeGoogleFont("Inter",
    //                                             fontWeight: FontWeight.w600,
    //                                             fontSize: mWidth * 0.032,
    //                                             color: Colors.black),
    //                                       ))),
    //                                 ),
    //                               ),
    //                             ],
    //                           )
    //                         ],
    //                       )
    //                     ]),
    //               ),
    //             ),
    //             Positioned(
    //               top: 0,
    //               left: 7,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     border: Border.all(
    //                       color: Colors.black54,
    //                     ),
    //                     borderRadius: BorderRadius.circular(10)),
    //                 width: 58,
    //                 height: 17,
    //                 child: Center(
    //                   child: Text(
    //                     "Counsellor",
    //                     style: SafeGoogleFont(
    //                       "Inter",
    //                       fontSize: 8,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 16),
    //       child: Container(
    //         margin: const EdgeInsets.only(bottom: 15),
    //         child: Stack(
    //           // fit: StackFit.expand,
    //           alignment: Alignment.bottomCenter,
    //           children: [
    //             Card(
    //               // semanticContainer: false,
    //               margin: const EdgeInsets.only(top: 5),
    //               elevation: 5,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(15)),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(12.0),
    //                 child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                             children: [
    //                               Image.asset(
    //                                 "assets/page-1/images/profile_booking.png",
    //                                 width: mWidth * 0.15,
    //                                 height: 60,
    //                               ),
    //                               const SizedBox(
    //                                 width: 7,
    //                               ),
    //                               Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     "Sandeep Mehra",
    //                                     style: SafeGoogleFont(
    //                                       "Inter",
    //                                       fontSize: mWidth * 0.045,
    //                                       fontWeight: FontWeight.w600,
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     "designer at wepitch",
    //                                     // textAlign: TextAlign.left,

    //                                     style: SafeGoogleFont(
    //                                       "Inter",
    //                                       color: const Color(0xff747474),
    //                                       fontSize: mWidth * 0.035,
    //                                       fontWeight: FontWeight.w600,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               )
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                       Row(
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           const Spacer(),
    //                           Column(
    //                             children: [
    //                               Text(
    //                                 "Group Session",
    //                                 style: SafeGoogleFont("Inter",
    //                                     fontWeight: FontWeight.w600,
    //                                     fontSize: mWidth * 0.038,
    //                                     color: const Color(0xff1F0A68)),
    //                               ),
    //                               const SizedBox(
    //                                 height: 5,
    //                               ),
    //                               SizedBox(
    //                                 width: mWidth * 0.34,
    //                                 height: 24,
    //                                 child: GestureDetector(
    //                                   onTap: () {
    //                                     // Navigator.push(
    //                                     //     context,
    //                                     //     MaterialPageRoute(
    //                                     //         builder: (context) =>
    //                                     //             const BookingConfirmationPage(
    //                                     //                 isUpcoming: false,
    //                                     //                 isConfirmed: true,
    //                                     //                 time: "25:15")));
    //                                   },
    //                                   child: Container(
    //                                       decoration: BoxDecoration(
    //                                         border: Border.all(),
    //                                         borderRadius:
    //                                             BorderRadius.circular(20),
    //                                       ),
    //                                       child: Center(
    //                                           child: Text(
    //                                         "View details",
    //                                         style: SafeGoogleFont("Inter",
    //                                             fontWeight: FontWeight.w600,
    //                                             fontSize: mWidth * 0.032,
    //                                             color: Colors.black),
    //                                       ))),
    //                                 ),
    //                               ),
    //                             ],
    //                           )
    //                         ],
    //                       )
    //                     ]),
    //               ),
    //             ),
    //             Positioned(
    //               top: 0,
    //               left: 7,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     border: Border.all(
    //                       color: Colors.black54,
    //                     ),
    //                     borderRadius: BorderRadius.circular(10)),
    //                 width: 58,
    //                 height: 17,
    //                 child: Center(
    //                   child: Text(
    //                     "Counsellor",
    //                     style: SafeGoogleFont(
    //                       "Inter",
    //                       fontSize: 8,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 16),
    //       child: Container(
    //         margin: const EdgeInsets.only(bottom: 15),
    //         child: Stack(
    //           // fit: StackFit.expand,
    //           alignment: Alignment.bottomCenter,
    //           children: [
    //             Card(
    //               // semanticContainer: false,
    //               margin: const EdgeInsets.only(top: 5),
    //               elevation: 5,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(15)),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(12.0),
    //                 child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                             children: [
    //                               Image.asset(
    //                                 "assets/page-1/images/profile_booking.png",
    //                                 width: mWidth * 0.15,
    //                                 height: 60,
    //                               ),
    //                               const SizedBox(
    //                                 width: 7,
    //                               ),
    //                               Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     "Sandeep Mehra",
    //                                     style: SafeGoogleFont(
    //                                       "Inter",
    //                                       fontSize: mWidth * 0.045,
    //                                       fontWeight: FontWeight.w600,
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     "designer at wepitch",
    //                                     // textAlign: TextAlign.left,

    //                                     style: SafeGoogleFont(
    //                                       "Inter",
    //                                       color: const Color(0xff747474),
    //                                       fontSize: mWidth * 0.035,
    //                                       fontWeight: FontWeight.w600,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               )
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                       Row(
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           const Spacer(),
    //                           Column(
    //                             children: [
    //                               SizedBox(
    //                                 width: mWidth * 0.34,
    //                                 height: 24,
    //                                 child: GestureDetector(
    //                                   onTap: () {
    //                                     // Navigator.push(
    //                                     //     context,
    //                                     //     MaterialPageRoute(
    //                                     //         builder: (context) =>
    //                                     //             const BookingConfirmationPage(
    //                                     //                 isUpcoming: true,
    //                                     //                 isConfirmed: true,
    //                                     //                 time: "10:44")));
    //                                   },
    //                                   child: Container(
    //                                       decoration: BoxDecoration(
    //                                         border: Border.all(),
    //                                         borderRadius:
    //                                             BorderRadius.circular(20),
    //                                       ),
    //                                       child: Center(
    //                                           child: Text(
    //                                         "View details",
    //                                         style: SafeGoogleFont("Inter",
    //                                             fontWeight: FontWeight.w600,
    //                                             fontSize: mWidth * 0.032,
    //                                             color: Colors.black),
    //                                       ))),
    //                                 ),
    //                               ),
    //                             ],
    //                           )
    //                         ],
    //                       )
    //                     ]),
    //               ),
    //             ),
    //             Positioned(
    //               top: 0,
    //               left: 7,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     border: Border.all(
    //                       color: Colors.black54,
    //                     ),
    //                     borderRadius: BorderRadius.circular(10)),
    //                 width: 58,
    //                 height: 17,
    //                 child: Center(
    //                   child: Text(
    //                     "Counsellor",
    //                     style: SafeGoogleFont(
    //                       "Inter",
    //                       fontSize: 8,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  parseDuration(String durationString) {
    List<String> components = durationString.split(':');

    int hours = int.parse(components[0]);
    int minutes = int.parse(components[1]);
    //int seconds = int.parse(components[2]);

    return Duration(hours: hours, minutes: minutes, seconds: 0);
  }
}

// model for past bookings
// class PastModel {
//   PastModel(
//       {required this.name,
//       required this.session,
//       required this.role,
//       required this.date,
//       required this.company,
//       required this.img,
//       required this.isAttended});
//   final String name;
//   final String role;
//   final String session;
//   final String img;
//   final String company;
//   final bool isAttended;
//   final String date;
// }

// // dummy data for past bookings
// List<PastModel> listPastBookings = [
//   PastModel(
//       name: "Sandeep Mehra",
//       session: "Personal Session",
//       role: "Counsellor",
//       date: "10:44",
//       company: "designer at wepitch",
//       img: "assets/page-1/images/profile_booking.png",
//       isAttended: true),
//   PastModel(
//       name: "Sandeep Mehra",
//       session: "Group Session",
//       role: "Counsellor",
//       date: "11:31",
//       company: "designer at wepitch",
//       img: "assets/page-1/images/profile_booking.png",
//       isAttended: false),
//   PastModel(
//       name: "Sandeep Mehra",
//       session: "Group Session",
//       role: "EP",
//       date: "11:31",
//       company: "designer at wepitch",
//       img: "assets/page-1/images/profile_booking.png",
//       isAttended: false),
// ];
