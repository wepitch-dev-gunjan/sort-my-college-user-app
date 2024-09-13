import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/home_page/entrance_preparation/components/commons.dart';
import 'package:myapp/other/api_service.dart';
import '../../../utils/share_links.dart';
import '../components/courses.dart';
import '../components/ep_comp.dart';
import '../components/key_fetures.dart';
import '../components/review_card.dart';

class VisitProfilePage extends StatefulWidget {
  final String id;
  final String title;
  const VisitProfilePage({super.key, required this.id, required this.title});

  @override
  State<VisitProfilePage> createState() => _VisitProfilePageState();
}

class _VisitProfilePageState extends State<VisitProfilePage> {
  List keyFeatures = [];
  var faculties;
  var instituteDetails;
  var courses;
  bool isLoading = true;
  List reviews = []; // Store the reviews here

  @override
  void initState() {
    getKeyFeatures(widget.id);
    getFacultiesData(widget.id);
    getInstituteDetails(widget.id);
    getCourses(widget.id);
    getFeedback(widget.id); // Load initial reviews
    super.initState();
  }

  getInstituteDetails(String id) async {
    final res = await ApiService.getInstituteDetails(id: id);
    setState(() {
      instituteDetails = res;
      isLoading = false;
    });
  }

  getKeyFeatures(String id) async {
    final res = await ApiService.getKeyFeatures(id);
    setState(() {
      keyFeatures = res;
      isLoading = false;
    });
  }

  getFacultiesData(String id) async {
    final res = await ApiService.getFaculties(id: id);

    setState(() {
      faculties = res;
      isLoading = false;
    });
  }

  getFeedback(String id) async {
    final res = await ApiService.getEpFeedback(id: id);
    setState(() {
      reviews = res['feedbacks'];
      isLoading = false;
    });
  }

  getCourses(String id) async {
    final res = await ApiService.getEpCourses(id: id);
    setState(() {
      courses = res;
      isLoading = false;
    });
  }

  void addReview(Map<String, dynamic> review) {
    setState(() {
      reviews.insert(0, review);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: EpAppBar(
              title: widget.title,
              icon: Icons.more_vert,
              action: [
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        shareLinks();
                      },
                      child: Image.asset(
                        "assets/page-1/images/share.png",
                        color: const Color(0xff1F0A68),
                        height: 23,
                      ),
                    )),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileCard(id: widget.id),
                  FullSizeBtns(id: widget.id),
                  AboutUs(about: instituteDetails),
                  CourseSection(courses: courses, id: widget.id),
                  FacultiesCard(faculties: faculties),
                  KeyFeatures(keyFeatures: keyFeatures),
                  ReviewCard(id: widget.id, reviews: reviews),
                  GiveReviewSection(
                    id: widget.id,
                    onReviewAdded: addReview,
                    reviews: reviews,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: Platform.isIOS ? 70 : 50,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffF2F2F2),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 35, right: 20, bottom: Platform.isIOS ? 20 : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Interested?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Btn(
                        onTap: () async {
                          final response =
                              await ApiService.epEnquiry(id: widget.id);
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
                        btnName: "Send Enquiry",
                        textColor: Colors.white,
                        height: 40,
                        borderRadius: 5.0,
                        width: 160.w,
                        btnColor: const Color(0xff1F0A68))
                  ],
                ),
              ),
            ),
          );
  }
}
