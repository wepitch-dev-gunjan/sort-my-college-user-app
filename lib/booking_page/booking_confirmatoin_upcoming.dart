import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myapp/other/constants.dart';
import '../common/url_launcher.dart';
import '../other/api_service.dart';
import '../shared/colors_const.dart';
import '../utils.dart';
import 'booking_confirmatoin_past.dart';

class BookingConfirmationUpcoming extends StatefulWidget {
  final String id;
  final String bookingID;

  const BookingConfirmationUpcoming(
      {super.key, required this.id, required this.bookingID});

  @override
  State<BookingConfirmationUpcoming> createState() =>
      _BookingConfirmationUpcomingState();
}

class _BookingConfirmationUpcomingState
    extends State<BookingConfirmationUpcoming> {
  bool isLoading = true;
  var booking;
  var canJoin = false;

  @override
  void initState() {
    super.initState();
    getUpcomingBooking(widget.id);
    isSessionAboutToStart(widget.bookingID);
  }

  getUpcomingBooking(String id) async {
    final response = await ApiService.getUserBooking(
        today: false, past: false, upcoming: true, id: id);

    setState(() {
      booking = response;
      isLoading = false;
    });
  }

  isSessionAboutToStart(String id) async {
    final response = await ApiService.isSessionAboutToStart(id: id);
    log("respo123$response");
    setState(() {
      canJoin = response['isAboutToStart'];
      isLoading = false;
    });
  }

  bool isExpired = false;
  bool isUpcoming = false;
  bool isConfirmed = true;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    var bookingSlot = booking['booking_data']['session_slots'] -
        booking['booking_data']['session_available_slots'];

    String sessionDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(booking['booking_data']['session_date']));

    int sessionDuration = booking['booking_data']['session_duration'] ?? 0;

    String sessionTime = booking['booking_data']['session_time'] != null
        ? '${(booking['booking_data']['session_time']! ~/ 60) % 12 == 0 ? 12 : (booking['booking_data']['session_time']! ~/ 60) % 12}:${(booking['booking_data']['session_time']! % 60).toString().padLeft(2, '0')} ${(booking['booking_data']['session_time']! ~/ 60) < 12 ? 'AM' : 'PM'}'
        : 'N/A';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        backgroundColor: const Color(0xffffffff),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/page-1/images/back.png',
              color: const Color(0xff1F0A68),
            ),
          ),
        ),
        title: Text(
          "My Booking",
          style: SafeGoogleFont("Inter",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xff1F0A68)),
        ),
      ),
      body: booking.isEmpty
          ? const Center(
              child: Text("No data"),
            )
          : Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 26),
              decoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(
                width: 0.5,
                color: Colors.grey,
              ))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 11,
                        ),
                        Image.asset(
                          "${AppConstants.imagePath}${booking['booking_data']['session_status'] == "Available" || booking['booking_data']['session_status'] == "Booked" ? "bookingimg.png" : "bookingimg.png"}",
                          height: 105,
                          width: 105,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          isSessionExpired(
                                  sessionDate, sessionTime, sessionDuration)
                              ? "Session Expired"
                              : "Session Booked",
                          style: SafeGoogleFont("Inter", fontSize: 14),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Session starts at",
                                    style: SafeGoogleFont(
                                      "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  isSessionExpired(sessionDate, sessionTime,
                                          sessionDuration)
                                      ? Text(
                                          "Session Closed",
                                          style: SafeGoogleFont(
                                            "Inter",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.red,
                                            decoration: isConfirmed
                                                ? TextDecoration.none
                                                : TextDecoration.lineThrough,
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              '${(booking['booking_data']['session_time']! ~/ 60) % 12 == 0 ? 12 : (booking['booking_data']['session_time']! ~/ 60) % 12}:${(booking['booking_data']['session_time']! % 60).toString().padLeft(2, '0')} ${(booking['booking_data']['session_time']! ~/ 60) < 12 ? 'AM' : 'PM'}',
                                              style: SafeGoogleFont(
                                                "Inter",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "",
                                              style: SafeGoogleFont(
                                                "Inter",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                ],
                              ),
                              Column(
                                children: [
                                  customButton(
                                    context: context,
                                    onPressed: () {
                                      if (!canJoin) {
                                        if (isSessionExpired(sessionDate,
                                            sessionTime, sessionDuration)) {
                                          Fluttertoast.showToast(
                                              msg: 'Event has been done');
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'The session will start 10 minutes early.');
                                        }
                                      } else {
                                        launchURL(
                                          booking['booking_data']
                                              ['session_link'],
                                          context,
                                        );
                                      }
                                    },
                                    title: "JOIN NOW",
                                    sessionDate: sessionDate,
                                    sessionTime: sessionTime,
                                    sessionDuration: sessionDuration,
                                    canJoin: canJoin,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  // widget.isUpcoming
                                  //     ? const SizedBox()
                                  //     : Text(
                                  //         "Host has joined",
                                  //         style: SafeGoogleFont("Inter",
                                  //             fontSize: 12,
                                  //             fontWeight: FontWeight.w600,
                                  //             color: Colors.grey),
                                  //       )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 14,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    "${booking['booked_entity']['profile_pic']}"
                                    // widget
                                    //       .counsellorDetails.profilePic ??
                                    //   "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
                                    ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking['booked_entity']['name'],
                                    style: SafeGoogleFont("Inter",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        height: 1),
                                  ),
                                  booking['booked_entity']['designation'] !=
                                          null
                                      ? Text(
                                          booking['booked_entity']
                                              ['designation'],
                                          style: SafeGoogleFont(
                                            "Inter",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff747474),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                          width: double.infinity,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Session Details",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 24,
                              color: const Color(0xff1F0A68),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Text(
                                "Session ID",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " : ${booking['booking_data']['_id']}",

                                // " : ${widget.bookingData.id}",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          booking['booking_data']['session_type'] == 'Group'
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Session Topic : ",
                                        style: SafeGoogleFont(
                                          "Inter",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${booking['booking_data']['session_topic']}",
                                          style: SafeGoogleFont(
                                            "Inter",
                                            fontSize: 14,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                "Session Type",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " : ${booking['booking_data']['session_type']}",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                "Session Date",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              Text(
                                " : $sessionDate",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )
                              // Text(
                              //   " : ${booking['booking_data']['session_date']}",
                              //   style: SafeGoogleFont(
                              //     "Inter",
                              //     fontSize: 14,
                              //   ),
                              // )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                "Session Time : ",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                sessionTime,
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "Session Duration : ",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              Text(
                                "$sessionDuration min.",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )

                              // Text(
                              //   " :${booking['booking_data']['session_time']}",
                              //   style: SafeGoogleFont(
                              //     "Inter",
                              //     fontSize: 14,
                              //   ),
                              // )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                "Session Amount",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " : ${booking['booking_data']['session_fee']}",
                                // " : ${widget.bookingData.sessionFee}/-",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                "Session Status",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " : ${booking['booking_data']['session_status']}",
                                // " : ${widget.bookingData.sessionStatus} Closed",

                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                "Booked Slots",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " : $bookingSlot/${booking['booking_data']['session_slots']}",
                                // " : ${widget.bookingData.sessionAvailableSlots}/${widget.bookingData.sessionSlots}",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                "Created at",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(booking['booking_data']['createdAt']))}",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                "Updated",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              Text(
                                " : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(booking['booking_data']['updatedAt']))}",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 14,
                                ),
                              )
                              // Text(
                              //   "last",
                              //   // " : ${Jiffy.parse(widget.bookingData.updatedAt!).format(pattern: 'dd/MM/yyyy')}",
                              //   style: SafeGoogleFont(
                              //     "Inter",
                              //     fontSize: 14,
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                      height: 0.5,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(
                        "Payment Details",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 24,
                          color: const Color(0xff1F0A68),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 20),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Session Type",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${booking['booking_data']['session_type']}",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 20),
                      child: Row(
                        children: [
                          Text(
                            "Session Fees",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "\u{20B9}${booking['booking_data']['session_fee']}",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 20),
                      child: Row(
                        children: [
                          Text(
                            "GST",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "\u{20B9}${(booking['booking_data']['session_fee'] * 0.18).toInt()}",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 20),
                      child: Row(
                        children: [
                          Text(
                            "Getway Charge",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "\u{20B9}${(booking['booking_data']['session_fee'] * 0.05).toInt()}",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 20),
                      child: Row(
                        children: [
                          Text(
                            "Total Amount",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "\u{20B9}${(booking['booking_data']['session_fee'] * 0.18).toInt() + (booking['booking_data']['session_fee'] * 0.05).toInt() + (booking['booking_data']['session_fee'])}",
                            style: const TextStyle(
                              color: ColorsConst.blackColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 50.0)
                  ],
                ),
              ),
            ),
    );
  }
}
