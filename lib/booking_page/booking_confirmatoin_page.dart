import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jiffy/jiffy.dart';
import 'package:myapp/model/booking_model.dart';
import 'package:myapp/other/constants.dart';
import 'package:myapp/utils/common.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils.dart';

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage(
      {super.key,
      required this.isUpcoming,
      required this.isConfirmed,
      required this.time,
      required this.designation,
      required this.bookingData,
      required this.counsellorDetails,
      required this.remainingTimestr});

  //final Duration remainingTime;

  final String remainingTimestr;

  final bool isUpcoming;
  final String time;
  final String designation;
  final bool isConfirmed;

  final BookingData bookingData;
  final BookedEntity counsellorDetails;

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configLoading();
  }

  bool isExpired = false;
  @override
  Widget build(BuildContext context) {
    /* isExpired = (widget.remainingTime.inMinutes +
        (widget.bookingData.sessionDuration ?? 0)) <
        0;*/

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        EasyLoading.dismiss();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: AppColors.whiteColor,
          backgroundColor: const Color(0xffffffff),
          foregroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
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
        body: Container(
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 11,
                    ),
                    Image.asset(
                      "${AppConstants.imagePath}${widget.bookingData.sessionStatus == "Available" || widget.bookingData.sessionStatus == "Booked" ? "booking-confirm.png" : "booking-cancel.png"}",
                      height: 105,
                      width: 105,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.isConfirmed
                          ? "BOOKING CONFIRMED"
                          : "BOOKING CANCELED",
                      style: SafeGoogleFont("Inter", fontSize: 14),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                                widget.isUpcoming
                                    ? "Meeting starts at"
                                    : "Session starts in",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              widget.isUpcoming
                                  ? Text(
                                      // convertSessionTime(widget.time),,
                                      "${widget.time} pm",
                                      style: SafeGoogleFont(
                                        "Inter",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        decorationColor: Colors.red,
                                        decoration: widget.isConfirmed
                                            ? TextDecoration.none
                                            : TextDecoration.lineThrough,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          convertSessionTime(
                                              widget.remainingTimestr),
                                          // widget
                                          //     .remainingTimestr /*  "${widget.remainingTime.inHours < 0 ? "" : widget.remainingTime.inHours}:${widget.remainingTime.inMinutes.remainder(60) < 0 ? '0' : widget.remainingTime.inMinutes.remainder(60)}" */,
                                          style: SafeGoogleFont(
                                            "Inter",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          Column(
                            children: [
                              customButton(
                                  context: context,
                                  onPressed: () {
                                    _launchURL(widget.bookingData.sessionLink!,
                                        context);

                                    /*if (!((widget.remainingTime.inMinutes +
                                        (widget.bookingData.sessionDuration ??
                                            0)) <
                                        0)) {
                                      _launchURL(widget.bookingData.sessionLink!,
                                          context);
                                    }*/
                                  },
                                  title: "JOIN NOW",
                                  isActive: isExpired),
                              const SizedBox(
                                height: 4,
                              ),
                              widget.isUpcoming
                                  ? const SizedBox()
                                  : Text(
                                      "Host has joined",
                                      style: SafeGoogleFont("Inter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff1F0A68)),
                                    ),
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
                            backgroundImage: NetworkImage(widget
                                    .counsellorDetails.profilePic ??
                                "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw="),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.counsellorDetails.name ?? "N/A",
                                style: SafeGoogleFont("Inter",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    height: 1),
                              ),
                              Text(
                                /*widget.counsellorDetails.qualifications!
                                    .isNotEmpty &&
                                    widget.counsellorDetails
                                        .qualifications![0] != null
                                    ? widget.counsellorDetails.qualifications![0]
                                    : 'N/A'.toString()*/

                                widget.designation,
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff747474),
                                ),
                              )
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
                        "Session Detail",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 22,
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
                            " : ${widget.bookingData.id}",
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
                            "Session Type",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            " : ${widget.bookingData.sessionType} Session",
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
                            " : ${Jiffy.parse(widget.bookingData.sessionDate!).format(pattern: 'dd/MM/yyyy')}",
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
                            "Session Time",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Text(
                            " : ${convertSessionTime(widget.bookingData.sessionTime!)}",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                            ),
                          ),

                          // Text(
                          //   '${(int.parse(widget.bookingData.sessionTime!) ~/ 60) % 12}:${(int.parse(widget.bookingData.sessionTime!) % 60).toString().padLeft(2, '0')} ${(int.parse(widget.bookingData.sessionTime!) ~/ 60) < 12 ? 'AM' : 'PM'}',
                          //   style: const TextStyle(
                          //     color: Color(0xFF414040),
                          //     fontSize: 12,
                          //     fontFamily: 'Inter',
                          //     fontWeight: FontWeight.w400,
                          //     height: 0.08,
                          //   ),
                          // ),

                          // Text(
                          //   " : ${widget.bookingData.sessionTime}",
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
                            " : ${widget.bookingData.sessionFee}/-",
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
                            " : ${widget.bookingData.sessionStatus}",
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
                            " : ${widget.bookingData.sessionAvailableSlots}/${widget.bookingData.sessionSlots}",
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
                            " : ${Jiffy.parse(widget.bookingData.createdAt!).format(pattern: 'dd/MM/yyyy')}",
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
                            " : ${Jiffy.parse(widget.bookingData.updatedAt!).format(pattern: 'dd/MM/yyyy')}",
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 14,
                            ),
                          )
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
                // Padding(
                //   padding: const EdgeInsets.only(left: 14, top: 10),
                //   child: Row(
                //     children: [
                //       Text(
                //         "Booking Amount",
                //         style: SafeGoogleFont(
                //           "Inter",
                //           fontSize: 14,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       Text(
                //         " : ${widget.bookingData.sessionStatus}",
                //         style: SafeGoogleFont(
                //           "Inter",
                //           fontSize: 14,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 14, top: 10),
                //   child: Row(
                //     children: [
                //       Text(
                //         "18% GST",
                //         style: SafeGoogleFont(
                //           "Inter",
                //           fontSize: 14,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       Text(
                //         " : ${widget.bookingData.sessionStatus}",
                //         style: SafeGoogleFont(
                //           "Inter",
                //           fontSize: 14,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 14, top: 10),
                //   child: Row(
                //     children: [
                //       Text(
                //         "Convenience fee",
                //         style: SafeGoogleFont(
                //           "Inter",
                //           fontSize: 14,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       Text(
                //         " : ${widget.bookingData.sessionStatus}",
                //         style: SafeGoogleFont(
                //           "Inter",
                //           fontSize: 14,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String convertTime(int? sessionTime) {
  if (sessionTime != null) {
    int hours = sessionTime ~/ 60;
    int minutes = sessionTime % 60;
    String period = (hours < 12) ? 'AM' : 'PM';
    hours = hours % 12;
    if (hours == 0) {
      hours = 12;
    }
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $period';
  } else {
    return 'N/A';
  }
}

Widget customButton(
    {required BuildContext context,
    required VoidCallback onPressed,
    required String title,
    required bool isActive}) {
  return SizedBox(
      width: 137,
      height: 38,
      child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
              foregroundColor:
                  isActive ? const Color(0xff9C9A9A) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor:
                  isActive ? const Color(0xffDFDFDF) : const Color(0xff1F0A68)),
          child: Text(
            title,
            style: SafeGoogleFont(
              "Inter",
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 60
    ..textColor = Colors.black
    ..radius = 20
    ..backgroundColor = Colors.transparent
    ..maskColor = Colors.white
    ..indicatorColor = const Color(0xff1f0a68)
    ..userInteractions = false
    ..dismissOnTap = false
    ..boxShadow = <BoxShadow>[]
    ..indicatorType = EasyLoadingIndicatorType.circle;
}

void _launchURL(String url, BuildContext context) async {
  EasyLoading.show(status: "Loading...", dismissOnTap: true);
  var uri = Uri.parse(url);
  await launchUrl(uri).then((value) {
    if (value) {
      EasyLoading.dismiss();
    } else {
      EasyLoading.showToast("Unable to Open..",
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  });

  /*if (!await canLaunchUrl(uri))
  {
    await launchUrl(uri).then((value)
    {
      if (value) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.showToast("Unable to Open..",
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }*/
}
