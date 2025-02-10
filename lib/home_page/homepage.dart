import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myapp/home_page/counsellor_page/counsellor_details_screen.dart';
import 'package:myapp/home_page/drawer/drawer_1.dart';
import 'package:myapp/home_page/homepagecontainer_2.dart';
import 'package:myapp/home_page/model/popular_workshop_model.dart';
import 'package:myapp/home_page/model/tranding_webinar_model.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/utils/share_links.dart';
import 'package:myapp/webinar_page/widget/webinar_detail_page_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../app_update.dart';
import '../booking_page/checkout_screen.dart';
import '../other/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  String name = "";
  String username = "";
  String path = '';
  late var value;
  bool isFetched = false;
  bool has24HoursPassed = false;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CounsellorDetailsProvider counsellorDetailsProvider =
      CounsellorDetailsProvider();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {});
    getAllInfo();

    counsellorDetailsProvider =
        Provider.of<CounsellorDetailsProvider>(context, listen: false);
    context.read<CounsellorDetailsProvider>().fetchBannerImage();
    context.read<CounsellorDetailsProvider>().fetchTrendingWebinar();
    context.read<CounsellorDetailsProvider>().fetchPopularWorkShop();
    if (Platform.isAndroid) {
      checkForAndroidUpdate();
    }
    imgUrlList.clear();
  }

  void getAllInfo() async {
    await ApiService.get_profile().then(
      (value) => initPrefrence(value),
    );
  }

  Future<void> refreshData() async {
    setState(() {
      isFetched = false; // Reset fetched status if needed
    });

    context.read<CounsellorDetailsProvider>().fetchBannerImage();
    context.read<CounsellorDetailsProvider>().fetchTrendingWebinar();
    context.read<CounsellorDetailsProvider>().fetchPopularWorkShop();

    setState(() {
      isFetched = true; // Mark as fetched again
    });
  }

  void saveImagePathToPrefs(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("profile_image_path", path);
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
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
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
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Hello, $username',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 30)
            ],
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20, top: 18, bottom: 18),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(
                'assets/page-1/images/group-59.png',
                color: Colors.black,
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
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 28),
          ],
        ),
        body: RefreshIndicator(
          backgroundColor: Colors.white,
          color: Colors.black,
          onRefresh: () async {
            await refreshData();
          },
          child: counsellorSessionProvider.isNull
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  onTapgotocounsellor(context);
                                },
                                child: SizedBox(
                                  height: 110 * fem,
                                  width: 175 * fem,
                                  child: Image.asset(
                                    "assets/page-1/images/find_counsellor.png",
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  onTapgotoAccommodation(context);
                                },
                                child: SizedBox(
                                  height: 110 * fem,
                                  width: 175 * fem,
                                  child: Image.asset(
                                      "assets/page-1/images/Group 795.png"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  onTapgotoEP(context);
                                },
                                child: SizedBox(
                                  height: 110 * fem,
                                  width: 175 * fem,
                                  child: Image.asset(
                                      "assets/page-1/images/Group 793.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15.0),

                      // Padding(
                      //   padding: const EdgeInsets.all(18.0),
                      //   child: SizedBox(
                      //     width: double.infinity,
                      //     height: 110 * fem,
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               onTapgotocounsellor(context);
                      //             },
                      //             child: Container(
                      //               width: 110 * fem,
                      //               height: 120 * fem,
                      //               clipBehavior: Clip.antiAlias,
                      //               decoration: BoxDecoration(
                      //                 color: const Color(0xffffffff),
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     offset: const Offset(0, 4),
                      //                     blurRadius: 4,
                      //                     color: Colors.black.withOpacity(0.1),
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Image.asset(
                      //                 "assets/page-1/images/find_counsellor.png",
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         const SizedBox(width: 34),
                      //         Expanded(
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               // Navigator.push(
                      //               //   context,
                      //               //   MaterialPageRoute(
                      //               //     builder: (context) =>
                      //               //         const CommingSoonPage(),
                      //               //   ),
                      //               // );
                      //               Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       const EpWithHomePage(),
                      //                 ),
                      //               );
                      //             },
                      //             child: Visibility(
                      //               //visible: true,
                      //               child: Container(
                      //                 width: 110 * fem,
                      //                 height: 120 * fem,
                      //                 clipBehavior: Clip.antiAlias,
                      //                 decoration: BoxDecoration(
                      //                   color: const Color(0xffffffff),
                      //                   borderRadius: BorderRadius.circular(20),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       offset: const Offset(0, 4),
                      //                       blurRadius: 4,
                      //                       color: Colors.black.withOpacity(0.1),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 child: Image.asset(
                      //                   "assets/page-1/images/Group 793.png",
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Visibility(
                      //   // visible: false,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(18.0),
                      //     child: SizedBox(
                      //       width: double.infinity,
                      //       height: 112 * fem,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Expanded(
                      //             child: GestureDetector(
                      //               onTap: () {
                      //                 Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                         builder: (context) =>
                      //                             const ComingSoon()));
                      //               },
                      //               child: Container(
                      //                 width: 110 * fem,
                      //                 height: 120 * fem,
                      //                 clipBehavior: Clip.antiAlias,
                      //                 decoration: BoxDecoration(
                      //                   color: const Color(0xff6450A8),
                      //                   borderRadius: BorderRadius.circular(20),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       offset: const Offset(0, 4),
                      //                       blurRadius: 4,
                      //                       color: Colors.black.withOpacity(0.1),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 child: Image.asset(
                      //                   "assets/page-1/images/Group 794.png",
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           const SizedBox(
                      //             width: 34,
                      //           ),
                      //           Expanded(
                      //             child: Row(
                      //               crossAxisAlignment: CrossAxisAlignment.center,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Expanded(
                      //                   child: GestureDetector(
                      //                     onTap: () {
                      //                       Navigator.push(
                      //                           context,
                      //                           MaterialPageRoute(
                      //                               builder: (context) =>
                      //                                   const AccommodationWithHomePage()));
                      //                     },
                      //                     child: Container(
                      //                       width: 140 * fem,
                      //                       height: 140 * fem,
                      //                       clipBehavior: Clip.antiAlias,
                      //                       decoration: BoxDecoration(
                      //                         color: const Color(0xff5273B4),
                      //                         borderRadius:
                      //                             BorderRadius.circular(20),
                      //                         boxShadow: [
                      //                           BoxShadow(
                      //                             offset: const Offset(0, 4),
                      //                             blurRadius: 4,
                      //                             color: Colors.black
                      //                                 .withOpacity(0.1),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                       child: Image.asset(
                      //                         "assets/page-1/images/Group 795.png",
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),),

                      // const SizedBox(height: 10),
                      Align(
                        child: GestureDetector(
                          onTap: () async {
                            log("ImageURL LIst$imgUrlList");
                            final Uri redirectLink = Uri.parse(
                              "https://forms.gle/bMtmPCBpYK6Do1269",
                            );
                            if (await canLaunchUrl(redirectLink)) {
                              await launchUrl(
                                redirectLink,
                              );
                            } else {
                              throw 'Could not launch $redirectLink';
                            }
                          },
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16)),
                                            image: DecorationImage(
                                                image: NetworkImage(e)),
                                          ),
                                        ))
                                    .toList()),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

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
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.28,
                                  ),
                                  child: counsellorSessionProvider
                                          .popularWorkShopList.isEmpty
                                      ? const Center(
                                          child: Text("No Data Found"),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics: const PageScrollPhysics(),
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
                                          },
                                        ),
                                ),
                              ],
                            ),
                      const SizedBox(height: 10),
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
                                          color: Colors.black,
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
                                    child:
                                        counsellorSessionProvider
                                                .trendingWebinarList.isEmpty
                                            ? const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 100),
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    counsellorSessionProvider
                                                        .trendingWebinarList
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  TrandingWebinarModel
                                                      trending =
                                                      counsellorSessionProvider
                                                          .trendingWebinarList
                                                          .reversed
                                                          .toList()[index];

                                                  DateTime webinarDate =
                                                      DateTime.parse(trending
                                                          .registeredDate!);

                                                  // log("WEBINAR DATE$webinarDate");

                                                  DateTime currentDate =
                                                      DateTime.now();
                                                  if (webinarDate
                                                      .isBefore(currentDate)) {
                                                    return const SizedBox
                                                        .shrink();
                                                  }

                                                  currentDate
                                                      .difference(webinarDate);
                                                  bool isRegistered =
                                                      trending.registered!;

                                                  return Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          bool?
                                                              registrationStatus =
                                                              await Navigator
                                                                  .push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                              return WebinarDetailsPageWidget(
                                                                webinarId:
                                                                    trending.id,
                                                              );
                                                            }),
                                                          );
                                                          if (registrationStatus ==
                                                              true) {
                                                            // Refresh the data by calling fetch methods again
                                                            context
                                                                .read<
                                                                    CounsellorDetailsProvider>()
                                                                .fetchTrendingWebinar();
                                                            // context
                                                            //     .read<
                                                            //         CounsellorDetailsProvider>()
                                                            //     .fetchPopularWorkShop();
                                                          }
                                                        },
                                                        child: Card(
                                                          shadowColor:
                                                              ColorsConst
                                                                  .whiteColor,
                                                          color: Colors.white,
                                                          surfaceTintColor:
                                                              Colors.white,
                                                          elevation: 2,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 190,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  image:
                                                                      DecorationImage(
                                                                    image: NetworkImage(
                                                                        trending
                                                                            .webinarImage!),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        8,
                                                                        20,
                                                                        10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      trending
                                                                          .webinarTitle!,
                                                                      style: SafeGoogleFont(
                                                                          "Inter",
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            4),
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
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              trending.webinarDate!.replaceAll(RegExp(r'\s*@\s*'), " "),
                                                                              style: SafeGoogleFont("Inter", fontSize: 12, fontWeight: FontWeight.w500),
                                                                            ),
                                                                            const SizedBox(height: 3),
                                                                            Text(
                                                                              trending.webinarBy!,
                                                                              style: SafeGoogleFont("Inter", fontSize: 11, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            12),
                                                                    Container(
                                                                      height: 1,
                                                                      width: double
                                                                          .infinity,
                                                                      color: const Color(
                                                                          0xffAFAFAF),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            14),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              webinarShareLinks(id: trending.id.toString());
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.share,
                                                                              size: 26,
                                                                              color: Color(0xff1F0A68),
                                                                            )),
                                                                        RegisterNowWidget(
                                                                          onPressed:
                                                                              () async {
                                                                            var daysDifference =
                                                                                calculateDaysDifference(
                                                                              registeredDate: trending.registeredDate!,
                                                                              webinarRegister: trending.registered!,
                                                                              canJoin: trending.canJoin!,
                                                                            );

                                                                            if (!trending
                                                                                .registered!) {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    backgroundColor: Colors.white,
                                                                                    title: const Text("Register"),
                                                                                    content: const Text("Are you sure you want to register for this webinar?"),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        child: const Text("Cancel"),
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                      TextButton(
                                                                                        child: const Text("Yes"),
                                                                                        onPressed: () async {
                                                                                          await ApiService.webinarRegister(trending.id!);
                                                                                          setState(() {
                                                                                            trending.registered = true;
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            } else if (daysDifference == 0 &&
                                                                                isRegistered &&
                                                                                trending.canJoin == true) {
                                                                              await ApiService.webinarJoin(trending.id!);
                                                                              launchUrlString(trending.webinarJoinUrl!);
                                                                            }
                                                                          },
                                                                          regdate:
                                                                              trending.registeredDate,
                                                                          isRegisterNow:
                                                                              trending.registered!,
                                                                          canJoin:
                                                                              trending.canJoin!,
                                                                        )
                                                                      ],
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
                                                },
                                              )),
                              ],
                            )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // CustomWebinarCard buildCustomWebinarCard(
  //   TrandingWebinarModel trending,
  // ) {
  //   return CustomWebinarCard(
  //     trandingWebinarModel: trending,
  //   );
  // }

  Widget profileCard(
      LatestSessionsModel latestSessionsModel, int cardIndex, int totalCards) {
    var width = MediaQuery.of(context).size.width;
    // Parsing session date
    DateTime sessionDate =
        DateTime.parse(latestSessionsModel.sessionStartingDate!);

    // Parsing session time (assuming it's in minutes from midnight)
    int sessionMinutes = latestSessionsModel.sessionTime ?? 0;
    int sessionHour = sessionMinutes ~/ 60;
    int sessionMinute = sessionMinutes % 60;

    // Creating a DateTime object for session start time
    DateTime sessionDateTime = DateTime(
      sessionDate.year,
      sessionDate.month,
      sessionDate.day,
      sessionHour,
      sessionMinute,
    );

    // Getting the current time
    DateTime currentTime = DateTime.now();

    // Disable the button if the session is within 30 minutes from now
    bool isButtonDisabled =
        sessionDateTime.difference(currentTime).inMinutes <= 30 &&
            sessionDateTime.difference(currentTime).inMinutes >= 0;

    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SizedBox(
        width: width / 1.05,
        child: Column(
          children: [
            Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 8),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 38,
                              backgroundImage: NetworkImage(
                                  latestSessionsModel.counsellorProfilePic!),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  latestSessionsModel.counsellorName ?? "N/A",
                                  style: const TextStyle(
                                    color: Color(0xFF1F0A68),
                                    fontSize: 14.5,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                SizedBox(
                                  width: 190.25,
                                  child: Text(
                                    latestSessionsModel.sessionTopic!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
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
                                      height: 12,
                                      width: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    SizedBox(
                                      width: 121.13,
                                      child: Text(
                                        latestSessionsModel.sessionTime != null
                                            ? '${(latestSessionsModel.sessionTime! ~/ 60) % 12 == 0 ? 12 : (latestSessionsModel.sessionTime! ~/ 60) % 12}:${(latestSessionsModel.sessionTime! % 60).toString().padLeft(2, '0')} ${(latestSessionsModel.sessionTime! ~/ 60) < 12 ? 'AM' : 'PM'}'
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
                                        "${latestSessionsModel.sessionDate}",
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CounsellorDetailsScreen(
                                        id: latestSessionsModel.counsellorId!,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                width: 120.14,
                                height: 33,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.50,
                                      color: Colors.black
                                          .withOpacity(0.7400000095367432),
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
                              onTap: isButtonDisabled
                                  ? () {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Booking Closed: Kindly book at least 30 minutes in advance.');
                                    }
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CheckOutScreen(
                                              designation: latestSessionsModel
                                                  .counsellorDesignation!,
                                              name: latestSessionsModel
                                                  .counsellorName!,
                                              profilepicurl: latestSessionsModel
                                                  .counsellorProfilePic!,
                                              id: latestSessionsModel
                                                  .counsellorId!,
                                              sessionId: latestSessionsModel
                                                  .sessionId!,
                                              sessionTime: latestSessionsModel
                                                  .sessionTime,
                                              sessionTopic: latestSessionsModel
                                                  .sessionTopic,
                                              sessionDuration:
                                                  latestSessionsModel
                                                      .sessionDuration,
                                            );
                                          },
                                        ),
                                      );
                                    },
                              child: Container(
                                width: 120,
                                height: 33,
                                decoration: ShapeDecoration(
                                  color: isButtonDisabled
                                      ? Colors.grey
                                      : const Color(0xff1F0A68),
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
                      ],
                    ),
                    Positioned(
                      top: -10,
                      right: -8,
                      child: IconButton(
                        onPressed: () {
                          counsellorShareLinks(
                              id: latestSessionsModel.counsellorId!);
                        },
                        icon: const Icon(
                          Icons.share,
                          size: 26,
                          color: Color(0xff1F0A68),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalCards,
                (index) {
                  return Icon(
                    index == cardIndex ? Icons.circle : Icons.circle_outlined,
                    color: const Color(0xff1F0A68),
                    size: 8,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapgotocounsellor(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CounsellorWithHomePage()));
  }

  void onTapgotoEP(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EpWithHomePage()));
  }

  void onTapgotoAccommodation(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AccommodationWithHomePage()));
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

class RegisterNowWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String? regdate;
  final bool isRegisterNow;
  final bool canJoin;

  const RegisterNowWidget({
    super.key,
    required this.onPressed,
    required this.regdate,
    required this.isRegisterNow,
    required this.canJoin,
  });

  DateTime parseDate(String dateString) {
    // Parse the date string assuming it's in the format "yyyy-MM-dd".
    return DateTime.parse(dateString.split('T')[0]);
  }

  DateTime truncateTime(DateTime dateTime) {
    // Truncate the time component of the DateTime object.
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  String getButtonText() {
    if (!isRegisterNow) {
      return "Register Now";
    }

    DateTime today = truncateTime(DateTime.now());
    DateTime webinarDate = truncateTime(parseDate(regdate!));
    int daysDifference = webinarDate.difference(today).inDays;

    if (daysDifference < 0) {
      String dayText = (daysDifference == -1) ? "day" : "days";
      return "Happened ${-daysDifference} $dayText ago";
    } else if (daysDifference == 0 && canJoin == true) {
      return "Join Now";
    } else if (daysDifference == 0) {
      return "Starting today";
    } else {
      String dayText = (daysDifference == 1) ? "day" : "days";
      return "Starting in $daysDifference $dayText";
    }
  }

  Color getButtonColor() {
    if (!isRegisterNow) {
      return const Color(0XFF1F0A68);
    }

    DateTime today = truncateTime(DateTime.now());
    DateTime webinarDate = truncateTime(parseDate(regdate!));
    int daysDifference = webinarDate.difference(today).inDays;

    if (daysDifference < 0) {
      return Colors.white;
    } else if (daysDifference == 0 && canJoin == true) {
      return const Color(0XFF1F0A68);
    } else {
      return Colors.white;
    }
  }

  Color getTextColor() {
    if (!isRegisterNow) {
      return Colors.white;
    }

    DateTime today = truncateTime(DateTime.now());
    DateTime webinarDate = truncateTime(parseDate(regdate!));
    int daysDifference = webinarDate.difference(today).inDays;

    if (daysDifference < 0) {
      return Colors.black;
    } else if (daysDifference == 0 && canJoin == true) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 232,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: getTextColor(),
          backgroundColor: getButtonColor(),
        ),
        child: Text(
          getButtonText(),
        ),
      ),
    );
  }
}

int calculateDaysDifference(
    {required String registeredDate,
    required bool webinarRegister,
    required bool canJoin}) {
  DateTime parseDate(String dateString) {
    return DateTime.parse(dateString.split('T')[0]);
  }

  DateTime truncateTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  DateTime today = truncateTime(DateTime.now());
  DateTime webinarDate = truncateTime(parseDate(registeredDate));
  int daysDifference = webinarDate.difference(today).inDays;

  // if (daysDifference == 0 && webinarRegister && !canJoin) {
  //   Fluttertoast.showToast(msg: 'The webinar will start 10 minutes early.');
  // } else if (daysDifference > 0 && !canJoin && webinarRegister) {
  //   Fluttertoast.showToast(msg: 'Webinar Starting in $daysDifference days');
  // } else if (daysDifference < 0) {
  //   Fluttertoast.showToast(msg: 'Webinar happened ${-daysDifference} days ago');
  // }

  if (daysDifference == 0 && webinarRegister && !canJoin) {
    Fluttertoast.showToast(msg: 'The webinar will start 10 minutes early.');
  } else if (daysDifference > 0 && !canJoin && webinarRegister) {
    String dayText = (daysDifference == 1) ? 'day' : 'days';
    Fluttertoast.showToast(msg: 'Webinar Starting in $daysDifference $dayText');
  } else if (daysDifference < 0) {
    String dayText = (daysDifference == -1) ? 'day' : 'days';
    Fluttertoast.showToast(
        msg: 'Webinar happened ${-daysDifference} $dayText ago');
  }

  return daysDifference;
}
