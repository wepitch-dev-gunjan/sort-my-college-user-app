import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebinarDetailsPageWidget extends StatefulWidget {
  final String? webinarId,
      webinarImg,
      webinarTitle,
      webinarDate,
      webinarBy,
      webinarSpeaker,
      webinarJoinUrl;

  late bool webinarRegister;
  final int? webinarStartDays;

  WebinarDetailsPageWidget(
      {required this.webinarId,
      required this.webinarImg,
      required this.webinarTitle,
      required this.webinarDate,
      required this.webinarBy,
      required this.webinarSpeaker,
      required this.webinarStartDays,
      required this.webinarRegister,
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
  //bool _isRegistrationStarting = false;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences(widget.webinarId!);
  }

  Future<void> _initializeSharedPreferences(String id) async {
    value = await ApiService.getWebinarDetailsData(id);
    List<String> whatWill = ['what_will_you_learn'];
    dataList = whatWill.length;
    // var value = ApiService.getdetailpage(widget.webinarId);
    //context.read<CounsellorDetailsProvider>().fetchWebinarDetails_Data(widget.webinarId);

    _prefs = await SharedPreferences.getInstance();
    bool isStarting = _prefs.getBool('isRegistrationStarting') ?? false;

    setState(() {
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop){

      },
      child: Scaffold(
        body: Column(
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
                            color: const Color(0xffffffff),
                            width: double.infinity,
                            height: 280,
                            child: SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
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
                                    GestureDetector(
                                      onTap: () {
                                        Share.share(
                                            'https://play.google.com/store/apps/details?id=com.sortmycollege');
                                      },
                                      child: Image.asset(
                                        "assets/page-1/images/share.png",
                                        color: Color(0xff1F0A68),
                                        height: 23,
                                      ),
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
                                  widget.webinarTitle!,
                                  style: SafeGoogleFont("Inter",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff414040)),
                                ),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
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
                              Text(
                                "\u2022 Online seminars establish you as an expert,a\n  trustworthy and reliable source of information\n\u2022 people are demonstrating an interest in what you are\n  offering – they become qualified leads\n\u2022 valuable content for your domain",
                                style: SafeGoogleFont("Inter",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1.90),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
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
                                  color:
                                      const Color(0xffD9D9D9).withOpacity(0.65),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(14, 11, 0, 11),
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
                            widget.webinarSpeaker!,
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
                child: webinarDetailWidget(
                  onPressed: () async {
                    _isRegistrationStarting = widget.webinarRegister;
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
                                      Fluttertoast.showToast(msg: 'Registration completed. Thanks for registering');
                                      setState(() {
                                        widget.webinarRegister = true;
                                        _isRegistrationStarting = widget.webinarRegister;
                                      });
                                      //Navigator.pop(context);
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
                  },
                  title: widget.webinarRegister
                      ? (widget.webinarStartDays == 0
                          ? 'Join Now'
                          : 'Starting in ${widget.webinarStartDays} days')
                      : 'Join Now',
                  isRegisterNow: widget.webinarRegister,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
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
      isRegisterNow ? Color(0xff1F0A68) : const Color(0xff1F0A68);
  Color textColor = isRegisterNow ? Colors.white : Colors.white;

  double buttonWidth =
      title.contains('Starting in 2 days') ? double.infinity : 200.0;

  return SizedBox(
    width: buttonWidth,
    height: 42,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shadowColor: ColorsConst.whiteColor,
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

const fontColor = Color(0xff8E8989);
