import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/home_page/entrance_preparation/components/app_bar.dart';
import 'package:myapp/home_page/entrance_preparation/components/commons.dart';
import 'package:myapp/home_page/entrance_preparation/screens/announcement_screen.dart';
import 'package:myapp/utils.dart';

class VisitProfilePage extends StatefulWidget {
  const VisitProfilePage({super.key});

  @override
  State<VisitProfilePage> createState() => _VisitProfilePageState();
}

class _VisitProfilePageState extends State<VisitProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const EpAppBar(
        title: "SortMyCollege",
        icon: Icons.more_vert,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(),
            const SizedBox(height: 5.0),
            FullSizeBtns(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About Us",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\u2022 ",
                              style: SafeGoogleFont(
                                "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.90,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing ",
                                style: SafeGoogleFont(
                                  "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.90,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FullSizeBtns extends StatelessWidget {
  const FullSizeBtns({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: 40,
                color: const Color(0xffF6F5F5),
                child: Center(
                    child: Text(
                  "Info",
                  style: GoogleFonts.lato(),
                )),
              ),
              Container(
                height: 2,
                color: Colors.black,
              )
            ],
          ),
        ),
        Container(
          width: 1,
          height: 40,
          color: Colors.white,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnnouncementScreen()));
            },
            child: Container(
              height: 40,
              color: const Color(0xffF6F5F5),
              child: Center(
                  child: Text(
                "Announcements",
                style: GoogleFonts.lato(),
              )),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool isFollowing = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          SizedBox(
            height: 190.h,
            width: 398.w,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("assets/page-1/images/webinarBanner.png")),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWithIcon(
                      text: "C-SCHEME JAIPUR", icon: Icons.location_on_sharp),
                  const SizedBox(height: 3),
                  const TextWithIcon(
                      text: " Open until 9:00 PM",
                      fontWeight: FontWeight.w600,
                      textColor: Color(0xff4BD058),
                      icon: Icons.access_time_outlined),
                  const SizedBox(height: 3),
                  const TextWithIcon(
                      text: "4.9 (960)",
                      fontWeight: FontWeight.w600,
                      icon: Icons.star,
                      iconColor: Colors.amber),
                  const SizedBox(height: 3),
                  InkWell(
                    onTap: () {},
                    child: const TextWithIcon(
                        text: "DIRECTION",
                        fontWeight: FontWeight.w600,
                        icon: Icons.directions),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Btn(
                      onTap: () {
                        setState(() {
                          if (!isFollowing) {
                            isFollowing = true;
                          } else {
                            isFollowing = false;
                          }
                        });
                      },
                      textColor: isFollowing ? Colors.black : Colors.white,
                      btnColor:
                          isFollowing ? Colors.white : const Color(0xff1F0A68),
                      btnName: isFollowing ? "Follow" : "Following"),
                  const SizedBox(height: 3.0),
                  const TextWithIcon(
                      text: "456 Following",
                      fontWeight: FontWeight.w600,
                      icon: Icons.person),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
