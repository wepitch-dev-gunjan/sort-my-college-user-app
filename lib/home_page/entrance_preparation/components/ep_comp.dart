import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myapp/other/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils.dart';
import '../screens/announcement_screen.dart';
import '../screens/Faculties_all_screen.dart';
import 'commons.dart';

class Faculties extends StatelessWidget {
  final dynamic facultiesData;
  const Faculties({
    super.key,
    required this.facultiesData,
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
                builder: (context) => AllFacultiesScreen(
                  facultiesData: facultiesData,
                ),
              ),
            );
          },
          child: const Text(
            "View All",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xff1F0A68),
                fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class FacultiesCard extends StatelessWidget {
  final dynamic faculties;
  const FacultiesCard({
    super.key,
    required this.faculties,
  });

  @override
  Widget build(BuildContext context) {
    if (faculties == null || faculties.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Faculties(facultiesData: faculties),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < faculties.length; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    height: 70,
                    width: 200,
                    child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      faculties[i]['name'] ?? "N/A",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Center(
                                      child: Text(
                                        faculties[i]['qualifications'] ?? "N/A",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      "${faculties[i]['display_pic']}"),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class UgCourses extends StatelessWidget {
  final List<dynamic>? data; // Make data nullable
  final String title;
  final String id;

  const UgCourses({
    super.key,
    required this.data,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> courseList = data ?? [];

    List<dynamic> ugCourses =
        courseList.where((course) => course['type'] == "UG").toList();

    return ugCourses.isNotEmpty
        ? Column(
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < ugCourses.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CourseBtn(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CourseSendEnquiryCard(
                                  courseID: ugCourses[i]['_id'],
                                  id: id,
                                  courseName: ugCourses[i]['name'],
                                  courseDuration: ugCourses[i]
                                      ['course_duration'],
                                  courseFee:
                                      ugCourses[i]['course_fee'].toString(),
                                  startYear: ugCourses[i]['academic_session']
                                          ['start_year']
                                      .toString(),
                                  endYear: ugCourses[i]['academic_session']
                                          ['end_year']
                                      .toString(),
                                );
                              },
                            );
                          },
                          btnName: ugCourses[i]['name'],
                          btnColor: const Color(0xff1F0A68),
                          textColor: Colors.white,
                          borderRadius: 5,
                        ),
                      ),
                  ],
                ),
              )
            ],
          )
        : const SizedBox();
  }
}

class PgCourses extends StatelessWidget {
  final List<dynamic>? data; // Make data nullable
  final String title;
  final String id;

  const PgCourses({
    super.key,
    required this.data,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // Provide an empty list if data is null
    List<dynamic> courseList = data ?? [];

    // Filter the courses to include only those with type "PG"
    List<dynamic> pgCourses =
        courseList.where((course) => course['type'] == "PG").toList();

    return pgCourses.isNotEmpty
        ? Column(
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < pgCourses.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CourseBtn(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CourseSendEnquiryCard(
                                  id: id,
                                  courseID: pgCourses[i]['_id'],
                                  courseName: pgCourses[i]['name'],
                                  courseDuration: pgCourses[i]
                                      ['course_duration'],
                                  courseFee:
                                      pgCourses[i]['course_fee'].toString(),
                                  startYear: pgCourses[i]['academic_session']
                                          ['start_year']
                                      .toString(),
                                  endYear: pgCourses[i]['academic_session']
                                          ['end_year']
                                      .toString(),
                                );
                              },
                            );
                          },
                          btnName: pgCourses[i]['name'],
                          btnColor: const Color(0xff1F0A68),
                          textColor: Colors.white,
                          borderRadius: 5,
                          width: 75.w,
                        ),
                      ),
                  ],
                ),
              )
            ],
          )
        : const SizedBox();
  }
}

class CourseSendEnquiryCard extends StatelessWidget {
  final String courseName;
  final String startYear, endYear;
  final String courseFee;
  final String? courseDuration;
  final String id, courseID;

