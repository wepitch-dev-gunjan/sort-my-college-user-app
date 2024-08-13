import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/home_page/entrance_preparation/components/commons.dart';
import 'package:myapp/other/api_service.dart';
import '../../../utils/share_links.dart';
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
  bool isLoading = true;
  List reviews = []; // Store the reviews here

  @override
  void initState() {
    getKeyFeatures(widget.id);
    getFacultiesData(widget.id);
    getInstituteDetails(widget.id);
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
                  ProfileCard(id: widget.id, data: instituteDetails),
                  FullSizeBtns(id: widget.id),
                  const AboutUs(),
                  CourseSection(courses: instituteDetails),
                  FacultiesCard(faculties: faculties),
                  KeyFeatures(keyFeatures: keyFeatures),
                  ReviewCard(
                      id: widget.id,
                      reviews: reviews), // Pass reviews to ReviewCard
                  GiveReviewSection(
                    id: widget.id,
                    onReviewAdded: addReview,
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffF2F2F2),
              child: Padding(
                padding: const EdgeInsets.only(left: 45, right: 10),
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

class CourseSection extends StatelessWidget {
  final dynamic courses;
  const CourseSection({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Courses Offered",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          const Divider(),
          UgCourses(data: courses, title: "Undergraduate Courses"),
          const SizedBox(height: 20.0),
          PgCourses(data: courses, title: "Postgraduate Courses"),
        ],
      ),
    );
  }
}
