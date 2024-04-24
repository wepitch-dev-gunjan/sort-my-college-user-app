import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myapp/home_page/entrance_preparation/announcements_screen.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/model/cousnellor_list_model.dart';
import 'package:myapp/model/follower_model.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/provider/follower_provider.dart';
import 'package:myapp/other/provider/user_booking_provider.dart';
import 'package:myapp/page-1/counslleing_session2.dart';
import 'package:myapp/page-1/dashboard_session_page.dart';
import 'package:myapp/page-1/payment_gateaway.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../other/api_service.dart';

class EntrancePreparationDetailsScreen extends StatefulWidget {
  const EntrancePreparationDetailsScreen({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.buildingNumber,
    required this.area,
    required this.city,
    required this.state,
    required this.pinCode,
    super.key,
  });
  final String name;
  final String id;
  final String imgUrl;
  final String buildingNumber;
  final String area;
  final String city;
  final String state;
  final String pinCode;

  @override
  State<EntrancePreparationDetailsScreen> createState() => _EntrancePreparationDetailsScreenState();
}

class _EntrancePreparationDetailsScreenState
    extends State<EntrancePreparationDetailsScreen>
    with SingleTickerProviderStateMixin {
  //final ListController listController = Get.put(ListController());
  late FollowerProvider followerProvider;
  FollowerModel followerModel = FollowerModel();
  TextEditingController controller = TextEditingController();

  bool visible = false;
  late TabController _controller;
  List<CounsellorModel> counsellorModel = [];
  bool isFollowing = false;
  int followerCount = 0;
  bool hasFollowedBefore = false;
  double rating_val = 0;
  String feedback_msg = '';

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }


  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    // checkImageValidity(counsellorDetailController
    //     .cousnellorlist_detail[0].coverImage);
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        surfaceTintColor: ColorsConst.whiteColor,
        titleSpacing: -16,
        title: Text(
          // anshikamehra7w6 (2608:501)
          widget.name,
          style: SafeGoogleFont(
            'Inter',
            fontSize: 17,
            fontWeight: FontWeight.w500,
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
                  color: Color(0xff1F0A68),
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
      body: Column(
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
                            width: double.infinity,
                            height: 201,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.imgUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    'assets/page-1/images/comming_soon.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_sharp,
                                      size: 20,
                                    ),
                                    Text('${widget.buildingNumber} ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400

                                        ) ),
                                    Text('${widget.area} ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400

                                        ) ),
                                    Text('${widget.state} ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400

                                        ) ),
                                    Text('${widget.city} ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400

                                        ) ),
                                    Text(widget.pinCode,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400

                                        ) ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      size: 16,
                                    ),
                                    Text(
                                      ' Open until 9:00 PM',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.amber,size: 18,),
                                    Text(' 4.9 (986)',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400
                                        )
                                    ),
                                  ],
                                ), SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.arrow_circle_right_rounded,size: 18,),
                                    Text(' Direction'),
                                  ],
                                )
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                // hasFollowedBefore
                                //     ? Container()
                                //     :
                                Container(
                                  width: 110,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff1f0a68)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor:  const Color(0xff1f0a68),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Follow',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2125,
                                          color:  const Color(0xffffffff),
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
                                      // followingweY (2958:442)
                                      "456 Following",
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    color: Colors.grey[100],
                    child: TabBar(
                        indicatorColor: const Color(0xff1F0A68),
                        indicatorWeight: 2,
                        controller: _controller,
                        onTap: (value) {
                          if (value == 1) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AnnouncementsScreen()));
                          }
                        },
                        tabs: [
                          Tab(
                            child: Text(
                              "Info",
                              style: SafeGoogleFont("Inter",
                                  fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Announcements",
                              style: SafeGoogleFont("Inter",
                                  fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                            ),
                          ),
                        ]),
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
                          'About us',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '\u2022 ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              'Lorem Ipsum is simply dummy text of the printing',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\u2022 ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "Typesetting industry. Lorem Ipsum has been the ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\u2022 ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "Industry's standard dummy text ever since the 1500s",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\u2022 ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "Industry's standard dummy text ever since the 1500s",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Read more....',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 14),
                        const Text('Courses Offered',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        const Divider(indent: 16,endIndent: 16),
                        const Text(
                          'Undergraduate Courses',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.2125,
                            color: Color(0xff000000),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 54,
                              decoration: BoxDecoration(
                                color: ColorsConst.appBarColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(child: Text('NEET',style: TextStyle(color: ColorsConst.whiteColor),)),
                            ),
                            Container(
                              height: 30,
                              width: 54,
                              decoration: BoxDecoration(
                                color: ColorsConst.appBarColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(child: Text('JEE',style: TextStyle(color: ColorsConst.whiteColor),)),
                            ),
                            Container(
                              height: 30,
                              width: 54,
                              decoration: BoxDecoration(
                                color: ColorsConst.appBarColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(child: Text('CLAT',style: TextStyle(color: ColorsConst.whiteColor),)),
                            ),
                            Container(
                              height: 30,
                              width: 54,
                              decoration: BoxDecoration(
                                color: ColorsConst.appBarColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(child: Text('CUET',style: TextStyle(color: ColorsConst.whiteColor),)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Postgraduate Courses',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.2125,
                            color: Color(0xff000000),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 54,
                              decoration: BoxDecoration(
                                color: ColorsConst.appBarColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(child: Text('NEET',style: TextStyle(color: ColorsConst.whiteColor),)),
                            ),
                            Container(
                              height: 30,
                              width: 54,
                              decoration: BoxDecoration(
                                color: ColorsConst.appBarColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(child: Text('JEE',style: TextStyle(color: ColorsConst.whiteColor),)),
                            ),
                            Container(
                              height: 30,
                              width: 54,
                              decoration: BoxDecoration(
                                color: ColorsConst.appBarColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(child: Text('CUT',style: TextStyle(color: ColorsConst.whiteColor),)),
                            ),
                            Container(
                              height: 30,
                              width: 54,
                              decoration: BoxDecoration(
                                color: ColorsConst.appBarColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(child: Text('CUET',style: TextStyle(color: ColorsConst.whiteColor),)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Faculties',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.2125,
                                color: Color(0xff000000),
                              ),
                            ),
                            Text(
                              'View',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.2125,
                                color: ColorsConst.appBarColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                color: ColorsConst.whiteColor,
                                surfaceTintColor: ColorsConst.whiteColor,
                                elevation: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 0,top: 10,right: 0),
                                  width: 220,
                                  height: 70,
                                  decoration: const BoxDecoration(),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text('Dr.kumar',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                          Text('MBBS and MS in',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                      Icon(Icons.account_circle,size: 50,color: ColorsConst.blueColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                color: ColorsConst.whiteColor,
                                surfaceTintColor: ColorsConst.whiteColor,
                                child: Container(
                                  padding: EdgeInsets.only(left: 20,top: 12,right: 20),
                                  width: 328,
                                  height: 70,
                                  decoration: BoxDecoration(),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text('Dr.kumar',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                          Text('MBBS and MS in',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      Icon(Icons.account_circle,size: 50,color: ColorsConst.blueColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                color: ColorsConst.whiteColor,
                                surfaceTintColor: ColorsConst.whiteColor,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20,top: 12,right: 20),
                                  width: 328,
                                  height: 70,
                                  decoration: const BoxDecoration(),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text('Dr.kumar',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                          Text('MBBS and MS in',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      Icon(Icons.account_circle,size: 50,color: ColorsConst.blueColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text('Key Features', style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.2125,
                          color: Color(0xff000000),
                        ),),                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 90,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xffFFFFFF),
                                  border: Border.all(color: Colors.black12)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.mobile_screen_share_rounded),
                                  Text('Free Demo\nClasses'),
                                ],
                              ),
                            ),
                            Container(
                              height: 90,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xffFFFFFF),
                                  border: Border.all(color: Colors.black12)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.newspaper),
                                  Text('Online Test\nSeries'),
                                ],
                              ),
                            ),
                            Container(
                              height: 90,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xffFFFFFF),
                                  border: Border.all(color: Colors.black12)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.ten_mp_sharp),
                                  Text('Mock Test'),
                                ],
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.26,
                          child: PageView(
                            children: [
                              buildPadding(),
                              buildPadding(),
                              buildPadding(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text('Give a Review',
                            style: TextStyle(fontWeight: FontWeight.bold)),
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
                                hintText: 'commit',
                                hintStyle: TextStyle(color: Colors.black45),
                                suffixIcon: IconButton(
                                  onPressed: () async {

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
                            border: Border.all(color: const Color(0x35000000)),
                          ),
                          child: SizedBox(
                            // group370NiL (2936:483)
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      // group349P36 (2936:462)
                                      width: 116 * fem,
                                      height: 20 * double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5 * fem),
                                      ),
                                      child: Center(
                                        child: Center(
                                          child: Text(
                                            'Interested ?',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2125 * ffem / fem,
                                              color: ColorsConst.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      // group349P36 (2936:462)
                                      width: 116 * fem,
                                      height: 60 * fem,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff1f0a68),
                                        borderRadius:
                                        BorderRadius.circular(5 * fem),
                                      ),
                                      child: Center(
                                        child: Center(
                                          child: Text(
                                            'Send Enquiry',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.2125 * ffem / fem,
                                              color: const Color(0xffffffff),
                                            ),
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
                  const SizedBox(height: 8),
                  Text('Alex'),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star_outline, color: Colors.amber, size: 18),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('good'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void onTapBook(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const PaymentGateAway()));
}
