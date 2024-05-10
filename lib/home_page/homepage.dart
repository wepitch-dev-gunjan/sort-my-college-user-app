import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home_page/coming_soon.dart';
import 'package:myapp/home_page/counsellor_page/counsellor_details_screen.dart';
import 'package:myapp/home_page/drawer/drawer_1.dart';
import 'package:myapp/home_page/homepagecontainer_2.dart';
import 'package:myapp/home_page/model/popular_workshop_model.dart';
import 'package:myapp/home_page/model/tranding_webinar_model.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/page-1/dashboard_session_page.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widget/custom_webniar_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../other/api_service.dart';
import 'entrance_preparation/entrance_preparation_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  String username = "";
  String path = '';
  late var value;
  bool isFetched = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CounsellorDetailsProvider counsellorDetailsProvider =
  CounsellorDetailsProvider();

  @override
  void initState() {
    super.initState();
    //_startTimer();
    getAllInfo();
    counsellorDetailsProvider =
        Provider.of<CounsellorDetailsProvider>(context, listen: false);
    context.read<CounsellorDetailsProvider>().fetchBannerImage();
    context.read<CounsellorDetailsProvider>().fetchTrendingWebinar();
    context.read<CounsellorDetailsProvider>().fetchPopularWorkShop();
    imgUrlList.clear();
  }

  void getAllInfo() async {
    await ApiService.get_profile().then((value) => initPrefrence(value));
  }

  void saveImagePathToPrefs(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("profile_image_path", path);
  }

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 2),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  var str;
  List<String> imgUrlList = [];

  //var imgUrl;



  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    imgUrlList.clear();
    if (counsellorSessionProvider.bannerImageList.isNotEmpty)
    {
      for(int i=0; i < counsellorSessionProvider.bannerImageList.length; i++)
      {
        imgUrlList.add(counsellorSessionProvider.bannerImageList[i].url ??
            '');
      }
    }
    else{
      imgUrlList.add("https://img.freepik.com/free-vector/abstract-coming-soon-halftone-style-background-design_1017-27282.jpg?size=626&ext=jpg&ga=GA1.1.553209589.1715126400&semt=ais");
    }


    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop){
        SystemNavigator.pop();
      },
      child: Scaffold(
        drawer: const Drawer1(),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: ColorsConst.whiteColor,
          title: Row(
            children: [
              const SizedBox(
                width: 18,
              ),
              Expanded(
                child: Text(
                  'Hello, $username',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff1F0A68),
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                width: 30,
              )
            ],
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 30, top: 18, bottom: 18),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(
                'assets/page-1/images/group-59.png',
                color: const Color(0xff1F0A68),
              ),
            ),
          ),
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 12), child: Container()),
          titleSpacing: 1,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Notification2(),
                  ),
                );
              },
              child: Image.asset(
                'assets/page-1/images/bell.png',
                width: 18,
                height: 18,
                color: const Color(0xff1F0A68),
              ),
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
        body: counsellorSessionProvider.isNull ? const CircularProgressIndicator() : SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 110 * fem,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            onTapgotocounsellor(context);
                          },
                          child: Container(
                            width: 110 * fem,
                            height: 120 * fem,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/page-1/images/find_counsellor.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 34),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EntrancePreparationScreen()));
                          },
                          child: Visibility(
                            //visible: true,
                            child: Container(
                              width: 110 * fem,
                              height: 120 * fem,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/page-1/images/Group 793.png",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 112 * fem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ComingSoon()));
                            },
                            child: Container(
                              width: 110 * fem,
                              height: 120 * fem,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Color(0xff6450A8),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/page-1/images/Group 794.png",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 34,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const ComingSoon()));
                                  },
                                  child: Container(
                                    width: 140 * fem,
                                    height: 140 * fem,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff5273B4),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      "assets/page-1/images/Group 795.png",
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 120,
                    maxWidth: 390,
                  ),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  width: 390 * fem,
                  height: 120 * fem,
                   child:
                   ImageSlideshow(
                     autoPlayInterval: 6000,
                     isLoop: false,
                     indicatorColor: Colors.black,
                     indicatorBackgroundColor: Colors.white,
                     children:   imgUrlList
                         .map((e) => Container(
                         width: 390 * fem,
                         height: 120 * fem,
                         decoration: BoxDecoration(
                         borderRadius:
                         const BorderRadius.all(Radius.circular(16)),
                         image: DecorationImage(image: NetworkImage(e)),
                       ),
                     )).toList()
                   ),

                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 28.0 * fem),
                child: const Row(
                  children: [
                    Text(
                      'Popular Workshops',
                      style: TextStyle(
                        color: Color(0xFF1F0A68),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: counsellorSessionProvider.popularWorkShopList.isEmpty
                  ? const Center(
                        child: Text("No Data Found"),
                     )
                    :ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const PageScrollPhysics(),
                    itemCount:
                    counsellorSessionProvider.popularWorkShopList.length,
                    itemBuilder: (context, index) {
                      PopularWorkShopModel popular =
                      counsellorSessionProvider.popularWorkShopList[index];
                      return profileCard(popular, index,
                        counsellorSessionProvider.popularWorkShopList.length,);
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 28.0 * fem),
                child: const Row(
                  children: [
                    Text(
                      'Trending Webinars',
                      style: TextStyle(
                        color: Color(0xFF1F0A68),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 14, right: 14, bottom: 0, top: 2),
                child: counsellorSessionProvider.trendingWebinarList.isEmpty
                  ? const Center(
                      child: Text("No Data Found"),
                     )
                    :ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: counsellorSessionProvider.trendingWebinarList.length,
                    itemBuilder: (context, index) {
                      TrandingWebinarModel trending = counsellorSessionProvider.trendingWebinarList[index];
                      return Column(
                        children: [
                          Card(
                            shadowColor: ColorsConst.whiteColor,
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 190,
                                  // width: 390,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage(trending.webinarImage!),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 8, 20, 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trending.webinarBy!,
                                        style: SafeGoogleFont(
                                          "Inter",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                trending.webinarDate!,
                                                style: SafeGoogleFont(
                                                  "Inter",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                trending.webinarTitle!,
                                                style: SafeGoogleFont(
                                                  "Inter",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // customEnrollButton(
                                          //     onPresssed: () {},
                                          //     title: "Free Enroll",
                                          //     context: context)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        height: 1,
                                        width: double.infinity,
                                        color: const Color(0xffAFAFAF),
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Share.share(
                                                    'https://play.google.com/store/apps/details?id=com.sortmycollege');
                                              },
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/page-1/images/group-38-oFX.png",
                                                  width: 20,
                                                  height: 20,
                                                  color: Color(0xFF1F0A68),
                                                ),
                                              ),
                                            ),
                                            registerNowWidget(
                                              onPressed: () async {
                                                if (!trending.registered!) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          'Do you want to register for the webinar?',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () async {
                                                              if (trending
                                                                  .registered! &&
                                                                  trending.webinarStartingInDays ==
                                                                      0) {
                                                                launchUrlString(
                                                                    trending
                                                                        .webinarJoinUrl!);
                                                              } else if (trending
                                                                  .registered!) {
                                                                Fluttertoast
                                                                    .showToast(
                                                                    msg:
                                                                    'Participant is already registered');
                                                              } else {
                                                                var value = await ApiService
                                                                    .webinar_regiter(
                                                                    trending
                                                                        .id!);

                                                                if (value[
                                                                "error"] ==
                                                                    "Participant is already registered") {
                                                                  Fluttertoast
                                                                      .showToast(
                                                                      msg:
                                                                      'Participant is already registered');
                                                                } else if (value[
                                                                "message"] ==
                                                                    "Registration completed") {
                                                                  Fluttertoast
                                                                      .showToast(
                                                                      msg:
                                                                      'Registration completed Thanks for registration');
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                      const HomePage(),
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                              if (mounted) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                              //await _updateRegistrationStatus(true);
                                                            },
                                                            child:
                                                            const Text('Yes'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  Text('has Been Registered');
                                                }
                                              },
                                              title: trending.registered!
                                                  ? (trending.webinarStartingInDays ==
                                                  0
                                                  ? 'Join Now'
                                                  : 'Starting in ${trending.webinarStartingInDays} days')
                                                  : 'Join Now',
                                              isRegisterNow: trending.registered!,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomWebinarCard buildCustomWebinarCard(
      TrandingWebinarModel trending,
      ) {
    return CustomWebinarCard(
      trandingWebinarModel: trending,
    );
  }

  Widget profileCard(PopularWorkShopModel popularWorkShopModel, int cardIndex,
      int totalCards) {
    var width = MediaQuery.of(context).size.width;
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    str = counsellorSessionProvider.popularWorkShopList[0].sessionDate
        ?.split('T');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundImage: AssetImage(
                      'assets/page-1/images/comming_soon.png',
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            popularWorkShopModel.sessionUser ?? "N/A",
                            style: const TextStyle(
                              color: Color(0xFF1F0A68),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Share.share(
                                  'https://play.google.com/store/apps/details?id=com.sortmycollege');
                            },
                            child: Center(
                              child: Image.asset(
                                "assets/page-1/images/group-38-oFX.png",
                                color: Color(0xFF1F0A68),
                                height: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        width: 190.25,
                        child: Text(
                          popularWorkShopModel.sessionType!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/page-1/images/clock-circular-outline-Ra1.png",
                            // color: Colors.black,
                            height: 12,
                            width: 12,
                          ),
                          const SizedBox(
                            width: 4,
                          ),

                          /*SizedBox(
                            width: 121.13,
                            child: Text(
                              popularWorkShopModel.sessionTime != null
                                  ? DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(popularWorkShopModel.sessionTime!))
                                  : 'N/A',
                              style: const TextStyle(
                                color: Color(0xFF414040),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                              ),
                            ),
                          )*/
                          SizedBox(
                            width: 121.13,
                            child: Text(
                              popularWorkShopModel.sessionTime != null
                                  ? '${(popularWorkShopModel.sessionTime! ~/ 60) % 12}:${(popularWorkShopModel.sessionTime! % 60).toString().padLeft(2, '0')} ${(popularWorkShopModel.sessionTime! ~/ 60) < 12 ? 'AM' : 'PM'}'
                                  : 'N/A',
                              // popularWorkShopModel.sessionTime != null
                              //     ? DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(popularWorkShopModel.sessionTime!))
                              //     : 'N/A',
                              style: const TextStyle(
                                color: Color(0xFF414040),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                              ),
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/page-1/images/calender.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          SizedBox(
                            width: 121.13,
                            child: Text(
                              str[0],
                              style: const TextStyle(
                                color: Color(0xFF414040),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage("assets/page-1/images/rate.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SizedBox(
                            width: 121.13,
                            child: Text(
                              ' ${popularWorkShopModel.sessionFee}',
                              style: const TextStyle(
                                color: Color(0xFF414040),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 0.47,
                width: width * 0.85,
                color: const Color(0xffAFAFAF).withOpacity(.78),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.014,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CounsellorDetailsScreen(
                                  id: popularWorkShopModel.sessionCounsellor!,
                                  designation: "designation",
                                  profilepicurl: "data:image/jpeg;base64,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",
                                  name: popularWorkShopModel.sessionUser ??
                                      "NA"
                              )));
                    },
                    child: Container(
                      width: 120.14,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            color: Colors.black.withOpacity(0.7400000095367432),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const SizedBox(
                        width: 119.09,
                        height: 16.05,
                        child: Center(
                          child: Text(
                            'Visit Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF262626),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.07,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 14),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CounsellingSessionPage(
                                name: 'N/A',
                                id: popularWorkShopModel.sId!,
                                designation: '',
                                profileurl: "https://www.shutterstock.com/shutterstock/photos/1809858361/display_1500/stock-vector-photo-coming-soon-vector-image-picture-graphic-content-album-stock-photos-not-avaliable-1809858361.jpg",
                                selectedIndex_get: 0,
                              )));
                    },
                    child: Container(
                      width: 120,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: const Color(0xff1F0A68),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const SizedBox(
                        width: 119.09,
                        height: 14.05,
                        child: Center(
                          child: Text(
                            'Book Now',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.07,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalCards, (index) {
                  return Icon(
                    index == cardIndex ? Icons.circle : Icons.circle_outlined,
                    color: const Color(0xff1F0A68),
                    size: 8,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapgotocounsellor(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomePageContainer_2()));
  }

  initPrefrence(Map<String, dynamic> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(value["message"] == "successfully get data")
     {
       path = prefs.getString("profile_image_path") ?? " ";
       username = prefs.getString("name") ?? "";
     }
    else{
      username="user";
    }


  }




}
