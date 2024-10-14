import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home_page/entrance_preparation/screens/visit_profile_page.dart';
import 'package:myapp/other/api_service.dart';
import '../../../shared/colors_const.dart';
import '../../../utils.dart';
import '../../../utils/share_links.dart';
import '../components/commons.dart';
import '../components/ep_comp.dart';
import '../components/shimmer_effect.dart';

class EntrancePreparationScreen extends StatefulWidget {
  const EntrancePreparationScreen({super.key});

  @override
  State<EntrancePreparationScreen> createState() =>
      _EntrancePreparationScreenState();
}

class _EntrancePreparationScreenState extends State<EntrancePreparationScreen> {
  dynamic data;
  bool isLoading = true;
  var enquiry;

  @override
  void initState() {
    getEpData();
    super.initState();
  }

  getEpData() async {
    final res = await ApiService.getEPListData();
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  // sendEnquiry()async{

  //   final res=await ApiService.epEnquiry();
  //   setState(() {

  //     data

  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: const CusAppBar(
        title: 'Entrance Preparation',
        icon: Icons.search,
      ),
      body: isLoading ? const EpShimmerEffect() : EpCard(data: data),
    );
  }
}

class EpCard extends StatelessWidget {
  final dynamic data;
  EpCard({super.key, required this.data});

  List coursesList = ["CUET", "JEE", "CLET"];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    // Get the current day as a string
    String currentDay = DateFormat('EEEE').format(DateTime.now()).toUpperCase();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15.0),
          TopSlider(
            sliderText: enterencePriperationSliderText,
          ),
          const SizedBox(height: 10.0),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              // Find today's schedule
              var todaySchedule = data[index]['institute_timings'].firstWhere(
                (timing) => timing['day'] == currentDay,
                orElse: () => null,
              );

              // Determine if the institute is open or closed today
              String statusText = "Closed";
              if (todaySchedule != null && todaySchedule['is_open'] == true) {
                statusText = "Open until ${todaySchedule['end_time']}";
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 16, 0),
                    child: Card(
                      color: ColorsConst.whiteColor,
                      surfaceTintColor: ColorsConst.whiteColor,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 5, right: 15),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 95 * fem,
                                        height: 104 * fem,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(75 * fem),
                                          child: Image.network(
                                            "${data[index]['profile_pic']}",
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Image.asset(
                                                'assets/page-1/images/comming_soon.png',
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0, top: 12.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data[index]['name'],
                                                overflow: TextOverflow.ellipsis,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 22 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2125 * ffem / fem,
                                                  color:
                                                      const Color(0xFF41403F),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5.0),
                                            InkWell(
                                              onTap: () {
                                                shareLinks();
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 3, 0, 0),
                                                width: 17.42 * fem,
                                                height: 18.86 * fem,
                                                child: Image.asset(
                                                  'assets/page-1/images/group-38-oFX.png',
                                                  width: 17.42 * fem,
                                                  height: 18.86 * fem,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 14,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            data[index]['rating'].toString(),
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5.0),
                                      SizedBox(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                              data[index]['courses'].length,
                                              (courseIndex) => Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5.0),
                                                padding: const EdgeInsets.only(
                                                    left: 4.0, right: 4.0),
                                                height: 18 * fem,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff1f0a68),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3 * fem),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    data[index]['courses']
                                                        [courseIndex]['name'],
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 11 * ffem,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1.0,
                                                      color: const Color(
                                                          0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      TextWithIcon(
                                          text:
                                              "${data[index]['address']['area']},${data[index]['address']['city']}",
                                          fontWeight: FontWeight.w600,
                                          icon: Icons.location_on_sharp),
                                      const SizedBox(height: 3),
                                      TextWithIcon(
                                          text: statusText,
                                          fontWeight: FontWeight.w600,
                                          textColor:
                                              statusText.contains("Closed")
                                                  ? Colors.red
                                                  : const Color(0xff4BD058),
                                          icon: Icons.access_time_outlined),
                                      const SizedBox(height: 3),
                                      TextWithIcon(
                                          text:
                                              "${data[index]['years_of_experience'] ?? "N/A"}+ Yrs In Business",
                                          fontWeight: FontWeight.w600,
                                          icon: Icons.work),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Btn(
                                  btnName: "Visit Profile",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VisitProfilePage(
                                          id: data[index]['_id'],
                                          title: data[index]['name'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Btn(
                                  btnName: "Send Enquiry",
                                  btnColor: ColorsConst.appBarColor,
                                  textColor: Colors.white,
                                  onTap: () async {
                                    final response = await ApiService.epEnquiry(
                                        id: data[index]['_id'].toString());
                                    log("ResponseEnquiry$response");
                                    if (response['message'] ==
                                        'Enquiry added successfully') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const EnquirySubmittedDialog();
                                        },
                                      );
                                    } else if (response['error'] ==
                                        'Something went wrong') {
                                      Fluttertoast.showToast(
                                          msg:
                                              "You've already inquired. Try again in 24 hours.");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

List enterencePriperationSliderText = [
  'What entrance examinations should I prepare for?',
  'How to ace my entrance exams with top strategies?',
  'Which entrance exams are crucial for my dream career?'
];
List accommodationSliderText = [
  'Best student accommodations near campus?',
  'How to find affordable student accommodation?',
  'Which accommodations offer the best experience?'
];

class TopSlider extends StatefulWidget {
  final List sliderText;
  const TopSlider({super.key, required this.sliderText});

  @override
  State<TopSlider> createState() => _TopSliderState();
}

class _TopSliderState extends State<TopSlider> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 100.35 * fem,
          child: Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width / 20,
              left: MediaQuery.of(context).size.width / 20,
            ),
            child: Stack(
              children: [
                Positioned(
                  child: Align(
                      child: Container(
                    height: 60.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                  )),
                ),
                Positioned(
                  left: 150 * fem,
                  bottom: 20 * fem,
                  child: Row(
                    children: [
                      for (int i = 0; i < 3; i++)
                        TabPageSelectorIndicator(
                          backgroundColor: selectedIndex == i
                              ? const Color(0xff1F0A68)
                              : Colors.grey,
                          borderColor: Colors.transparent,
                          size: 7,
                        ),
                    ],
                  ),
                ),
                Positioned(
                  left: 13.28515625 * fem,
                  top: 27.3145446777 * fem,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 245 * fem,
                      height: 40 * fem,
                      child: CarouselSlider(
                        items: [
                          for (int i = 0; i < widget.sliderText.length; i++)
                            Text(
                              widget.sliderText[i],
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.3252271925 * ffem / fem,
                                color: const Color(0xFF2A2F33),
                              ),
                            ),
                        ],
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          viewportFraction: 1,
                          autoPlay: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 290.75 * fem,
                  top: 10 * fem,
                  bottom: 10,
                  child: Align(
                    child: SizedBox(
                      width: 100.5 * fem,
                      height: 128.5 * fem,
                      child: Image.asset(
                        'assets/page-1/images/graduation-hat.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
