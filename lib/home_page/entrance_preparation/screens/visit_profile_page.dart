import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/home_page/entrance_preparation/components/app_bar.dart';
import 'package:myapp/home_page/entrance_preparation/components/commons.dart';
import 'package:myapp/other/api_service.dart';
import '../components/ep_comp.dart';

class VisitProfilePage extends StatefulWidget {
  final String id;
  const VisitProfilePage({super.key, required this.id});

  @override
  State<VisitProfilePage> createState() => _VisitProfilePageState();
}

class _VisitProfilePageState extends State<VisitProfilePage> {
  List keyFeatures = [];
  bool isLoading = true;

  @override
  void initState() {
    getKeyFeatures(widget.id);
    super.initState();
  }

  getKeyFeatures(String id) async {
    final res = await ApiService.getKeyFeatures(id);
    setState(() {
      keyFeatures = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: const EpAppBar(
              title: "SortMyCollege",
              icon: Icons.more_vert,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileCard(),
                  const SizedBox(height: 5.0),
                  const FullSizeBtns(),
                  const AboutUs(),
                  const CourseSection(),
                  const FacultiesCard(),
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
                        onTap: () {},
                        btnName: "Send Enquiry",
                        textColor: Colors.white,
                        height: 40,
                        width: 160.w,
                        btnColor: const Color(0xff1F0A68))
                  ],
                ),
              ),
            ),
          );
  }
}

class GiveReviewSection extends StatefulWidget {
  const GiveReviewSection({
    super.key,
  });

  @override
  State<GiveReviewSection> createState() => _GiveReviewSectionState();
}

class _GiveReviewSectionState extends State<GiveReviewSection> {
  double rating_val = 1;
  String feedback_msg = '';
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            'Give a Review',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    rating_val = rating;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            // borderRadius: BorderRadius.circular(4),
          ),
          child: TextFormField(
            onChanged: (value) {
              feedback_msg = value;
            },
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  left: 8.0,
                ),
                hintText: 'comment',
                hintStyle: const TextStyle(color: Colors.black45),
                suffixIcon: IconButton(
                  onPressed: () async {
                    // var value = await ApiService.Feedback_councellor(
                    //     widget.id, rating_val, feedback_msg);
                    // if (value["error"] ==
                    //     "Feedback is already given by the user") {
                    //   Fluttertoast.showToast(
                    //       msg: "Feedback is already given by the user");

                    //   // EasyLoading.showToast(
                    //   //     value["error"],
                    //   //     toastPosition:
                    //   //         EasyLoadingToastPosition
                    //   //             .bottom);
                    // } else {
                    //   log("Valuee=>${value['messege']}");
                    //   (value["message"] ==
                    //       "Feedback has been successfully added");

                    //   Fluttertoast.showToast(
                    //       msg: "Feedback has been successfully added");
                    // }
                    // controller.clear();
                  },
                  icon: const Icon(
                    Icons.send_sharp,
                    size: 22,
                    color: Colors.black54,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    super.key,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  int pageNo = 0;
  final int totalItems = 10; // Adjust the total number of items here

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            'Reviews',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.26,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    setState(() {
                      pageNo = value;
                    });
                  },
                  itemCount: totalItems,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  const CircleAvatar(radius: 25),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Name",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  RatingBarIndicator(
                                    rating: 3.5,
                                    itemSize: 20,
                                    itemBuilder: (context, index) => const Icon(
                                        Icons.star,
                                        color: Colors.amber),
                                  ),
                                  const SizedBox(height: 8),
                                  const Expanded(
                                    child: Center(
                                      child: Text(
                                        "This app helps students prepare for entrance exams with a user-friendly interface, interactive content, and personalized study plans.",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < totalItems.clamp(0, 5); i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: pageNo % 5 == i
                              ? Colors.black
                              : Colors.grey.shade400,
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class KeyFeatures extends StatelessWidget {
  final List keyFeatures;
  const KeyFeatures({super.key, required this.keyFeatures});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Key Features",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // childAspectRatio: 3 / 2,
            ),
            itemCount: keyFeatures.length,
            itemBuilder: (context, index) {
              return Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  height: 50,
                  width: 65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 8, bottom: 4),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.account_balance_sharp,
                          size: 40,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        // SvgPicture.network(
                        //   "${keyFeatures[index]['key_features_icon']}",
                        //   placeholderBuilder: (BuildContext context) =>
                        //       const CircularProgressIndicator(),
                        // ),
                        Expanded(
                          child: Text(
                            "${keyFeatures[index]['name']}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
          const SizedBox(height: 25.0),
          const Faculties(),
        ],
      ),
    );
  }
}
