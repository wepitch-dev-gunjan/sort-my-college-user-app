import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myapp/model/cousnellor_list_model.dart';
import 'package:myapp/model/follower_model.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/provider/follower_provider.dart';
import 'package:myapp/page-1/dashboard_session_page.dart';
import 'package:myapp/page-1/payment_gateaway.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../other/api_service.dart';

class CounsellorDetailsScreen extends StatefulWidget {
  const CounsellorDetailsScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  State<CounsellorDetailsScreen> createState() =>
      _CounsellorDetailsScreenState();
}

class _CounsellorDetailsScreenState extends State<CounsellorDetailsScreen>
    with SingleTickerProviderStateMixin {
  late FollowerProvider followerProvider;
  FollowerModel followerModel = FollowerModel();
  TextEditingController controller = TextEditingController();

  bool visible = false;
  late TabController _controller;
  List<CounsellorModel> counsellorModel = [];
  bool isFollowLoading = false;
  bool isFollowing = false;
  int followerCount = 0;
  bool isLoading = true;

  bool hasFollowedBefore = false;
  double rating_val = 0;
  String feedback_msg = '';

  setIsFollowingLoading(bool state) {
    setState(() {
      isFollowLoading = state;
    });
  }

  var counsellor;

  @override
  void initState() {
    super.initState();
    fetchCounsellorDetail();

    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  Future<void> fetchCounsellorDetail() async {
    counsellor = await ApiService.getCounsellor_Detail(widget.id);
    setState(() {
      isFollowing = counsellor['following'];
      followerCount = counsellor['followers'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('counsellorData=>>>>$counsellor');
    var counsellorDetailController = context.watch<CounsellorDetailsProvider>();
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        surfaceTintColor: ColorsConst.whiteColor,
        titleSpacing: -16,
        title: isLoading == true
            ? const ShimmerEffect(
                height: 10,
                width: 200,
              )
            : Text(
                counsellor['name'],
                style: SafeGoogleFont(
                  'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.2125,
                  color: const Color(0xff1f0a68),
                ),
              ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Share.share(
                      'https://play.google.com/store/apps/details?id=com.sortmycollege');
                },
                child: Image.asset(
                  "assets/page-1/images/share.png",
                  color: const Color(0xff1F0A68),
                  height: 23,
                ),
              )),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff1f0a68))),
        backgroundColor: const Color(0xffffffff),
      ),
      body: isLoading == true
          ? const CounsellorShimmerEffect()
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Align(
                                child: SizedBox(
                                  width: 398,
                                  height: 201,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: isLoading == true
                                        ? const ShimmerEffect(
                                            height: 201,
                                            width: 200,
                                          )
                                        : Image.network(
                                            (counsellorDetailController
                                                    .cousnellorlist_detail
                                                    .isNotEmpty)
                                                ? counsellorDetailController
                                                    .cousnellorlist_detail[0]
                                                    .coverImage
                                                : '',
                                            fit: BoxFit.fill,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Image.network(
                                                counsellor['cover_image'],
                                                // 'assets/page-1/images/comming_soon.png',
                                                fit: BoxFit.fill,
                                              );
                                            },
                                          ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text(
                                            counsellor['name'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff1f0a68),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                              'assets/page-1/images/group-MqT.png',
                                              width: 15,
                                              height: 15.35),
                                          const SizedBox(width: 6),
                                          Text(
                                            "${counsellor['average_rating']}",
                                            // (counsellor['average_rating'] == '')
                                            //     ? '${counsellor['average_rating'].toStringAsFixed(2)} (${counsellor['client_testimonials']!.where((testimonial) => testimonial.rating != 0).length})'
                                            //     : '0',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 6),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/page-1/images/group-ZqT.png',
                                            width: 15,
                                            height: 15.27,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Total ${counsellor['booked_sessions']} Session Attended',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 37,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff1f0a68)),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            log("Following => ${counsellor['following']}");
                                            if (isFollowing) {
                                              var value = await ApiService
                                                  .Unfollow_councellor(
                                                      counsellor['_id'],
                                                      setIsFollowingLoading);

                                              isFollowing =
                                                  value["data"]["followed"];
                                              followerCount = followerCount - 1;

                                              setState(() {});
                                            } else {
                                              var value = await ApiService
                                                  .Follow_councellor(
                                                      counsellor['_id'],
                                                      setIsFollowingLoading);

                                              isFollowing =
                                                  value["data"]["followed"];
                                              followerCount = followerCount + 1;

                                              setState(() {});
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor: isFollowing
                                                ? Colors.white
                                                : const Color(0xff1f0a68),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          child: Center(
                                            child: isFollowLoading
                                                ? const SizedBox(
                                                    height: 15,
                                                    width: 15,
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.white,
                                                      strokeWidth: 2.0,
                                                    ))
                                                : Text(
                                                    isFollowing
                                                        ? 'Following'
                                                        : 'Follow',
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.2125,
                                                      color: isFollowing
                                                          ? Colors.black
                                                          : const Color(
                                                              0xffffffff),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/page-1/images/group-NC9.png',
                                            width: 16,
                                            height: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '$followerCount '
                                            "Following",
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              height: 1.2125,
                                              color: const Color(0xff5c5b5b),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text('Experience',
                                          style: TextStyle(
                                              color: ColorsConst.black54Color)),
                                      Text(
                                        '${counsellor['experience_in_years']} + yrs',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Column(
                                    children: [
                                      Text(
                                        '|',
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('Session',
                                          style: TextStyle(
                                              color: ColorsConst.black54Color)),
                                      Text(
                                        '${counsellor['sessions']}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Column(
                                    children: [
                                      Text(
                                        '|',
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('Rewards',
                                          style: TextStyle(
                                              color: ColorsConst.black54Color)),
                                      Text(
                                        '${counsellor['reward_points']}',
                                        // Or any other placeholder text to indicate absence of rating
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Column(
                                    children: [
                                      Text(
                                        '|',
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('Reviews',
                                          style: TextStyle(
                                              color: ColorsConst.black54Color)),
                                      Text(
                                        '${counsellor['reviews']}',
                                        // Or any other placeholder text to indicate absence of reviews
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'How Will I Help?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              ReadMoreText(
                                counsellor['how_will_i_help']
                                    .map((e) => "\u2022 $e")
                                    .join("\n"),
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 2,
                                  color: const Color(0xFF595959),
                                ),
                                trimLines: 1,
                                trimCollapsedText: "\nRead more..",
                                trimExpandedText: "\nShow less..",
                                moreStyle: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5549999555,
                                  color: const Color(0xff040404),
                                ),
                                lessStyle: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5549999555,
                                  color: const Color(0xff040404),
                                ),
                              ),

                              const SizedBox(height: 12),
                              const Text(
                                'More Information',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset(
                                    'assets/page-1/images/diploma.png',
                                    fit: BoxFit.cover,
                                    height: 18,
                                    width: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    counsellor['qualifications'].join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.7034202251,
                                      color: Color(0xff8e8989),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/page-1/images/group-369.png',
                                    width: 18,
                                    height: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    counsellor['languages_spoken'].join(", "),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2125,
                                      color: Color(0xff8e8989),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/page-1/images/maps-and-flags.png',
                                    fit: BoxFit.cover,
                                    height: 18,
                                    width: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${counsellor['location']['country'] ?? ''}, ${counsellor['location']['state'] ?? ''}, ${counsellor['location']['city'] ?? ''}, ${counsellor['location']['pin_code'] ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2125,
                                      color: Color(0xff8e8989),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/page-1/images/sex.png',
                                    fit: BoxFit.cover,
                                    height: 17,
                                    width: 17,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    counsellor['gender'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2125,
                                      color: Color(0xff8e8989),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/page-1/images/age.png',
                                    fit: BoxFit.cover,
                                    height: 18,
                                    width: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    counsellor['age'].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2125,
                                      color: Color(0xff8e8989),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              counsellor['client_testimonials'].isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Client Testimonials',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2125,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.26,
                                          child: PageView.builder(
                                            //physics: const PageScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: counsellor[
                                                        'client_testimonials']!
                                                    .length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              final testimonial = counsellor[
                                                  'client_testimonials'][index];
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: Card(
                                                      surfaceTintColor:
                                                          ColorsConst
                                                              .whiteColor,
                                                      color: Colors.white,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 14),
                                                          Center(
                                                            child: Container(
                                                              height: 46,
                                                              width: 46,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .black26,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Center(
                                                                child: ClipOval(
                                                                  child: Image
                                                                      .network(
                                                                    testimonial[
                                                                            'profile_pic'] ??
                                                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9b7ve9oIilsA8oz5bbsrKZvAe2oT7ESuFKKUO3eHWRL0LEnOQnzz4lRHYAg&s',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 12),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                'assets/page-1/images/group-MqT.png',
                                                                width: 15,
                                                                height: 15.35,
                                                              ),
                                                              const SizedBox(
                                                                  width: 6),
                                                              Text(
                                                                testimonial['rating'] !=
                                                                        null
                                                                    ? '${testimonial['rating']}'
                                                                    : '1',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 12),
                                                          Center(
                                                            child: Text(
                                                              testimonial[
                                                                      'message'] ??
                                                                  'good',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 14),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // const Icon(
                                                  //   Icons.arrow_forward_ios,
                                                  //   size: 20,
                                                  // ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                              const SizedBox(height: 16),
                              const Text('Give a Review',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: 1,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 18,
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
                              const SizedBox(height: 20),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    feedback_msg = value;
                                  },
                                  controller: controller,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                          left: 8.0, top: 14, bottom: 10),
                                      hintText: 'comment',
                                      hintStyle: const TextStyle(
                                          color: Colors.black45),
                                      suffixIcon: IconButton(
                                        onPressed: () async {
                                          var value = await ApiService
                                              .Feedback_councellor(widget.id,
                                                  rating_val, feedback_msg);
                                          if (value["error"] ==
                                              "Feedback is already given by the user") {
                                            EasyLoading.showToast(
                                                value["error"],
                                                toastPosition:
                                                    EasyLoadingToastPosition
                                                        .bottom);
                                          } else {
                                            (value["message"] ==
                                                "Feedback has been successfully added");
                                            EasyLoading.showToast(
                                                value["message"],
                                                toastPosition:
                                                    EasyLoadingToastPosition
                                                        .bottom);
                                          }
                                          controller.clear();
                                        },
                                        icon: const Icon(
                                          Icons.send_sharp,
                                          size: 22,
                                          color: Colors.black54,
                                        ),
                                      )),
                                ),
                              ),
                              // HiddenText(
                              //     id: '${userBookings[0].bookedEntity?.clientTestimonials?[0].id}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  // group371aXa (2936:506)
                  //width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        // autogroupuuww8oz (obZ7jq9Hv3ndwJa9LuuwW)
                        width: double.infinity,
                        height: 113 * fem,
                        child: Stack(
                          children: [
                            Positioned(
                              // frame324GvC (2936:447)
                              left: 0 * fem,
                              top: 55 * fem,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    16 * fem, 8 * fem, 16 * fem, 8 * fem),
                                width: 430 * fem,
                                height: 57 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0x35000000)),
                                ),
                                child: SizedBox(
                                  // group370NiL (2936:483)
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // group347Kda (2936:448)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 115 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // group345fBe (2936:458)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  5 * fem,
                                                  0 * fem),
                                              width: 42 * fem,
                                              height: double.infinity,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    // group298bLC (2936:459)
                                                    left: 0 * fem,
                                                    top: 0 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 42 * fem,
                                                        height: 41 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/group-298.png',
                                                          width: 42 * fem,
                                                          height: 41 * fem,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    // conversationi9v (2936:461)
                                                    left: 10.7692871094 * fem,
                                                    top: 9.4614257812 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 21.54 * fem,
                                                        height: 21.03 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/conversation.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // group346qEY (2936:449)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0.5 * fem,
                                                  0 * fem,
                                                  1 * fem),
                                              width: 115 * fem,
                                              height: double.infinity,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 0 * fem,
                                                    top: 14 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 120 * fem,
                                                        height: 15 * fem,
                                                        child: Text(
                                                          'Personal Session',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 12 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 1.2125 *
                                                                ffem /
                                                                fem,
                                                            color: const Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return CounsellingSessionPage(
                                              id: widget.id,
                                              name: counsellor['name'],
                                              designation:
                                                  counsellor['designation'],
                                              profileurl:
                                                  counsellor['profile_pic'],
                                              selectedIndex_get: 1,
                                            );
                                          }));
                                        },
                                        child: Container(
                                          width: 116 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff1f0a68),
                                            borderRadius:
                                                BorderRadius.circular(5 * fem),
                                          ),
                                          child: Center(
                                            child: Center(
                                              child: Text(
                                                'Book',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 16 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2125 * ffem / fem,
                                                  color:
                                                      const Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0 * fem,
                              top: 0 * fem,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    16 * fem, 8 * fem, 16 * fem, 8 * fem),
                                width: 430 * fem,
                                height: 57 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0x35000000)),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 123 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  8 * fem,
                                                  0 * fem),
                                              width: 42 * fem,
                                              height: double.infinity,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 0 * fem,
                                                    top: 0 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 42 * fem,
                                                        height: 41 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/ellipse-47-xPB.png',
                                                          width: 42 * fem,
                                                          height: 41 * fem,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 11 * fem,
                                                    top: 10 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 21 * fem,
                                                        height: 21 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/usergroup.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0.5 * fem,
                                                  0 * fem,
                                                  1 * fem),
                                              width: 105 * fem,
                                              height: double.infinity,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 0 * fem,
                                                    top: 14 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 120 * fem,
                                                        height: 15 * fem,
                                                        child: Text(
                                                          'Group Session',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 12 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 1.2125 *
                                                                ffem /
                                                                fem,
                                                            color: const Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CounsellingSessionPage(
                                                        id: widget.id,
                                                        name:
                                                            counsellor['name'],
                                                        profileurl: counsellor[
                                                            'profile_pic'],
                                                        designation: counsellor[
                                                            'designation'],
                                                        selectedIndex_get: 0,
                                                      )));
                                        },
                                        child: Container(
                                          width: 116 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff1f0a68),
                                            borderRadius:
                                                BorderRadius.circular(5 * fem),
                                          ),
                                          child: Center(
                                            child: Center(
                                              child: Text(
                                                'Book',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 16 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2125 * ffem / fem,
                                                  color:
                                                      const Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
          Expanded(
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/page-1/images/comming_soon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Very good counsellor'),
                ],
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

class CounsellorShimmerEffect extends StatelessWidget {
  const CounsellorShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 201,
                  width: 398,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 40),
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerEffect extends StatelessWidget {
  final double? height, width;
  const ShimmerEffect({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: const Color.fromARGB(255, 255, 255, 255),
      highlightColor: const Color.fromARGB(255, 214, 214, 214),
      child: Container(
        height: height,
        width: width,
        color: const Color.fromARGB(255, 233, 233, 233),
      ),
    );
  }
}

void onTapBook(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const PaymentGateAway()));
}
