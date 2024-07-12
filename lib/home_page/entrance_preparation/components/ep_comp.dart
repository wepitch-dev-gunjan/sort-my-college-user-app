import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils.dart';
import '../screens/announcement_screen.dart';
import '../screens/faculties_screen.dart';
import '../screens/visit_profile_page.dart';
import 'commons.dart';

class Faculties extends StatelessWidget {
  const Faculties({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Faculties",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FacultiesScreen(),
              ),
            );
          },
          child: const Text(
            "View All",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class FacultiesCard extends StatelessWidget {
  const FacultiesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < 5; i++)
            const SizedBox(
              height: 70,
              width: 200,
              child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                "Dr.Kumar",
                                style: TextStyle(
                                    fontSize: 15,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "MBBS and MS in HumanAnato",
                                style: TextStyle(
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 5.0),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                            radius: 25,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
        ],
      ),
    );
  }
}

class Courses extends StatelessWidget {
  final List courses;
  final String title;
  Courses({
    super.key,
    required this.courses,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < courses.length; i++)
              Btn(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CourseSendEnquiryCard(courseName: courses[i]);
                    },
                  );
                },
                btnName: courses[i],
                btnColor: const Color(0xff1F0A68),
                textColor: Colors.white,
                width: 80,
              ),
          ],
        )
      ],
    );
  }
}

final List<String> ugCourses = ["NEET", "JEE", "CLAT", "CUET"];
final List<String> pgCourses = ["NEET", "CUET", "CLAT", "CAT"];

class CourseSendEnquiryCard extends StatelessWidget {
  final String courseName;

  CourseSendEnquiryCard({required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21.0),
      ),
      child: Container(
        height: 290,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(21)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(21),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(radius: 28),
                          const SizedBox(width: 20),
                          Btn(
                            onTap: () {},
                            btnName: courseName,
                            btnColor: const Color(0xff1F0A68),
                            textColor: Colors.white,
                            height: 45,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                      const Text(
                        "Academic Session:- 2024-25",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(11),
                child: Container(
                  height: 80,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white,
                  ),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "\u2022  Course Fee - ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text("1 Lakh")
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "\u2022  Course Duration - ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text("6 Months")
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Btn(
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.close)),
                            ],
                          ),
                          Image.asset("assets/page-1/images/Check.png"),
                          const SizedBox(height: 20),
                          const Text(
                            'ENQUIRY SUBMITTED',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              btnName: "Send Enquiry",
              btnColor: const Color(0xff1F0A68),
              textColor: Colors.white,
              height: 40,
            ),
          ],
        ),
      ),
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

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("About Us",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < (isExpanded ? 10 : 5); i++)
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
                          "Lorem Ipsum is simply dummy text of the printing",
                          style: SafeGoogleFont(
                            "Inter",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1.90,
                          ),
                        ),
                      ),
                    ],
                  ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? "Read Less" : "Read More",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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
                height: 38,
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