  const CourseSendEnquiryCard({
    super.key,
    required this.courseName,
    required this.courseFee,
    this.courseDuration,
    required this.startYear,
    required this.endYear,
    required this.id,
    required this.courseID,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21.0),
      ),
      child: Stack(
        children: [
          Container(
            height: courseFee == "null" ? 265 : 290,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(21),
            ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Btn(
                                onTap: () {},
                                btnName: courseName,
                                btnColor: const Color(0xff1F0A68),
                                textColor: Colors.white,
                                height: 45,
                                borderRadius: 5.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Academic Session:- ${startYear.toString()}-${endYear.toString()}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(11),
                    child: Container(
                      // height: 80,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          courseFee == "null"
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Text(
                                      "\u2022  Course Fee - ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(courseFee)
                                  ],
                                ),
                          Row(
                            children: [
                              const Text(
                                "\u2022  Course Duration - ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(courseDuration ?? 'N/A')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Btn(
                  onTap: () async {
                    final response = await ApiService.epEnquiry(
                        id: id.toString(), coursesId: courseID);

                    if (response['message'] == "Enquiry added successfully") {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const EnquirySubmittedDialog();
                        },
                      );
                    } else if (response['error'] == 'Something went wrong') {
                      Fluttertoast.showToast(
                          msg:
                              "You've already inquired. Try again in 24 hours.");
                    }
                  },
                  btnName: "Send Enquiry",
                  btnColor: const Color(0xff1F0A68),
                  textColor: Colors.white,
                  height: 40,
                  borderRadius: 5.0,
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EnquirySubmittedDialog extends StatefulWidget {
  const EnquirySubmittedDialog({super.key});

  @override
  _EnquirySubmittedDialogState createState() => _EnquirySubmittedDialogState();
}

class _EnquirySubmittedDialogState extends State<EnquirySubmittedDialog> {
  int _counter = 3;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter == 0) {
        Navigator.of(context).pop();
        _timer.cancel();
      } else {
        setState(() {
          _counter--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // GestureDetector(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: const Icon(Icons.close)),
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
          const SizedBox(height: 10),
          Text(
            'Closing in $_counter seconds',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  final String id;
  const ProfileCard({super.key, required this.id});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool isLoading = true;
  bool isFollowing = false;
  bool isFollowLoading = false;
  int followerCount = 0;
  dynamic data;

  @override
  void initState() {
    super.initState();
    getInstituteDetails(widget.id);
  }

  getInstituteDetails(String id) async {
    final res = await ApiService.getInstituteDetails(id: id);
    setState(() {
      data = res;
      followerCount = data['follower_count'];
      isFollowing = data['following'];
      isLoading = false;
    });
  }

  void setIsFollowingLoading(bool state) {
    setState(() {
      isFollowLoading = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    String statusText = _getOpenStatus();
    Color statusColor =
        statusText == "Closed" ? Colors.red : const Color(0xff4BD058);
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 14, right: 13),
      child: Column(
        children: [
          SizedBox(
            height: 190.h,
            width: 398.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: data != null && data['cover_image'] != null
                  ? Image.network(
                      data['cover_image'],
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Image.asset(
                              "assets/page-1/images/comming_soon.png");
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Image.asset(
                            "assets/page-1/images/comming_soon.png");
                      },
                    )
                  : Image.asset("assets/page-1/images/comming_soon.png"),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Icon(Icons.import_contacts),
                  //     SizedBox(width: 10,),
                  //     SizedBox(
                  //         width: 200,
                  //         child: Text(
                  //           "data is very important in mhy use grgeg",
                  //           maxLines: 2,
                  //           overflow: TextOverflow.ellipsis,
                  //         ))
                  //   ],
                  // ),
                  TextWithIconElipsis(
                    text: data != null &&
                            data['address'] != null &&
                            data['address']['area'] != null &&
                            data['address']['city'] != null
                        ? '${data['address']['area']}, ${data['address']['city']}'
                        : "N/A",
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                    icon: Icons.location_on_sharp,
                    width: 200,
                  ),

                  const SizedBox(height: 3),
                  TextWithIcon(
                      text:
                          _getOpenStatus(), // Use the method to get open status
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      textColor: statusColor,
                      icon: Icons.access_time_outlined),
                  const SizedBox(height: 3),
                  TextWithIcon(
                      text: data != null && data['rating'] != null
                          ? data['rating'].toString()
                          : "0",
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      icon: Icons.star,
                      iconColor: Colors.amber),
                  const SizedBox(height: 3),
                  InkWell(
                    onTap: () async {
                      final Uri redirectLink = Uri.parse(data['direction_url']);
                      if (await canLaunchUrl(redirectLink)) {
                        await launchUrl(redirectLink);
                      } else {
                        throw 'Could not launch $redirectLink';
                      }
                    },
                    child: TextWithIcon(
                      text: "DIRECTION",
                      fontWeight: FontWeight.w600,
                      icon: Icons.directions,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FollowerBtn(
                    onTap: () async {
                      if (isFollowing) {
                        var value = await ApiService.unfollowInstitute(
                            widget.id, setIsFollowingLoading);
                        isFollowing = value["status"].toLowerCase() == 'true';
                        followerCount = followerCount - 1;
                        setState(() {});
                      } else {
                        var value = await ApiService.followInstitute(
                            widget.id, setIsFollowingLoading);
                        isFollowing = value["status"].toLowerCase() == 'true';
                        followerCount = followerCount + 1;
                        setState(() {});
                      }
                    },
                    btnColor:
                        isFollowing ? Colors.white : const Color(0xff1F0A68),
                    child: Center(
                      child: isFollowLoading
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                strokeWidth: 2.0,
                              ),
                            )
                          : Text(
                              isFollowing ? 'Following' : 'Follow',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.2125,
                                color: isFollowing
                                    ? Colors.black
                                    : const Color(0xffffffff),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      TextWithIcon(
                        text: "$followerCount Following",
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        textColor: const Color(0xff5c5b5b),
                        assetImage: "assets/page-1/images/group-NC9.png",
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }

  String _getOpenStatus() {
    if (data == null || data['institute_timings'] == null) {
      return "N/A";
    }

    // Get the current day
    String today = DateFormat('EEEE').format(DateTime.now()).toUpperCase();

    // Find the timing for the current day
    var todayTiming = data['institute_timings'].firstWhere(
      (timing) => timing['day'] == today,
      orElse: () => null,
    );

    if (todayTiming != null) {
      if (todayTiming['is_open']) {
        return "Open until ${todayTiming['end_time']}";
      } else {
        return "Closed";
      }
    }

    return "N/A";
  }
}

class AboutUs extends StatefulWidget {
  final dynamic about;
  const AboutUs({
    super.key,
    required this.about,
  });

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool isExpanded = false;
  final int initialItemCount = 5;

  @override
  Widget build(BuildContext context) {
    // Check if 'about' exists and is not null
    if (widget.about == null || widget.about['about'] == null) {
      return const SizedBox(); // Or return a placeholder widget
    }

    final aboutText = widget.about['about'];
    if (aboutText.isEmpty) {
      return const SizedBox(); // Or return a placeholder widget
    }

    bool shouldShowReadMore = aboutText.length > initialItemCount;
    int itemCount = isExpanded ? aboutText.length : initialItemCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                for (int i = 0; i < itemCount && i < aboutText.length; i++)
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
                          aboutText[i],
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
                if (shouldShowReadMore)
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
  final String id;
  const FullSizeBtns({
    super.key,
    required this.id,
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
                      builder: (context) => AnnouncementScreen(
                            id: id,
                          )));
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
