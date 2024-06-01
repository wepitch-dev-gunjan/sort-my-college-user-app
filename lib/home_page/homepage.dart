import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myapp/home_page/coming_soon.dart';
import 'package:myapp/home_page/counsellor_page/counsellor_details_screen.dart';
import 'package:myapp/home_page/drawer/drawer_1.dart';
import 'package:myapp/home_page/homepagecontainer_2.dart';
import 'package:myapp/home_page/model/popular_workshop_model.dart';
import 'package:myapp/home_page/model/tranding_webinar_model.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/webinar_page/webinar_details_page.dart';
import 'package:myapp/widget/custom_webniar_card_widget.dart';
import 'package:myapp/widget/webinar_detail_page_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../booking_page/checkout_screen.dart';
import '../other/api_service.dart';
import '../page-1/dashboard_session_page.dart';
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
  bool has24HoursPassed = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CounsellorDetailsProvider counsellorDetailsProvider =
      CounsellorDetailsProvider();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    imgUrlList.clear();
    if (counsellorSessionProvider.bannerImageList.isNotEmpty) {
      for (int i = 0;
          i < counsellorSessionProvider.bannerImageList.length;
          i++) {
        imgUrlList.add(counsellorSessionProvider.bannerImageList[i].url ?? '');
      }
    } else {
      imgUrlList.add(
          "https://img.freepik.com/free-vector/abstract-coming-soon-halftone-style-background-design_1017-27282.jpg?size=626&ext=jpg&ga=GA1.1.553209589.1715126400&semt=ais");
    }

    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
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
              preferredSize: const Size(double.infinity, 12),
              child: Container()),
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
        body: counsellorSessionProvider.isNull
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
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
                                    color: const Color(0xffffffff),
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
                                          builder: (context) =>
                                              const EntrancePreparationScreen()));
                                },
                                child: Visibility(
                                  //visible: true,
                                  child: Container(
                                    width: 110 * fem,
                                    height: 120 * fem,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
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
                                            builder: (context) =>
                                                const ComingSoon()));
                                  },
                                  child: Container(
                                    width: 110 * fem,
                                    height: 120 * fem,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff6450A8),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 4),
                                                blurRadius: 4,
                                                color: Colors.black
                                                    .withOpacity(0.1),
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        width: 390 * fem,
                        height: 120 * fem,
                        child: ImageSlideshow(
                            autoPlayInterval: 6000,
                            isLoop: true,
                            indicatorColor: Colors.black,
                            indicatorBackgroundColor: Colors.white,
                            children: imgUrlList
                                .map((e) => Container(
                                      width: 390 * fem,
                                      height: 120 * fem,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        image: DecorationImage(
                                            image: NetworkImage(e)),
                                      ),
                                    ))
                                .toList()),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    counsellorSessionProvider.popularWorkShopList.isEmpty
                        ? const SizedBox()
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 28.0 * fem),
                                child: const Row(
                                  children: [
                                    Text(
                                      'Latest Sessions',
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
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: counsellorSessionProvider
                                        .popularWorkShopList.isEmpty
                                    ? const Center(
                                        child: Text("No Data Found"),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        // physics: const PageScrollPhysics(),
                                        itemCount: counsellorSessionProvider
                                            .popularWorkShopList.length,
                                        itemBuilder: (context, index) {
                                          LatestSessionsModel popular =
                                              counsellorSessionProvider
                                                  .popularWorkShopList[index];
                                          return profileCard(
                                            popular,
                                            index,
                                            counsellorSessionProvider
                                                .popularWorkShopList.length,
                                          );
                                        }),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    counsellorSessionProvider.trendingWebinarList.isEmpty
                        ? const SizedBox()
                        : Column(
                            children: [
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
                                padding: const EdgeInsets.only(
                                    left: 14, right: 14, bottom: 0, top: 2),
                                child: counsellorSessionProvider
                                        .trendingWebinarList.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 100),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: counsellorSessionProvider
                                            .trendingWebinarList.length,
                                        itemBuilder: (context, index) {
                                          TrandingWebinarModel trending =
                                              counsellorSessionProvider
                                                  .trendingWebinarList[index];
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  DateTime registrationDate =
                                                      DateTime.parse(trending
                                                          .registeredDate!);
                                                  log("Trendinggggggggggg=> ${trending}");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => WebinarDetailsPageWidget(
                                                            webinarId:
                                                                trending.id,
                                                            webinarImg: trending
                                                                .webinarImage,
                                                            webinarTitle: trending
                                                                .webinarTitle,
                                                            webinarDate: trending
                                                                .webinarDate,
                                                            webinarBy: trending
                                                                .webinarBy,
                                                            webinarStartDays:
                                                                trending
                                                                    .webinarStartingInDays,
                                                            webinarRegister:
                                                                trending
                                                                    .registered!,
                                                            registrationDate:
                                                                registrationDate,
                                                            webinarJoinUrl: trending
                                                                .webinarJoinUrl)

                                                        //     WebinarDetailsPage(
                                                        //   registerd: trending
                                                        //       .registered!,
                                                        //   webinarBy:
                                                        //       trending.webinarBy!,
                                                        //   image: trending
                                                        //       .webinarImage!,
                                                        //   webinarTitle: trending
                                                        //       .webinarTitle!,
                                                        //   webinarDate: trending
                                                        //       .webinarDate!,
                                                        // ),
                                                        ),
                                                  );
                                                },
                                                child: Card(
                                                  shadowColor:
                                                      ColorsConst.whiteColor,
                                                  color: Colors.white,
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 190,
                                                        // width: 390,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  trending
                                                                      .webinarImage!),
                                                              fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 8, 20, 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              trending
                                                                  .webinarBy!,
                                                              style:
                                                                  SafeGoogleFont(
                                                                "Inter",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      trending
                                                                          .webinarDate!,
                                                                      style:
                                                                          SafeGoogleFont(
                                                                        "Inter",
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Text(
                                                                      trending
                                                                          .webinarTitle!,
                                                                      style:
                                                                          SafeGoogleFont(
                                                                        "Inter",
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 12,
                                                            ),
                                                            Container(
                                                              height: 1,
                                                              width: double
                                                                  .infinity,
                                                              color: const Color(
                                                                  0xffAFAFAF),
                                                            ),
                                                            const SizedBox(
                                                              height: 14,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Share.share(
                                                                          'https://play.google.com/store/apps/details?id=com.sortmycollege');
                                                                    },
                                                                    child:
                                                                        Center(
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/page-1/images/group-38-oFX.png",
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            20,
                                                                        color: const Color(
                                                                            0xFF1F0A68),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  registerNowWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      if (!trending
                                                                          .registered!) {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
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
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Text('Cancel'),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () async {
                                                                                    if (trending.registered! && trending.webinarStartingInDays == 0) {
                                                                                      launchUrlString(trending.webinarJoinUrl!);
                                                                                    } else if (trending.registered!) {
                                                                                      Fluttertoast.showToast(msg: 'Participant is already registered');
                                                                                    } else {
                                                                                      var value = await ApiService.webinar_regiter(trending.id!);

                                                                                      if (value["error"] == "Participant is already registered") {
                                                                                        Fluttertoast.showToast(msg: 'Participant is already registered');
                                                                                      } else if (value["message"] == "Registration completed") {
                                                                                        Fluttertoast.showToast(msg: 'Registration completed Thanks for registration');
                                                                                        Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                            builder: (context) => const HomePage(),
                                                                                          ),
                                                                                        );
                                                                                      }
                                                                                    }
                                                                                    if (mounted) {
                                                                                      Navigator.pop(context);
                                                                                    }
                                                                                    //await _updateRegistrationStatus(true);
                                                                                  },
                                                                                  child: const Text('Yes'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      } else {
                                                                        const Text(
                                                                            'Has Been Registered');
                                                                      }
                                                                    },
                                                                    regdate:
                                                                        trending
                                                                            .registeredDate,
                                                                    title: trending
                                                                            .registered!
                                                                        ? (trending.webinarStartingInDays ==
                                                                                0
                                                                            ? 'Join Now'
                                                                            : 'Starting in ${trending.webinarStartingInDays} days')
                                                                        : 'Join Now',
                                                                    isRegisterNow:
                                                                        trending
                                                                            .registered!,
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
                                              ),
                                            ],
                                          );
                                        }),
                              ),
                            ],
                          )
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

  Widget profileCard(
      LatestSessionsModel latestSessionsModel, int cardIndex, int totalCards) {
    var width = MediaQuery.of(context).size.width;
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    str = counsellorSessionProvider.popularWorkShopList[0].sessionDate
        ?.split('T');
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
        width: width / 1.05,
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(
                          latestSessionsModel.counsellorProfilePic!),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              latestSessionsModel.counsellorName ?? "N/A",
                              // popularWorkShopModel.sessionUser ?? "N/A",
                              style: const TextStyle(
                                color: Color(0xFF1F0A68),
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              width: width / 3,
                            ),
                            GestureDetector(
                              onTap: () {
                                Share.share(
                                    'https://play.google.com/store/apps/details?id=com.sortmycollege');
                              },
                              child: Center(
                                child: Image.asset(
                                  "assets/page-1/images/group-38-oFX.png",
                                  color: const Color(0xFF1F0A68),
                                  height: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        SizedBox(
                          width: 190.25,
                          child: Text(
                            latestSessionsModel.counsellorDesignation!,
                            // popularWorkShopModel.sessionType!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Image.asset(
                              "assets/page-1/images/clock-circular-outline-Ra1.png",
                              // color: Colors.black,
                              height: 12,
                              width: 12,
                            ),
                            const SizedBox(width: 4),
                            SizedBox(
                              width: 121.13,
                              child: Text(
                                latestSessionsModel.sessionTime != null
                                    ? '${(latestSessionsModel.sessionTime! ~/ 60) % 12}:${(latestSessionsModel.sessionTime! % 60).toString().padLeft(2, '0')} ${(latestSessionsModel.sessionTime! ~/ 60) < 12 ? 'AM' : 'PM'}'
                                    : 'N/A',
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
                        const SizedBox(height: 4),
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
                            const SizedBox(width: 6),
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
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/page-1/images/rate.png"),
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
                                ' ${latestSessionsModel.sessionFee}/-',
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
                const SizedBox(height: 12),
                Container(
                  height: 0.47,
                  width: width * 0.85,
                  color: const Color(0xffAFAFAF).withOpacity(.78),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.014,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          log("Session Id=>>>> ${latestSessionsModel.sessionId!}");
                          return CounsellorDetailsScreen(
                            id: latestSessionsModel.counsellorId!,
                          );
                        }));
                      },
                      child: Container(
                        width: 120.14,
                        height: 33,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              color:
                                  Colors.black.withOpacity(0.7400000095367432),
                            ),
                            borderRadius: BorderRadius.circular(10),
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
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CheckOutScreen(
                                designation:
                                    latestSessionsModel.counsellorDesignation!,
                                name: latestSessionsModel.counsellorName!,
                                profilepicurl:
                                    latestSessionsModel.counsellorProfilePic!,
                                id: latestSessionsModel.counsellorId!);
                            // log("message${latestSessionsModel.counsellorId!}");
                            // return CounsellingSessionPage(
                            //   name: latestSessionsModel.counsellorName!,
                            //   id: latestSessionsModel.counsellorId!,
                            //   designation:
                            //       latestSessionsModel.counsellorDesignation!,
                            //   profileurl:
                            //       latestSessionsModel.counsellorProfilePic!,
                            //   selectedIndex_get: 0,
                            // );
                          }),
                        );
                      },
                      child: Container(
                        width: 120,
                        height: 33,
                        decoration: ShapeDecoration(
                          color: const Color(0xff1F0A68),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }

  void onTapgotocounsellor(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomePageContainer_2()));
  }

  initPrefrence(Map<String, dynamic> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value["message"] == "successfully get data") {
      path = prefs.getString("profile_image_path") ?? " ";
      username = prefs.getString("name") ?? "";
    } else {
      username = "user";
    }
  }
}
