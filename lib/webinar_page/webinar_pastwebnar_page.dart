import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/home_page/homepage.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/webinar_page/webinar_model.dart';
import 'package:myapp/widget/webinar_detail_page_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebinarPastDataPage extends StatefulWidget {
  const WebinarPastDataPage({super.key});

  @override
  State<WebinarPastDataPage> createState() => _WebinarPastDataPageState();
}

class _WebinarPastDataPageState extends State<WebinarPastDataPage> {
  @override
  void initState() {
    super.initState();
    context.read<CounsellorDetailsProvider>().fetchWebinar_Data("MyWebinars");
    // context.read<CounsellorDetailsProvider>().fetchMyWebinar();
  }

  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    bool isLoading = context.watch<CounsellorDetailsProvider>().isLoading;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : counsellorSessionProvider.webinarList.isEmpty
            ? Center(
                child: Text(
                  "No Webinar",
                  style: SafeGoogleFont("Inter"),
                ),
              )
            : ListView.builder(
                itemCount: counsellorSessionProvider.webinarList.length,
                itemBuilder: (context, index) {
                  // Reverse the list
                  List<WebinarModel> reversedList =
                      counsellorSessionProvider.webinarList.reversed.toList();
                  WebinarModel webinarModel = reversedList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                    child: WebinarPastDataWidget(
                      showDuration: false,
                      title: "Learn more about CUET and IPMAT",
                      isRegisterNow: true,
                      btnTitle: "Register Now",
                      time: "15 Sep @ 2:00 PM Onwards",
                      duration: "60",
                      participants: "Unlimited",
                      bannerImg: "assets/page-1/images/webinarBanner.png",
                      webinarModel: webinarModel,
                    ),
                  );
                },
              );
  }
}

class WebinarPastDataWidget extends StatefulWidget {
  const WebinarPastDataWidget(
      {super.key,
      required this.isRegisterNow,
      required this.btnTitle,
      required this.time,
      required this.duration,
      required this.participants,
      required this.bannerImg,
      required this.title,
      required this.showDuration,
      this.enableAutoScroll = false,
      required this.webinarModel});

  final bool isRegisterNow;
  final String btnTitle;
  final String title;
  final String time;
  final String duration;
  final String participants;
  final String bannerImg;
  final bool showDuration;
  final bool enableAutoScroll;
  final WebinarModel webinarModel;

  @override
  State<WebinarPastDataWidget> createState() => _WebinarPastDataWidgetState();
}

class _WebinarPastDataWidgetState extends State<WebinarPastDataWidget> {
  late SharedPreferences _prefs;
  bool _isRegistrationStarting = false;
  String register_status = '';
  String webinarData = '';

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    bool isStarting = _prefs.getBool('isRegistrationStarting') ?? false;

    if (isStarting) {
      DateTime savedTime = DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt('startingTimestamp') ?? 0,
      );

