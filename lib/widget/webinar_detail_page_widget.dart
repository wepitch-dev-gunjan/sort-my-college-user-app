import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../webinar_page/webinar_pastwebnar_page.dart';

class WebinarDetailsPageWidget extends StatefulWidget {
  final String? webinarId,
      webinarImg,
      webinarTitle,
      webinarDate,
      webinarSpeaker,
      webinarBy,
      webinarJoinUrl;

  late bool webinarRegister;
  final int? webinarStartDays;
  DateTime registrationDate;

  WebinarDetailsPageWidget(
      {required this.webinarId,
      this.webinarSpeaker,
      required this.webinarImg,
      required this.webinarTitle,
      required this.webinarDate,
      required this.webinarBy,
      required this.webinarStartDays,
      required this.webinarRegister,
      required this.registrationDate,
      required this.webinarJoinUrl,
      super.key});

  @override
  State<WebinarDetailsPageWidget> createState() =>
      _WebinarDetailsPageWidgetState();
}

class _WebinarDetailsPageWidgetState extends State<WebinarDetailsPageWidget> {
  late SharedPreferences _prefs;
  bool _isRegistrationStarting = false;
  var value;
  var dataList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences(widget.webinarId!);
  }

  Future<void> _initializeSharedPreferences(String id) async {
    value = await ApiService.getWebinarDetailsData(id);
    isLoading = false;

    _prefs = await SharedPreferences.getInstance();
    bool isStarting = _prefs.getBool('isRegistrationStarting') ?? false;

    setState(() {
      value = value;
      widget.webinarRegister = isStarting;
    });
  }

  Future<void> _updateRegistrationStatus(bool isStarting) async {
    setState(() {
      widget.webinarRegister = isStarting;
    });

    if (isStarting) {
      await _prefs.setInt(
        'startingTimestamp',
        DateTime.now().millisecondsSinceEpoch,
      );
    } else {
      await _prefs.remove('startingTimestamp');
    }
    await _prefs.setBool('isRegistrationStarting', isStarting);
  }

  bool has24HoursPassed = false;

  @override
  Widget build(BuildContext context) {
    Duration difference = DateTime.now().difference(widget.registrationDate);
    var diff = daysBetween(DateTime.now(), widget.registrationDate);
    var pastdays;
    if (diff < 0) {
      has24HoursPassed = true; // in past webinar done
      pastdays = diff.abs();
      //pastdays = difference.inDays;
    } else if (diff > 0) {
      has24HoursPassed = false; // in future
    } else if (diff == 0) {
      has24HoursPassed = false; // in today
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          surfaceTintColor: const Color(0xffffffff),
          title: Text(
            'Webinar Details',
            style: SafeGoogleFont("Inter",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorsConst.appBarColor),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff1F0A68),
              size: 25,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Share.share(
                      'https://play.google.com/store/apps/details?id=com.sortmycollege');
                },
                child: Image.asset(
                  "assets/page-1/images/share.png",
                  color: const Color(0xff1F0A68),
                  height: 23,
                ),
              ),
            )
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
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
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.webinarImg!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          child: Text(
                            value['webinar_title'],
                            textAlign: TextAlign.start,
                            style: SafeGoogleFont("Inter",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff414040)),
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
                                widget.webinarBy!,
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
                                width: 6,
                              ),
                              Text(
                                widget.webinarDate!,
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
                        value['webinar_details'].isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 20, 14, 20),
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
                                      height: 10,
                                    ),
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          value['webinar_details'].length,
                                      itemBuilder: (context, index) {
                                        return Text(
                                          "\u2022 ${value['webinar_details'][0]}",
                                          style: SafeGoogleFont(
                                            "Inter",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 1.90,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                        value['what_will_you_learn'].isEmpty
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "What will you Learn?",
                                      style: SafeGoogleFont(
                                        "Inter",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount:
                                          value['what_will_you_learn'].length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: index == 0 ? 20 : 17),
                                          child: IntrinsicHeight(
                                            child: Container(
                                              width: 144,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffD9D9D9)
                                                    .withOpacity(0.65),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        14, 11, 0, 11),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "${index + 1}",
                                                          style: SafeGoogleFont(
                                                            "Inter",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      value['what_will_you_learn']
                                                          [index],
                                                      style: SafeGoogleFont(
                                                        "Inter",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xff414040),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
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
                            value['speaker_profile'],
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 10),
          child: Card(
            color: Colors.white,
            child: webinarDetailWidget(
              onPressed: () async {
                _isRegistrationStarting = widget.webinarRegister;

                log("_isRegistred=>$_isRegistrationStarting");

                if (has24HoursPassed) {
                  Fluttertoast.showToast(
                      msg: 'Webinar Happened ${diff.abs()} days ago');
                } else {
                  if (widget.webinarRegister && widget.webinarStartDays == 0) {
                    launchUrlString(widget.webinarJoinUrl!);
                  } else if (_isRegistrationStarting) {
                    Fluttertoast.showToast(
                        msg: 'Participant is already registered');
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Do you want to register for the webinar?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (_isRegistrationStarting) {
                                  Fluttertoast.showToast(
                                      msg: 'Participant is already registered');
                                  Navigator.pop(context);
                                } else {
                                  var value = await ApiService.webinar_regiter(
                                      widget.webinarId!);
                                  if (value["error"] ==
                                      "Participant is already registered") {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Participant is already registered');
                                  } else if (value["message"] ==
                                      "Registration completed") {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Registration completed. Thanks for registering');
                                    setState(() {
                                      widget.webinarRegister = true;

                                      _isRegistrationStarting =
                                          widget.webinarRegister;
                                    });
                                  }
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }

                                  await _updateRegistrationStatus(true);
                                }
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              title: widget.webinarRegister
                  ? (widget.webinarStartDays == 0
                      ? 'Join Now'
                      : has24HoursPassed
                          ? 'Happened in ${diff.abs()} days ago'
                          : 'Starting in ${widget.webinarStartDays} days')
                  : 'Join Now',
              isRegisterNow: has24HoursPassed ? false : widget.webinarRegister,
            ),
          ),
        ),
      ),
    );
  }
}

Widget webinarDetailWidget({
  required VoidCallback onPressed,
  required String title,
  required bool isRegisterNow,
}) {
  Color buttonColor =
      isRegisterNow ? const Color(0xff1F0A68) : ColorsConst.grayColor;
  Color textColor = isRegisterNow ? Colors.white : Colors.black;

  double buttonWidth =
      title.contains('Starting in 2 days') ? double.infinity : 200.0;

  return SizedBox(
    width: buttonWidth * 1.1,
    height: 42,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shadowColor: ColorsConst.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: textColor,
        backgroundColor: buttonColor,
      ),
      child: Text(
        title,
        style: SafeGoogleFont(
          "Inter",
          fontSize: 14,
          fontWeight: isRegisterNow ? FontWeight.w400 : FontWeight.w400,
        ),
      ),
    ),
  );
}

// const fontColor = Color(0xff8E8989);
const fontColor = Color(0xff8E8989);
