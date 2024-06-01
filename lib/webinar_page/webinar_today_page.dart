import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
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
import '../other/listcontroler.dart';
import '../widget/custom_webniar_card_widget.dart';

class WebinarTodayPage extends StatefulWidget {
  const WebinarTodayPage({super.key});

  @override
  State<WebinarTodayPage> createState() => _WebinarTodayPageState();
}

class _WebinarTodayPageState extends State<WebinarTodayPage> {
  @override
  void initState() {
    super.initState();

    context.read<CounsellorDetailsProvider>().fetchWebinar_Data("Today");
  }

  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    bool isLoading = context.watch<CounsellorDetailsProvider>().isLoading;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : counsellorSessionProvider.webinarList.length == 0
            ? Center(
                child: Text(
                  "No Webinar",
                  style: SafeGoogleFont("Inter"),
                ),
              )
            : ListView.builder(
                itemCount: counsellorSessionProvider.webinarList.length,
                itemBuilder: (context, index) {
                  WebinarModel webinarModel =
                      counsellorSessionProvider.webinarList[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        top: index == 0 ? 14 : 2, right: 16, left: 16),
                    child: CustomWebinarCard1(
                      showDuration: true,
                      title: "Learn more about CUET and IPMAT",
                      isRegisterNow: index == 0 ? true : false,
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

class CustomWebinarCard1 extends StatefulWidget {
  const CustomWebinarCard1(
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
  State<CustomWebinarCard1> createState() => _CustomWebinarCard1State();
}

class _CustomWebinarCard1State extends State<CustomWebinarCard1> {
  final ListController listController = Get.put(ListController());
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
      if (currentTime.difference(savedTime).inSeconds >= 20) {
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
        'startingTimestamp',
        DateTime.now().millisecondsSinceEpoch,
      );
    } else {
      await _prefs.remove('startingTimestamp');
    }
    await _prefs.setBool('isRegistrationStarting', isStarting);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: listController.cousnellorlist_data.isEmpty
          ? Container(
              // height: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                // alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3.5,
                  ),
                  const Text("Data not Found")
                ],
              ),
            )
          : cardView(context),
    );
  }

  Widget cardView(BuildContext context) {
    DateTime registrationDate =
        DateTime.parse(widget.webinarModel.resisterDate!);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebinarDetailsPageWidget(
              webinarId: widget.webinarModel.id!,
              webinarImg: widget.webinarModel.webinarImage,
              webinarTitle: widget.webinarModel.webinarTitle,
              webinarDate: widget.webinarModel.webinarDate,
              webinarBy: widget.webinarModel.webinarBy,
              webinarSpeaker: widget.webinarModel.speakerProfile,
              webinarStartDays: widget.webinarModel.webnar_startdays,
              webinarRegister: widget.webinarModel.registered,
              webinarJoinUrl: widget.webinarModel.joinUrl,
              registrationDate: registrationDate,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Card(
            shadowColor: ColorsConst.whiteColor,
            color: ColorsConst.whiteColor,
            surfaceTintColor: ColorsConst.whiteColor,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image:
                          NetworkImage('${widget.webinarModel.webinarImage}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 4, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.webinarModel.webinarBy}',
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              Text(
                                '${widget.webinarModel.webinarTitle}',
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // customEnrollButton(
                          //   onPresssed: () {},
                          //   title: "Free Enroll",
                          //   context: context,
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: const Color(0xffAFAFAF),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Share.share(
                                    'https://play.google.com/store/apps/details?id=com.sortmycollege');
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
                            customRegisterNowBtn(
                              onPressed: () async {
                                _isRegistrationStarting =
                                    widget.webinarModel.registered;
                                if (widget.webinarModel.registered &&
                                    widget.webinarModel.webnar_startdays == 0) {
                                  launchUrlString(widget.webinarModel.joinUrl!);
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
                                                    msg:
                                                        'Participant is already registered');
                                                Navigator.pop(context);
                                              } else {
                                                var value = await ApiService
                                                    .webinar_regiter(widget
                                                        .webinarModel.id!);
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
                                                  widget.webinarModel
                                                      .registered = true;
                                                }
                                                if (mounted) {
                                                  Navigator.pop(context);
                                                }
                                                await _updateRegistrationStatus(
                                                    true);
                                              }
                                            },
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              regdate: widget.webinarModel.resisterDate!,
                              title: widget.webinarModel.registered
                                  ? (widget.webinarModel.webnar_startdays == 0
                                      ? 'Join Now'
                                      : 'Starting in ${widget.webinarModel.webnar_startdays} days')
                                  : 'Register Now',
                              isRegisterNow: widget.webinarModel.registered,
                            ),
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
}

Widget customRegisterNowBtn({
  required VoidCallback onPressed,
  required String title,
  required String regdate,
  required bool isRegisterNow,
}) {
  bool has24HoursPassed = false;
  DateTime registrationDate = DateTime.parse(regdate);
  //Duration difference = registrationDate.difference(DateTime.now());

  var diff = daysBetween(DateTime.now(), registrationDate);
  var showdiff = diff.abs();

  if (diff < 0) {
    has24HoursPassed = true; // in past webinar done
    //pastdays = difference.inDays;
  } else if (diff > 0) {
    has24HoursPassed = false; // in future
  } else if (diff == 0) {
    has24HoursPassed = false; // in today
  }

  isRegisterNow = has24HoursPassed;

  Color buttonColor =
      //isRegisterNow ? const Color(0xFF1F0A68) : const Color(0xFFFFFFFF);
      isRegisterNow ? ColorsConst.grayColor : const Color(0xFF1F0A68);
  Color textColor = isRegisterNow ? Colors.black : Colors.white;

  return SizedBox(
    height: 35,
    width: 232,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        foregroundColor: textColor,
        backgroundColor: buttonColor,
      ),
      child: Text(
        has24HoursPassed == false ? title : "Happened $showdiff days ago",
        style: SafeGoogleFont(
          "Inter",
          fontSize: 15,
          fontWeight: isRegisterNow ? FontWeight.w500 : FontWeight.w500,
        ),
      ),
    ),
  );
}