      DateTime currentTime = DateTime.now();
      if (currentTime.difference(savedTime).inDays >= 3) {
        await _updateRegistrationStatus(false);
      } else {
        setState(() {
          _isRegistrationStarting = true;
        });
      }
    }
  }

  Future<void> _updateRegistrationStatus(bool isStarting) async {
    setState(() {
      _isRegistrationStarting = isStarting;
    });

    if (isStarting) {
      await _prefs.setInt(
          'startingTimestamp', DateTime.now().millisecondsSinceEpoch);
    } else {
      await _prefs.remove('startingTimestamp');
    }

    await _prefs.setBool('isRegistrationStarting', isStarting);
  }

  static dateTimeDif() {
    DateTime dt1 = DateTime.parse("2024-03-28 06:30:00");
    DateTime dt2 = DateTime.parse("2024-03-28 05:30:00");

    Duration diff = dt1.difference(dt2);

//print(diff.inDays);
//output (in days): 1198

    print(diff.inMinutes);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: cardView(context),
    );
  }

  Widget cardView(BuildContext context) {
    bool has24HoursPassed = false;
    DateTime registrationDate =
        DateTime.parse(widget.webinarModel.resisterDate!);
    Duration difference = DateTime.now().difference(registrationDate);
    var pastdays;
    if (difference.inHours >= 24) {
      has24HoursPassed = true;
      pastdays = difference.inDays;
    } else {
      has24HoursPassed = false;
    }

    bool isRegistered = widget.webinarModel.registered;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebinarDetailsPageWidget(
              registerdDate: widget.webinarModel.resisterDate,
              webinarId: widget.webinarModel.id!,
              webinarImg: widget.webinarModel.webinarImage!,
              webinarTitle: widget.webinarModel.webinarTitle!,
              webinarDate: widget.webinarModel.webinarDate!,
              webinarBy: widget.webinarModel.webinarBy!,
              webinarStartDays: widget.webinarModel.webnar_startdays!,
              webinarRegister: widget.webinarModel.registered,
              registrationDate: registrationDate,
              webinarJoinUrl: widget.webinarModel.joinUrl!,
              canJoin: widget.webinarModel.canJoin,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190,
                  // width: 390,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image:
                            NetworkImage('${widget.webinarModel.webinarImage}'),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.webinarModel.webinarTitle}',
                        // '${widget.webinarModel.webinarBy}',
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.webinarModel.webinarDate}',
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${widget.webinarModel.webinarBy}',
                            overflow: TextOverflow.ellipsis,
                            style: SafeGoogleFont(
                              "Inter",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: const Color(0xffAFAFAF),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Share.share(widget.webinarModel.joinUrl!);
                              },
                              child: Center(
                                child: Image.asset(
                                  "assets/page-1/images/group-38-oFX.png",
                                  width: 20,
                                  height: 20,
                                  color: const Color(0xff1F0A68),
                                ),
                              ),
                            ),

                            RegisterNowWidget(
                              onPressed: () async {
                                var daysDifference = calculateDaysDifference(
                                    registeredDate:
                                        widget.webinarModel.resisterDate!,
                                    webinarRegister:
                                        widget.webinarModel.registered,
                                    canJoin: widget.webinarModel.canJoin!);

                                if (!isRegistered) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Register"),
                                        content: const Text(
                                          "Are you sure you want to register for this webinar?",
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Yes"),
                                            onPressed: () async {
                                              await ApiService.webinar_register(
                                                  widget.webinarModel.id!);
                                              setState(() {
                                                isRegistered = true;
                                                widget.webinarModel.registered =
                                                    true;
                                                // widget. = true;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (daysDifference == 0 &&
                                    isRegistered &&
                                    widget.webinarModel.canJoin == true) {
                                  launchUrlString(widget.webinarModel.joinUrl!);
                                }
                              },
                              regdate: widget.webinarModel.resisterDate,
                              isRegisterNow: widget.webinarModel.registered,
                              canJoin: widget.webinarModel.canJoin!,
                            )

                            // RegisterNowWidget(

                            //     regdate: widget.webinarModel.resisterDate,
                            //     isRegisterNow: widget.webinarModel.registered),
                            // customRegisterNow(
                            //     onPressed: () async {
                            //       // log("MyWebinar=>>>>>>>>${widget.webinarModel.registered}");
                            //       _isRegistrationStarting =
                            //           widget.webinarModel.registered;
                            //       if (has24HoursPassed) {
                            //         Fluttertoast.showToast(
                            //             msg:
                            //                 'Webinar Happened $pastdays days ago');
                            //       } else {
                            //         if (widget.webinarModel.registered &&
                            //             widget.webinarModel.webnar_startdays ==
                            //                 0) {
                            //         } else if (_isRegistrationStarting) {
                            //           Fluttertoast.showToast(
                            //               msg:
                            //                   'Participant is already registered');
                            //         } else {
                            //           showDialog(
                            //             context: context,
                            //             builder: (context) {
                            //               return AlertDialog(
                            //                 title: const Text(
                            //                   'Do you want to register for the webinar?',
                            //                   style: TextStyle(
                            //                     fontSize: 16,
                            //                   ),
                            //                 ),
                            //                 actions: [
                            //                   TextButton(
                            //                     onPressed: () {
                            //                       Navigator.pop(context);
                            //                     },
                            //                     child: const Text('Cancel'),
                            //                   ),
                            //                   TextButton(
                            //                     onPressed: () async {
                            //                       if (_isRegistrationStarting) {
                            //                         Fluttertoast.showToast(
                            //                             msg:
                            //                                 'Participant is already registered');
                            //                         Navigator.pop(context);
                            //                       } else {
                            //                         var value = await ApiService
                            //                             .webinar_register(widget
                            //                                 .webinarModel.id!);
                            //                         if (value["error"] ==
                            //                             "Participant is already registered") {
                            //                           Fluttertoast.showToast(
                            //                               msg:
                            //                                   'Participant is already registered');
                            //                         } else if (value[
                            //                                 "message"] ==
                            //                             "Registration completed") {
                            //                           Fluttertoast.showToast(
                            //                               msg:
                            //                                   'Registration completed. Thanks for registering');
                            //                           widget.webinarModel
                            //                               .registered = true;
                            //                         }
                            //                         if (mounted) {
                            //                           Navigator.pop(context);
                            //                         }
                            //                         await _updateRegistrationStatus(
                            //                             true);
                            //                       }
                            //                     },
                            //                     child: const Text('Yes'),
                            //                   ),
                            //                 ],
                            //               );
                            //             },
                            //           );
                            //         }
                            //       }
                            //     },
                            //     title: widget.webinarModel.registered
                            //         ? (widget.webinarModel.webnar_startdays == 0
                            //             ? 'Join Now'
                            //             : (has24HoursPassed
                            //                 ? 'Happened $pastdays days ago'
                            //                 : 'Starting in ${widget.webinarModel.webnar_startdays} days'))
                            //         : 'Register Now',
                            //     isRegisterNow: has24HoursPassed
                            //         ? false
                            //         : widget.webinarModel.registered),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customRegisterNow({
    required VoidCallback onPressed,
    required String title,
    required bool isRegisterNow,
  }) {
    Color buttonColor =
        isRegisterNow ? const Color(0xff1F0A68) : ColorsConst.grayColor;
    Color textColor = isRegisterNow ? Colors.white : Colors.black;

    return SizedBox(
      height: 35,
      width: 238,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: ColorsConst.whiteColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          foregroundColor: textColor,
          backgroundColor: buttonColor,
        ),
        child: Text(
          title,
          style: SafeGoogleFont(
            "Inter",
            fontSize: 15,
            fontWeight: isRegisterNow ? FontWeight.w500 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
