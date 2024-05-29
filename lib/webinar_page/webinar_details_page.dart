import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:share_plus/share_plus.dart';

class WebinarDetailsPage extends StatefulWidget {
  final String image;
  final String webinarTitle;
  final String webinarDate;
  final String webinarBy;
  final bool registerd;

  const WebinarDetailsPage(
      {super.key,
      required this.image,
      required this.webinarTitle,
      required this.webinarDate,
      required this.webinarBy,
      required this.registerd});

  @override
  State<WebinarDetailsPage> createState() => _WebinarDetailsPageState();
}

class _WebinarDetailsPageState extends State<WebinarDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Webinar Details',
          style: SafeGoogleFont("Inter",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorsConst.appBarColor),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF1F0A68),
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
                color: const Color(0xFF1F0A68),
                height: 23,
              ),
            ),
          )
        ],
        backgroundColor: const Color(0xffffffff).withOpacity(0.8),
        surfaceTintColor: const Color(0xffffffff).withOpacity(0.8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 196,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.webinarTitle,
                    textAlign: TextAlign.start,
                    // overflow: TextOverflow.ellipsis,
                    style: SafeGoogleFont(
                      "Inter",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff414040),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "60 min",
                    textAlign: TextAlign.end,
                    style: SafeGoogleFont(
                      "Inter",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: fontColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
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
                    widget.webinarBy,
                    style: SafeGoogleFont("Inter",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: fontColor),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Image.asset(
                    "assets/page-1/images/clock.png",
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.webinarDate,
                    style: SafeGoogleFont(
                      "Inter",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
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
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      "\u2022 Guideline will always give right direction in carrier path \n\u2022 Our Councillor is experienced and having industry experience \n\u2022 Session will give you confidence and carrier boost in competitive world\n\u2022 This will open new gateway  for you future journey",
                      style: SafeGoogleFont("Inter",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.64),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                child: Text(
                  "What will you Learn?",
                  style: SafeGoogleFont(
                    "Inter",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 88,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
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
                                  ? "Detailed information"
                                  : index == 1
                                      ? "Upgrade Knowledge"
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 19, 15, 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Speaker Profile",
                      style: SafeGoogleFont(
                        "Inter",
                        fontSize: 18,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: customButton(
          backgroundColor:
              widget.registerd ? Colors.grey.shade100 : const Color(0xff1F0A68),
          context: context,
          onPressed: widget.registerd
              ? () {
                  Fluttertoast.showToast(msg: 'You are already registered');
                }
              : () {
                  // Fluttertoast.showToast(msg: 'You are already registered');
                },
          title: widget.registerd ? "Join Now" : "Register",
        ),
      ),
    );
  }
}

const fontColor = Color(0xff8E8989);

Widget customButton({
  required BuildContext context,
  required VoidCallback onPressed,
  required String title,
  Color? backgroundColor,
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
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor ?? const Color(0xff1F0A68),
      ),
      child: Text(
        title,
        style: SafeGoogleFont(
          "Inter",
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
