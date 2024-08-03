import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/home_page/entrance_preparation/components/commons.dart';
import 'package:myapp/home_page/entrance_preparation/screens/send_enquiry_page.dart';
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

  @override
  void initState() {
    getKeyFeatures(widget.id);
    getFacultiesData(widget.id);
    getInstituteDetails(widget.id);
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

  @override
  Widget build(BuildContext context) {
    // log("instituteDetails${instituteDetails}");
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
                  const FullSizeBtns(),
                  const AboutUs(),
                  const CourseSection(),
                  FacultiesCard(faculties: faculties),
                  KeyFeatures(keyFeatures: keyFeatures),
                  const ReviewCard(),
                  const GiveReviewSection()
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const EnquirySubmittedDialog();
                            },
                          );
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
  const CourseSection({
    super.key,
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
          Courses(courses: ugCourses, title: "Undergraduate Courses"),
          const SizedBox(height: 20.0),
          Courses(courses: pgCourses, title: "Postgraduate Courses"),
        ],
      ),
    );
  }
}
