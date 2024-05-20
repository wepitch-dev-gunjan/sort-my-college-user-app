// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:myapp/model/cousnellor_list_model.dart';
// import 'package:myapp/other/listcontroler.dart';
// import 'package:myapp/other/provider/counsellor_details_provider.dart';
// import 'package:myapp/other/provider/user_booking_provider.dart';
// import 'package:myapp/page-1/payment_gateaway.dart';
// import 'package:myapp/utils.dart';
// import 'package:provider/provider.dart';
// import 'package:readmore/readmore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'counsellor_feed_page.dart';
//
// class CounsellorDetialsPage extends StatefulWidget {
//   final String id;
//   final String name;
//
//   const CounsellorDetialsPage(
//       {super.key, required this.id, required this.name});
//
//   @override
//   State<CounsellorDetialsPage> createState() => _CounsellorDetialsPageState();
// }
//
// class _CounsellorDetialsPageState extends State<CounsellorDetialsPage>
//     with SingleTickerProviderStateMixin {
//   final ListController listController = Get.put(ListController());
//   bool visible = false;
//   late TabController _controller;
//   List<CounsellorModel> counsellorModel = [];
//   bool isFollowing = false;
//   int followerCount = 0;
//   bool hasFollowedBefore = false;
//
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<CounsellorDetailsProvider>().fetchCounsellor_detail(widget.id);
//     context.read<CounsellorDetailsProvider>().fetchCounsellor_details(widget.id);
//     _controller = TabController(length: 2, vsync: this, initialIndex: 0);
//     _loadData();
//   }
//
//   _loadData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       followerCount = prefs.getInt('followerCount') ?? 0;
//       hasFollowedBefore = prefs.getBool('hasFollowedBefore') ?? false;
//       isFollowing = prefs.getBool('isFollowing') ?? false;
//     });
//   }
//
//   _saveData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setInt('followerCount', followerCount);
//     prefs.setBool('hasFollowedBefore', hasFollowedBefore);
//     prefs.setBool('isFollowing', isFollowing);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var userBookings = context.watch<UserBookingProvider>().userBooking;
//     var counsellorDetailController = context.watch<CounsellorDetailsProvider>();
//     double baseWidth = 430;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title:  Center(
//           child: Text(
//             // anshikamehra7w6 (2608:501)
//             counsellorDetailController
//                 .cousnellorlist_detail[0]
//                 .name,
//             style: SafeGoogleFont(
//               'Inter',
//               fontSize: 24 * ffem,
//               fontWeight: FontWeight.w600,
//               height: 1.2125 * ffem / fem,
//               color: const Color(0xffffffff),
//             ),
//           ),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 10),
//             child: Icon(Icons.more_vert,color: Colors.white),
//           ),
//         ],
//         leading: IconButton(onPressed: (){
//           Navigator.pop(context);
//         }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white)),
//         backgroundColor: const Color(0xff1f0a68),
//       ),
//       body: counsellorDetailController.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : counsellorDetailController.cousnellorlist_detail[0].name == "none"
//           ? Builder(builder: (context) {
//         if (counsellorDetailController
//             .cousnellorlist_detail[0].name ==
//             "none") {
//           EasyLoading.showToast(
//             "404 Page Not Found",
//             toastPosition: EasyLoadingToastPosition.bottom,
//           );
//         }
//         return const Center(
//           child: Text("Something went wrong!"),
//         );
//       })
//           : Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           // color: Colors.red,
//           color: Color(0xffffffff),
//           image: DecorationImage(
//             fit: BoxFit.cover,
//             image: AssetImage(
//               'assets/page-1/images/counselor-detailed-select-full-view.png',
//             ),
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//                  child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     counsellorDetailController.cousnellorlist_detail.isEmpty
//                         ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                         : Column(
//                       children: [
//                         SizedBox(
//                           // frame325A8g (2958:415)
//                           width: 431 * fem,
//                           height: 420 * fem,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 // frame253D6x (2958:417)
//                                 left: 16.25 * fem,
//                                 top: 230 * fem,
//                                 child: SizedBox(
//                                   width: 390 * fem,
//                                   height: 75.83 * fem,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         // group284Kfn (2958:418)
//                                         margin: EdgeInsets.fromLTRB(
//                                             0 * fem,
//                                             0 * fem,
//                                             60 * fem,
//                                             0 * fem),
//                                         height: double.infinity,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment
//                                               .start,
//                                           children: [
//                                             Container(
//                                               // productdesignerwepitchFpL (2958:419)
//                                               margin:
//                                               EdgeInsets.fromLTRB(
//                                                   0.5 * fem,
//                                                   0 * fem,
//                                                   0 * fem,
//                                                   3.83 * fem),
//                                               child: Text(
//                                                 widget.name,
//                                                 style: SafeGoogleFont(
//                                                   'Inter',
//                                                   fontSize: 14 * ffem,
//                                                   fontWeight:
//                                                   FontWeight.w600,
//                                                   height: 1.2125 *
//                                                       ffem /
//                                                       fem,
//                                                   color: const Color(
//                                                       0xff1f0a68),
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               // group32mGt (2958:420)
//                                               width: 136.91 * fem,
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment
//                                                     .start,
//                                                 children: [
//                                                   Container(
//                                                     // group282uP6 (2958:425)
//                                                     margin: EdgeInsets
//                                                         .fromLTRB(
//                                                         0 * fem,
//                                                         0 * fem,
//                                                         55.91 *
//                                                             fem,
//                                                         4.58 *
//                                                             fem),
//                                                     width: double
//                                                         .infinity,
//                                                     child: Row(
//                                                       crossAxisAlignment:
//                                                       CrossAxisAlignment
//                                                           .center,
//                                                       children: [
//                                                         Container(
//                                                           // groupeLg (2958:427)
//                                                           margin: EdgeInsets.fromLTRB(
//                                                               0 * fem,
//                                                               0 * fem,
//                                                               6 * fem,
//                                                               0.07 *
//                                                                   fem),
//                                                           width: 15 *
//                                                               fem,
//                                                           height:
//                                                           15.35 *
//                                                               fem,
//                                                           child: Image
//                                                               .asset(
//                                                             'assets/page-1/images/group-MqT.png',
//                                                             width: 15 *
//                                                                 fem,
//                                                             height:
//                                                             15.35 *
//                                                                 fem,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           // mAQ (2958:426)
//                                                           margin: EdgeInsets.fromLTRB(
//                                                               0 * fem,
//                                                               0.42 *
//                                                                   fem,
//                                                               0 * fem,
//                                                               0 * fem),
//                                                           child: Text(
//                                                             '${counsellorDetailController.cousnellorlist_detail[0].averageRating}',
//                                                             style:
//                                                             SafeGoogleFont(
//                                                               'Inter',
//                                                               fontSize:
//                                                               12 *
//                                                                   ffem,
//                                                               fontWeight:
//                                                               FontWeight.w500,
//                                                               height: 1.2125 *
//                                                                   ffem /
//                                                                   fem,
//                                                               color: const Color(
//                                                                   0xff414040),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//
//                                                   SizedBox(
//                                                     // group283sjE (2958:421)
//                                                     width: double
//                                                         .infinity,
//                                                     child: Row(
//                                                       crossAxisAlignment:
//                                                       CrossAxisAlignment
//                                                           .center,
//                                                       children: [
//                                                         Container(
//                                                           // group2s2 (2958:423)
//                                                           margin: EdgeInsets.fromLTRB(
//                                                               0 * fem,
//                                                               0 * fem,
//                                                               3.91 *
//                                                                   fem,
//                                                               0.61 *
//                                                                   fem),
//                                                           width: 15 *
//                                                               fem,
//                                                           height:
//                                                           15.27 *
//                                                               fem,
//                                                           child: Image
//                                                               .asset(
//                                                             'assets/page-1/images/group-ZqT.png',
//                                                             width: 15 *
//                                                                 fem,
//                                                             height:
//                                                             15.27 *
//                                                                 fem,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           // today14sessionsYqN (2958:422)
//                                                           'Today 14 Sessions',
//                                                           style:
//                                                           SafeGoogleFont(
//                                                             'Inter',
//                                                             fontSize:
//                                                             13 *
//                                                                 ffem,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w500,
//                                                             height: 1.2125 *
//                                                                 ffem /
//                                                                 fem,
//                                                             color: const Color(
//                                                                 0xff414040),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         // followHHA (2958:432)
//                                         width: 190.5 * fem,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment
//                                               .center,
//                                           children: [
//                                             hasFollowedBefore
//                                             ? Container()
//                                               : Container(
//                                       margin: EdgeInsets.fromLTRB(60 * fem, 0 * fem, 0 * fem, 4 * fem),
//                             width: double.infinity,
//                             height: 48.3 * fem,
//                             child: Stack(
//                               children: [
//                                 Positioned(
//                                   left: 0 * fem,
//                                   top: 0.1748046875 * fem,
//                                   child: Container(
//                                     width: 124.02 * fem,
//                                     height: 35.13 * fem,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: const Color(0x70000000)),
//                                       borderRadius: BorderRadius.circular(5 * fem),
//                                     ),
//                                     child: TextButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           isFollowing = !isFollowing;
//                                           if (isFollowing) {
//                                             followerCount++;
//                                           } else {
//                                             followerCount--;
//                                           }
//                                           _saveData();
//                                         });
//                                       },
//                                       style: TextButton.styleFrom(
//                                         padding: EdgeInsets.zero,
//                                         backgroundColor: isFollowing ? Colors.white : const Color(0xff1f0a68),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(5 * fem),
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           isFollowing ? 'Following' : 'Follow',
//                                           style: SafeGoogleFont(
//                                             'Inter',
//                                             fontSize: 14 * ffem,
//                                             fontWeight: FontWeight.w500,
//                                             height: 1.2125 * ffem / fem,
//                                             color: isFollowing ? Colors.black : const Color(0xffffffff),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                                             Container(
//                                               // autogrouptdtw6dv (obbCWhEmJ7cxZxekJtdTW)
//                                               margin:
//                                               EdgeInsets.fromLTRB(
//                                                   60.48 * fem,
//                                                   0 * fem,
//                                                   9.02 * fem,
//                                                   0 * fem),
//                                               width: double.infinity,
//                                               child: Row(
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment
//                                                     .center,
//                                                 children: [
//                                                   Container(
//                                                     // groupqLc (2958:435)
//                                                     margin: EdgeInsets
//                                                         .fromLTRB(
//                                                         0 * fem,
//                                                         0 * fem,
//                                                         6.1 * fem,
//                                                         0.34 *
//                                                             fem),
//                                                     width: 18.9 * fem,
//                                                     height:
//                                                     12.96 * fem,
//                                                     child:
//                                                     Image.asset(
//                                                       'assets/page-1/images/group-NC9.png',
//                                                       width:
//                                                       18.9 * fem,
//                                                       height:
//                                                       13.96 * fem,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     // followingweY (2958:442)
//                                                     '${counsellorDetailController.cousnellorlist_detail[0].followersCount} '
//                                                         "Following",
//                                                     style:
//                                                     SafeGoogleFont(
//                                                       'Inter',
//                                                       fontSize:
//                                                       12 * ffem,
//                                                       fontWeight:
//                                                       FontWeight
//                                                           .w500,
//                                                       height: 1.2125 *
//                                                           ffem /
//                                                           fem,
//                                                       color: const Color(
//                                                           0xff5c5b5b),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 // group228so6 (2958:443)
//                                 left: 43.1260986328 * fem,
//                                 top: 320.8251953125 * fem,
//                                 child: SizedBox(
//                                   width: 342.25 * fem,
//                                   height: 41.07 * fem,
//                                   child: Stack(
//                                     children: [
//
//                                       Positioned(
//                                         // frame2203Di (2958:448)
//                                         left: 0 * fem,
//                                         top: 1.9533691406 * fem,
//                                         child: SizedBox(
//                                           width: 350.25 * fem,
//                                           height: 32.95 * fem,
//                                           child: Row(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .center,
//                                             children: [
//                                               Container(
//                                                 // group223m9i (2958:450)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     43.08 * fem,
//                                                     0 * fem),
//                                                 height:
//                                                 double.infinity,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Center(
//                                                       // experienceVrQ (2958:452)
//                                                       child:
//                                                       Container(
//                                                         margin: EdgeInsets
//                                                             .fromLTRB(
//                                                             0 *
//                                                                 fem,
//                                                             0 *
//                                                                 fem,
//                                                             0 *
//                                                                 fem,
//                                                             2.95 *
//                                                                 fem),
//                                                         child: Text(
//                                                           'Experience',
//                                                           textAlign:
//                                                           TextAlign
//                                                               .center,
//                                                           style:
//                                                           SafeGoogleFont(
//                                                             'Inter',
//                                                             fontSize:
//                                                             11 *
//                                                                 ffem,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w500,
//                                                             height: 1.2125 *
//                                                                 ffem /
//                                                                 fem,
//                                                             color: const Color(
//                                                                 0xff8d8888),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       // yrs144 (2958:453)
//                                                       margin: EdgeInsets
//                                                           .fromLTRB(
//                                                           0 * fem,
//                                                           0 * fem,
//                                                           2.72 *
//                                                               fem,
//                                                           0 * fem),
//                                                       child: Text(
//                                                         '${counsellorDetailController.cousnellorlist_detail[0].experienceInYears} + yrs',
//                                                         style:
//                                                         SafeGoogleFont(
//                                                           'Inter',
//                                                           fontSize:
//                                                           13 *
//                                                               ffem,
//                                                           fontWeight:
//                                                           FontWeight
//                                                               .w700,
//                                                           height:
//                                                           1.2125 *
//                                                               ffem /
//                                                               fem,
//                                                           color: const Color(
//                                                               0xff000000),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // group223iz4 (2958:455)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     51.08 * fem,
//                                                     0 * fem),
//                                                 height:
//                                                 double.infinity,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Center(
//                                                       // sessions53v (2958:457)
//                                                       child:
//                                                       Container(
//                                                         margin: EdgeInsets
//                                                             .fromLTRB(
//                                                             0 *
//                                                                 fem,
//                                                             0 *
//                                                                 fem,
//                                                             0 *
//                                                                 fem,
//                                                             2.95 *
//                                                                 fem),
//                                                         child: Text(
//                                                           'Sessions',
//                                                           textAlign:
//                                                           TextAlign
//                                                               .center,
//                                                           style:
//                                                           SafeGoogleFont(
//                                                             'Inter',
//                                                             fontSize:
//                                                             11 *
//                                                                 ffem,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w500,
//                                                             height: 1.2125 *
//                                                                 ffem /
//                                                                 fem,
//                                                             color: const Color(
//                                                                 0xff8d8888),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       // bY4 (2958:458)
//                                                       '${counsellorDetailController.cousnellorlist_detail[0].totalSessionsAttended}',
//                                                       textAlign:
//                                                       TextAlign
//                                                           .center,
//                                                       style:
//                                                       SafeGoogleFont(
//                                                         'Inter',
//                                                         fontSize:
//                                                         13 * ffem,
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .w700,
//                                                         height:
//                                                         1.2125 *
//                                                             ffem /
//                                                             fem,
//                                                         color: const Color(
//                                                             0xff000000),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // group223MGL (2958:460)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     48.08 * fem,
//                                                     0 * fem),
//                                                 height:
//                                                 double.infinity,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Center(
//                                                       // rewardsJBa (2958:462)
//                                                       child:
//                                                       Container(
//                                                         margin: EdgeInsets
//                                                             .fromLTRB(
//                                                             0 *
//                                                                 fem,
//                                                             0 *
//                                                                 fem,
//                                                             0 *
//                                                                 fem,
//                                                             2.95 *
//                                                                 fem),
//                                                         child: Text(
//                                                           'Rewards',
//                                                           textAlign:
//                                                           TextAlign
//                                                               .center,
//                                                           style:
//                                                           SafeGoogleFont(
//                                                             'Inter',
//                                                             fontSize:
//                                                             11 *
//                                                                 ffem,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w500,
//                                                             height: 1.2125 *
//                                                                 ffem /
//                                                                 fem,
//                                                             color: const Color(
//                                                                 0xff8d8888),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       // 15z (2958:463)
//                                                       '${listController.cousnellorlist_data[0].averageRating}',
//                                                       textAlign:
//                                                       TextAlign
//                                                           .center,
//                                                       style:
//                                                       SafeGoogleFont(
//                                                         'Inter',
//                                                         fontSize:
//                                                         13 * ffem,
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .w700,
//                                                         height:
//                                                         1.2125 *
//                                                             ffem /
//                                                             fem,
//                                                         color: const Color(
//                                                             0xff000000),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // group223Fm2 (2958:465)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     0 * fem,
//                                                     0.05 * fem,
//                                                     0 * fem,
//                                                     0 * fem),
//                                                 height:
//                                                 double.infinity,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Center(
//                                                       // reviews1EQ (2958:467)
//                                                       child:
//                                                       Container(
//                                                         margin: EdgeInsets
//                                                             .fromLTRB(
//                                                             0 *
//                                                                 fem,
//                                                             0 *
//                                                                 fem,
//                                                             0 *
//                                                                 fem,
//                                                             2.91 *
//                                                                 fem),
//                                                         child: Text(
//                                                           'Reviews',
//                                                           textAlign:
//                                                           TextAlign
//                                                               .center,
//                                                           style:
//                                                           SafeGoogleFont(
//                                                             'Inter',
//                                                             fontSize:
//                                                             11 *
//                                                                 ffem,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w500,
//                                                             height: 1.2125 *
//                                                                 ffem /
//                                                                 fem,
//                                                             color: const Color(
//                                                                 0xff8d8888),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       // kKVz (2958:468)
//                                                       '${listController.cousnellorlist_data[0].reviews}',
//                                                       textAlign:
//                                                       TextAlign
//                                                           .center,
//                                                       style:
//                                                       SafeGoogleFont(
//                                                         'Inter',
//                                                         fontSize:
//                                                         13 * ffem,
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .w700,
//                                                         height:
//                                                         1.2125 *
//                                                             ffem /
//                                                             fem,
//                                                         color: const Color(
//                                                             0xff000000),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 // group2944Ta (2958:469)
//                                 // left: 10 * fem,
//                                 top: 370.4067382812 * fem,
//                                 child: SizedBox(
//                                   width: 429.5 * fem,
//                                   height: 43 * fem,
//                                   child: Container(
//                                     color:
//                                     Colors.grey.withOpacity(0.2),
//                                     child: TabBar(
//                                         indicatorColor:
//                                         const Color(0xff1F0A68),
//                                         indicatorWeight: 3,
//                                         controller: _controller,
//                                         onTap: (value) {
//                                           if (value == 1) {
//                                             Navigator.pushReplacement(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         CounsellorFeedPage(
//                                                           name: counsellorDetailController
//                                                               .cousnellorlist_detail[
//                                                           0]
//                                                               .name,
//                                                           id: counsellorDetailController
//                                                               .cousnellorlist_detail[
//                                                           0]
//                                                               .id,
//                                                         )));
//                                           }
//                                         },
//                                         tabs: [
//                                           Tab(
//                                             child: Text(
//                                               "Info",
//                                               style: SafeGoogleFont(
//                                                   "Inter",
//                                                   fontSize: 16,
//                                                   fontWeight:
//                                                   FontWeight
//                                                       .w500),
//                                             ),
//                                           ),
//                                           Tab(
//                                             child: Text(
//                                               "Feed",
//                                               style: SafeGoogleFont(
//                                                   "Inter",
//                                                   fontSize: 16,
//                                                   fontWeight:
//                                                   FontWeight
//                                                       .w500),
//                                             ),
//                                           ),
//                                         ]),
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 // beautifulbusinesswomanportrait (2958:523)
//                                 left: 15.75 * fem,
//                                 top: 13 * fem,
//                                 child: Align(
//                                   child: SizedBox(
//                                     width: 398 * fem,
//                                     height: 201 * fem,
//                                     child: ClipRRect(
//                                       borderRadius:
//                                       BorderRadius.circular(
//                                           10 * fem),
//                                       child: Image.network(
//                                         counsellorDetailController
//                                             .cousnellorlist_detail[
//                                         0]
//                                             .coverImage
//                                             .contains("http")
//                                             ? counsellorDetailController
//                                             .cousnellorlist_detail[
//                                         0]
//                                             .coverImage
//                                             : "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
//                                         fit: BoxFit.cover,
//                                         errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                                           //print("Exception >> ${exception.toString()}");
//                                           return Image.asset('assets/page-1/images/img.png',fit: BoxFit.fill,);
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 660 * fem,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceAround,
//                             children: <Widget>[
//                               SizedBox(
//                                 width: 400 * fem,
//                                 child: Container(
//                                   // autogroupsfmiJmE (obc8V9JeemyS6W4xtsFmi)
//                                   padding: EdgeInsets.fromLTRB(
//                                       10 * fem,
//                                       15 * fem,
//                                       10 * fem,
//                                       0 * fem),
//                                   width: double.infinity,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         // group350S6k (2958:476)
//                                         margin: EdgeInsets.fromLTRB(
//                                             0 * fem,
//                                             0 * fem,
//                                             0 * fem,
//                                             7 * fem),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment
//                                               .start,
//                                           children: [
//                                             Container(
//                                               // howwillihelpBKE (2958:477)
//                                               margin: EdgeInsets
//                                                   .fromLTRB(
//                                                   0 * fem,
//                                                   0 * fem,
//                                                   0 * fem,
//                                                   0.5 * fem),
//                                               child: Text(
//                                                 'How will I help?',
//                                                 style:
//                                                 SafeGoogleFont(
//                                                   'Inter',
//                                                   fontSize:
//                                                   20 * ffem,
//                                                   fontWeight:
//                                                   FontWeight
//                                                       .w700,
//                                                   height:
//                                                   1.7549999237 *
//                                                       ffem /
//                                                       fem,
//                                                   color: const Color(
//                                                       0xff000000),
//                                                 ),
//                                               ),
//                                             ),
//                                             ReadMoreText(
//                                               counsellorDetailController
//                                                   .cousnellorlist_detail[
//                                               0]
//                                                   .howIWillHelpYou
//                                                   .map((e) =>
//                                               "\u2022 $e")
//                                                   .join("\n"),
//                                               style: SafeGoogleFont(
//                                                 'Inter',
//                                                 fontSize: 14 * ffem,
//                                                 fontWeight:
//                                                 FontWeight.w700,
//                                                 height:
//                                                 2 * ffem / fem,
//                                                 color: const Color(
//                                                     0xFF595959),
//                                               ),
//                                               trimLines: 1,
//                                               // trimLength: 20,
//                                               trimCollapsedText:
//                                               "\nRead more..",
//                                               trimExpandedText:
//                                               "\nShow less..",
//                                               moreStyle:
//                                               SafeGoogleFont(
//                                                 'Inter',
//                                                 fontSize: 15 * ffem,
//                                                 fontWeight:
//                                                 FontWeight.w700,
//                                                 height:
//                                                 1.5549999555 *
//                                                     ffem /
//                                                     fem,
//                                                 color: const Color(
//                                                     0xff040404),
//                                               ),
//                                               lessStyle:
//                                               SafeGoogleFont(
//                                                 'Inter',
//                                                 fontSize: 15 * ffem,
//                                                 fontWeight:
//                                                 FontWeight.w700,
//                                                 height:
//                                                 1.5549999555 *
//                                                     ffem /
//                                                     fem,
//                                                 color: const Color(
//                                                     0xff040404),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     width: 400 * fem,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           // group3663Ax (2958:483)
//                                           margin:
//                                           EdgeInsets.fromLTRB(
//                                               0 * fem,
//                                               0 * fem,
//                                               0 * fem,
//                                               16.13 * fem),
//                                           width: 333 * fem,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .start,
//                                             children: [
//                                               Text(
//                                                 'More Information',
//                                                 style:
//                                                 SafeGoogleFont(
//                                                   'Inter',
//                                                   fontSize:
//                                                   20 * ffem,
//                                                   fontWeight:
//                                                   FontWeight
//                                                       .w700,
//                                                   height: 1.2125 *
//                                                       ffem /
//                                                       fem,
//                                                   color: const Color(
//                                                       0xff000000),
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 10,),                                                Container(
//                                                 // group378HLC (2960:430)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     5 * fem,
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     11 * fem),
//                                                 width:
//                                                 double.infinity,
//                                                 child: Row(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Container(
//                                                       // diploma2Hn (2958:490)
//                                                       margin: EdgeInsets
//                                                           .fromLTRB(
//                                                           0 * fem,
//                                                           1 * fem,
//                                                           5 * fem,
//                                                           0 * fem),
//                                                       width:
//                                                       21 * fem,
//                                                       height:
//                                                       21 * fem,
//                                                       child: Image
//                                                           .asset(
//                                                         'assets/page-1/images/diploma.png',
//                                                         fit: BoxFit
//                                                             .cover,
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       // uiuxdesignercertificateazurece (2958:484)
//                                                       counsellorDetailController
//                                                           .cousnellorlist_detail[
//                                                       0]
//                                                           .qualifications
//                                                           .isEmpty
//                                                           ? "N/A"
//                                                           : counsellorDetailController
//                                                           .cousnellorlist_detail[
//                                                       0]
//                                                           .qualifications
//                                                           .join(
//                                                           ', '),
//                                                       style:
//                                                       SafeGoogleFont(
//                                                         'Inter',
//                                                         fontSize:
//                                                         14 *
//                                                             ffem,
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .w500,
//                                                         height:
//                                                         1.7034202251 *
//                                                             ffem /
//                                                             fem,
//                                                         color: const Color(
//                                                             0xff8e8989),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // group367Ufa (2958:486)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     6 * fem,
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     // 205 * fem,,
//                                                     0 * fem),
//                                                 width:
//                                                 double.infinity,
//                                                 child: Row(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Container(
//                                                       // group3692BJ (2958:488)
//                                                       margin: EdgeInsets
//                                                           .fromLTRB(
//                                                           0 *
//                                                               fem,
//                                                           0 *
//                                                               fem,
//                                                           10 *
//                                                               fem,
//                                                           0 * fem),
//                                                       width:
//                                                       19 * fem,
//                                                       height:
//                                                       19.87 *
//                                                           fem,
//                                                       child: Image
//                                                           .asset(
//                                                         'assets/page-1/images/group-369.png',
//                                                         width: 19 *
//                                                             fem,
//                                                         height:
//                                                         19.87 *
//                                                             fem,
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       // englishhindi9Wp (2958:487)
//                                                       margin: EdgeInsets
//                                                           .fromLTRB(
//                                                           0 *
//                                                               fem,
//                                                           1.13 *
//                                                               fem,
//                                                           0 * fem,
//                                                           0 * fem),
//                                                       child: Text(
//                                                         counsellorDetailController
//                                                             .cousnellorlist_detail[
//                                                         0]
//                                                             .languages!
//                                                             .isEmpty
//                                                             ? "N/A"
//                                                             : counsellorDetailController
//                                                             .cousnellorlist_detail[0]
//                                                             .languages!
//                                                             .join(","),
//                                                         style:
//                                                         SafeGoogleFont(
//                                                           'Inter',
//                                                           fontSize:
//                                                           14 *
//                                                               ffem,
//                                                           fontWeight:
//                                                           FontWeight
//                                                               .w500,
//                                                           height: 1.2125 *
//                                                               ffem /
//                                                               fem,
//                                                           color: const Color(
//                                                               0xff8e8989),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           // group375rg8 (2960:425)
//                                           margin:
//                                           EdgeInsets.fromLTRB(
//                                               6 * fem,
//                                               0 * fem,
//                                               0 * fem,
//                                               15 * fem),
//                                           width: double.infinity,
//                                           child: Row(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .center,
//                                             children: [
//                                               Container(
//                                                 // mapsandflagszGY (2958:542)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     7 * fem,
//                                                     0 * fem),
//                                                 width: 22 * fem,
//                                                 height: 22 * fem,
//                                                 child: Image.asset(
//                                                   'assets/page-1/images/maps-and-flags.png',
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // rajasthanjaipuriTS (2958:540)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     0 * fem,
//                                                     1 * fem,
//                                                     0 * fem,
//                                                     0 * fem),
//                                                 child: Text(
//                                                   "${counsellorDetailController.cousnellorlist_detail[0].location?.state},${counsellorDetailController.cousnellorlist_detail[0].location?.city},${counsellorDetailController.cousnellorlist_detail[0].location?.country},${counsellorDetailController.cousnellorlist_detail[0].location?.pincode}",
//                                                   style:
//                                                   SafeGoogleFont(
//                                                     'Inter',
//                                                     fontSize:
//                                                     14 * ffem,
//                                                     fontWeight:
//                                                     FontWeight
//                                                         .w500,
//                                                     height: 1.2125 *
//                                                         ffem /
//                                                         fem,
//                                                     color: const Color(
//                                                         0xff8e8989),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           // group376qHA (2960:426)
//                                           margin:
//                                           EdgeInsets.fromLTRB(
//                                               6 * fem,
//                                               0 * fem,
//                                               332 * fem,
//                                               15 * fem),
//                                           width: double.infinity,
//                                           child: Row(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .center,
//                                             children: [
//                                               Container(
//                                                 // sexB68 (2958:541)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     7 * fem,
//                                                     0 * fem),
//                                                 width: 22 * fem,
//                                                 height: 22 * fem,
//                                                 child: Image.asset(
//                                                   'assets/page-1/images/sex.png',
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // male7Eg (2958:539)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     0 * fem,
//                                                     1 * fem,
//                                                     0 * fem,
//                                                     0 * fem),
//                                                 child: Text(
//                                                   counsellorDetailController
//                                                       .cousnellorlist_detail[
//                                                   0]
//                                                       .gender,
//                                                   style:
//                                                   SafeGoogleFont(
//                                                     'Inter',
//                                                     fontSize:
//                                                     14 * ffem,
//                                                     fontWeight:
//                                                     FontWeight
//                                                         .w500,
//                                                     height: 1.2125 *
//                                                         ffem /
//                                                         fem,
//                                                     color: const Color(
//                                                         0xff8e8989),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           // group377qAg (2960:427)
//                                           margin:
//                                           EdgeInsets.fromLTRB(
//                                               4 * fem,
//                                               0 * fem,
//                                               0 * fem,
//                                               25 * fem),
//                                           width: double.infinity,
//                                           child: Row(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .center,
//                                             children: [
//                                               Container(
//                                                 // ageX3W (2958:544)
//                                                 margin: EdgeInsets
//                                                     .fromLTRB(
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     8 * fem,
//                                                     0 * fem),
//                                                 width: 23 * fem,
//                                                 height: 23 * fem,
//                                                 child: Image.asset(
//                                                   'assets/page-1/images/age.png',
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 // qZz (2958:543)
//                                                 counsellorDetailController
//                                                     .cousnellorlist_detail[
//                                                 0]
//                                                     .age ==
//                                                     null
//                                                     ? "N/A"
//                                                     : counsellorDetailController
//                                                     .cousnellorlist_detail[
//                                                 0]
//                                                     .age
//                                                     .toString(),
//                                                 style:
//                                                 SafeGoogleFont(
//                                                   'Inter',
//                                                   fontSize:
//                                                   14 * ffem,
//                                                   fontWeight:
//                                                   FontWeight
//                                                       .w500,
//                                                   height: 1.2125 *
//                                                       ffem /
//                                                       fem,
//                                                   color: const Color(
//                                                       0xff8e8989),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 440 * fem,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           // clienttestimonialsL32 (2958:482)
//                                           margin:
//                                           EdgeInsets.fromLTRB(
//                                               20 * fem,
//                                               0 * fem,
//                                               0 * fem,
//                                               3 * fem),
//                                           child: Text(
//                                             'Client Testimonials',
//                                             style: SafeGoogleFont(
//                                               'Inter',
//                                               fontSize: 20 * ffem,
//                                               fontWeight:
//                                               FontWeight.w700,
//                                               height: 1.2125 *
//                                                   ffem /
//                                                   fem,
//                                               color: const Color(
//                                                   0xff000000),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: MediaQuery.of(context).size.height * 0.23,
//                                           child: PageView(
//                                             children: [
//                                               Container(
//                                                 // group368qVa (2958:504)
//                                                 margin:
//                                                 EdgeInsets.fromLTRB(
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     0 * fem),
//                                                 width: double.infinity,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Container(
//                                                       // group363y5z (2958:509)
//                                                       margin: EdgeInsets
//                                                           .fromLTRB(
//                                                           0 * fem,
//                                                           0 * fem,
//                                                           0 * fem,
//                                                           5 * fem),
//                                                       width:
//                                                       double.infinity,
//                                                       height: 190 * fem,
//                                                       child: Stack(
//                                                         children: [
//                                                           Positioned(
//                                                             // rectangle265uVS (2958:510)
//                                                             left:
//                                                             38 * fem,
//                                                             top: 0 * fem,
//                                                             child: Align(
//                                                               child:
//                                                               SizedBox(
//                                                                 width: 355 *
//                                                                     fem,
//                                                                 height:
//                                                                 176 *
//                                                                     fem,
//                                                                 child:
//                                                                 Container(
//                                                                   decoration:
//                                                                   BoxDecoration(
//                                                                     borderRadius:
//                                                                     BorderRadius.circular(10 * fem),
//                                                                     color:
//                                                                     const Color(0xffffffff),
//                                                                     boxShadow: [
//                                                                       BoxShadow(
//                                                                         color: const Color(0x1c000000),
//                                                                         offset: Offset(0 * fem, 2 * fem),
//                                                                         blurRadius: 6 * fem,
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Positioned(
//                                                             // group362BSx (2958:511)
//                                                             left: 0 * fem,
//                                                             top: 13 * fem,
//                                                             child:
//                                                             SizedBox(
//                                                               width: 448 *
//                                                                   fem,
//                                                               height:
//                                                               145 *
//                                                                   fem,
//                                                               child:
//                                                               Column(
//                                                                 crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .center,
//                                                                 children: [
//                                                                   Container(
//                                                                     // ellipse34hgC (2958:518)
//                                                                     margin: EdgeInsets.fromLTRB(
//                                                                         194 * fem,
//                                                                         0 * fem,
//                                                                         194 * fem,
//                                                                         6 * fem),
//                                                                     width:
//                                                                     double.infinity,
//                                                                     height:
//                                                                     60 * fem,
//                                                                     decoration:
//                                                                     BoxDecoration(
//                                                                       borderRadius:
//                                                                       BorderRadius.circular(30 * fem),
//                                                                       image:
//                                                                       const DecorationImage(
//                                                                         fit: BoxFit.cover,
//                                                                         image: NetworkImage(
//                                                                           "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Container(
//                                                                     // autogroupkg8gQKi (obd53QjXDk74WfGeHkg8G)
//                                                                     margin: EdgeInsets.fromLTRB(
//                                                                         20 * fem,
//                                                                         0 * fem,
//                                                                         22 * fem,
//                                                                         12.79 * fem),
//                                                                     width:
//                                                                     double.infinity,
//                                                                     child:
//                                                                     Row(
//                                                                       crossAxisAlignment:
//                                                                       CrossAxisAlignment.start,
//                                                                       children: [
//                                                                         Container(
//                                                                           // vectorvor (2958:521)
//                                                                           margin: EdgeInsets.fromLTRB(0 * fem, 2 * fem, 142.5 * fem, 0 * fem),
//                                                                           width: 13 * fem,
//                                                                           height: 33 * fem,
//                                                                           child: Image.asset(
//                                                                             'assets/page-1/images/vector-jKW.png',
//                                                                             width: 13 * fem,
//                                                                             height: 33 * fem,
//                                                                           ),
//                                                                         ),
//                                                                         Container(
//                                                                           // autogroupyqpxFbE (obdB3EjxG3FnEim7TyQpx)
//                                                                           margin: EdgeInsets.fromLTRB(0 * fem, 6 * fem, 139.53 * fem, 0 * fem),
//                                                                           width: 96.97 * fem,
//                                                                           child: Column(
//                                                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                                                             children: [
//                                                                               Container(
//                                                                                 // alexyXE (2958:519)
//                                                                                 margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0.97 * fem, 12.78 * fem),
//                                                                                 child: Text(
//                                                                                   "N/A",
//                                                                                   textAlign: TextAlign.center,
//                                                                                   style: SafeGoogleFont(
//                                                                                     'Inter',
//                                                                                     fontSize: 12 * ffem,
//                                                                                     fontWeight: FontWeight.w400,
//                                                                                     height: 1.2125 * ffem / fem,
//                                                                                     color: const Color(0xff000000),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                               SizedBox(
//                                                                                 // group3616Lx (2958:512)
//                                                                                 width: double.infinity,
//                                                                                 child: Row(
//                                                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                                                   children: [
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:513)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/group-95T.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:514)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/group-yah.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:515)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/group-yah.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:516)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/unfillstar.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:517)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/unfillstar.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                   ],
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                         SizedBox(
//                                                                           // vectorKWY (2958:522)
//                                                                           width: 14 * fem,
//                                                                           height: 33 * fem,
//                                                                           child: Image.asset(
//                                                                             'assets/page-1/images/vector-DCt.png',
//                                                                             width: 14 * fem,
//                                                                             height: 33 * fem,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Text(
//                                                                     // compassionateinsightfulcounsel (2958:520)
//                                                                     'N/A',
//                                                                     textAlign:
//                                                                     TextAlign.center,
//                                                                     style:
//                                                                     SafeGoogleFont(
//                                                                       'Inter',
//                                                                       fontSize:
//                                                                       11 * ffem,
//                                                                       fontWeight:
//                                                                       FontWeight.w400,
//                                                                       height: 1.2125 *
//                                                                           ffem /
//                                                                           fem,
//                                                                       fontStyle:
//                                                                       FontStyle.italic,
//                                                                       color:
//                                                                       const Color(0xffa09d9d),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     // Container(
//                                                     //   // frame134m7e (2958:505)
//                                                     //   margin: EdgeInsets
//                                                     //       .fromLTRB(
//                                                     //       0 * fem,
//                                                     //       0 * fem,
//                                                     //       8.29 * fem,
//                                                     //       0 * fem),
//                                                     //   width: 33.78 * fem,
//                                                     //   height: 6.43 * fem,
//                                                     //   child: Image.asset(
//                                                     //     'assets/page-1/images/frame-134.png',
//                                                     //     width:
//                                                     //     33.78 * fem,
//                                                     //     height:
//                                                     //     6.43 * fem,
//                                                     //   ),
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // group368qVa (2958:504)
//                                                 margin:
//                                                 EdgeInsets.fromLTRB(
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     0 * fem),
//                                                 width: double.infinity,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Container(
//                                                       // group363y5z (2958:509)
//                                                       margin: EdgeInsets
//                                                           .fromLTRB(
//                                                           0 * fem,
//                                                           0 * fem,
//                                                           0 * fem,
//                                                           5 * fem),
//                                                       width:
//                                                       double.infinity,
//                                                       height: 190 * fem,
//                                                       child: Stack(
//                                                         children: [
//                                                           Positioned(
//                                                             // rectangle265uVS (2958:510)
//                                                             left:
//                                                             38 * fem,
//                                                             top: 0 * fem,
//                                                             child: Align(
//                                                               child:
//                                                               SizedBox(
//                                                                 width: 355 *
//                                                                     fem,
//                                                                 height:
//                                                                 176 *
//                                                                     fem,
//                                                                 child:
//                                                                 Container(
//                                                                   decoration:
//                                                                   BoxDecoration(
//                                                                     borderRadius:
//                                                                     BorderRadius.circular(10 * fem),
//                                                                     color:
//                                                                     const Color(0xffffffff),
//                                                                     boxShadow: [
//                                                                       BoxShadow(
//                                                                         color: const Color(0x1c000000),
//                                                                         offset: Offset(0 * fem, 2 * fem),
//                                                                         blurRadius: 6 * fem,
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Positioned(
//                                                             // group362BSx (2958:511)
//                                                             left: 0 * fem,
//                                                             top: 13 * fem,
//                                                             child:
//                                                             SizedBox(
//                                                               width: 448 *
//                                                                   fem,
//                                                               height:
//                                                               145 *
//                                                                   fem,
//                                                               child:
//                                                               Column(
//                                                                 crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .center,
//                                                                 children: [
//                                                                   Container(
//                                                                     // ellipse34hgC (2958:518)
//                                                                     margin: EdgeInsets.fromLTRB(
//                                                                         194 * fem,
//                                                                         0 * fem,
//                                                                         194 * fem,
//                                                                         6 * fem),
//                                                                     width:
//                                                                     double.infinity,
//                                                                     height:
//                                                                     60 * fem,
//                                                                     decoration:
//                                                                     BoxDecoration(
//                                                                       borderRadius:
//                                                                       BorderRadius.circular(30 * fem),
//                                                                       image:
//                                                                       const DecorationImage(
//                                                                         fit: BoxFit.cover,
//                                                                         image: NetworkImage(
//                                                                           "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Container(
//                                                                     // autogroupkg8gQKi (obd53QjXDk74WfGeHkg8G)
//                                                                     margin: EdgeInsets.fromLTRB(
//                                                                         20 * fem,
//                                                                         0 * fem,
//                                                                         22 * fem,
//                                                                         12.79 * fem),
//                                                                     width:
//                                                                     double.infinity,
//                                                                     child:
//                                                                     Row(
//                                                                       crossAxisAlignment:
//                                                                       CrossAxisAlignment.start,
//                                                                       children: [
//                                                                         Container(
//                                                                           // vectorvor (2958:521)
//                                                                           margin: EdgeInsets.fromLTRB(0 * fem, 2 * fem, 142.5 * fem, 0 * fem),
//                                                                           width: 13 * fem,
//                                                                           height: 33 * fem,
//                                                                           child: Image.asset(
//                                                                             'assets/page-1/images/vector-jKW.png',
//                                                                             width: 13 * fem,
//                                                                             height: 33 * fem,
//                                                                           ),
//                                                                         ),
//                                                                         Container(
//                                                                           // autogroupyqpxFbE (obdB3EjxG3FnEim7TyQpx)
//                                                                           margin: EdgeInsets.fromLTRB(0 * fem, 6 * fem, 139.53 * fem, 0 * fem),
//                                                                           width: 96.97 * fem,
//                                                                           child: Column(
//                                                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                                                             children: [
//                                                                               Container(
//                                                                                 // alexyXE (2958:519)
//                                                                                 margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0.97 * fem, 12.78 * fem),
//                                                                                 child: Text(
//                                                                                   "N/A",
//                                                                                   textAlign: TextAlign.center,
//                                                                                   style: SafeGoogleFont(
//                                                                                     'Inter',
//                                                                                     fontSize: 12 * ffem,
//                                                                                     fontWeight: FontWeight.w400,
//                                                                                     height: 1.2125 * ffem / fem,
//                                                                                     color: const Color(0xff000000),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                               SizedBox(
//                                                                                 // group3616Lx (2958:512)
//                                                                                 width: double.infinity,
//                                                                                 child: Row(
//                                                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                                                   children: [
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:513)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/group-95T.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:514)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/group-yah.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:515)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/group-yah.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:516)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/unfillstar.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:517)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/unfillstar.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                   ],
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                         SizedBox(
//                                                                           // vectorKWY (2958:522)
//                                                                           width: 14 * fem,
//                                                                           height: 33 * fem,
//                                                                           child: Image.asset(
//                                                                             'assets/page-1/images/vector-DCt.png',
//                                                                             width: 14 * fem,
//                                                                             height: 33 * fem,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Text(
//                                                                     // compassionateinsightfulcounsel (2958:520)
//                                                                     'N/A',
//                                                                     textAlign:
//                                                                     TextAlign.center,
//                                                                     style:
//                                                                     SafeGoogleFont(
//                                                                       'Inter',
//                                                                       fontSize:
//                                                                       11 * ffem,
//                                                                       fontWeight:
//                                                                       FontWeight.w400,
//                                                                       height: 1.2125 *
//                                                                           ffem /
//                                                                           fem,
//                                                                       fontStyle:
//                                                                       FontStyle.italic,
//                                                                       color:
//                                                                       const Color(0xffa09d9d),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     // Container(
//                                                     //   // frame134m7e (2958:505)
//                                                     //   margin: EdgeInsets
//                                                     //       .fromLTRB(
//                                                     //       0 * fem,
//                                                     //       0 * fem,
//                                                     //       8.29 * fem,
//                                                     //       0 * fem),
//                                                     //   width: 33.78 * fem,
//                                                     //   height: 6.43 * fem,
//                                                     //   child: Image.asset(
//                                                     //     'assets/page-1/images/frame-134.png',
//                                                     //     width:
//                                                     //     33.78 * fem,
//                                                     //     height:
//                                                     //     6.43 * fem,
//                                                     //   ),
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // group368qVa (2958:504)
//                                                 margin:
//                                                 EdgeInsets.fromLTRB(
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     0 * fem,
//                                                     0 * fem),
//                                                 width: double.infinity,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Container(
//                                                       // group363y5z (2958:509)
//                                                       margin: EdgeInsets
//                                                           .fromLTRB(
//                                                           0 * fem,
//                                                           0 * fem,
//                                                           0 * fem,
//                                                           5 * fem),
//                                                       width:
//                                                       double.infinity,
//                                                       height: 190 * fem,
//                                                       child: Stack(
//                                                         children: [
//                                                           Positioned(
//                                                             // rectangle265uVS (2958:510)
//                                                             left:
//                                                             38 * fem,
//                                                             top: 0 * fem,
//                                                             child: Align(
//                                                               child:
//                                                               SizedBox(
//                                                                 width: 355 *
//                                                                     fem,
//                                                                 height:
//                                                                 176 *
//                                                                     fem,
//                                                                 child:
//                                                                 Container(
//                                                                   decoration:
//                                                                   BoxDecoration(
//                                                                     borderRadius:
//                                                                     BorderRadius.circular(10 * fem),
//                                                                     color:
//                                                                     const Color(0xffffffff),
//                                                                     boxShadow: [
//                                                                       BoxShadow(
//                                                                         color: const Color(0x1c000000),
//                                                                         offset: Offset(0 * fem, 2 * fem),
//                                                                         blurRadius: 6 * fem,
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Positioned(
//                                                             // group362BSx (2958:511)
//                                                             left: 0 * fem,
//                                                             top: 13 * fem,
//                                                             child:
//                                                             SizedBox(
//                                                               width: 448 *
//                                                                   fem,
//                                                               height:
//                                                               145 *
//                                                                   fem,
//                                                               child:
//                                                               Column(
//                                                                 crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .center,
//                                                                 children: [
//                                                                   Container(
//                                                                     // ellipse34hgC (2958:518)
//                                                                     margin: EdgeInsets.fromLTRB(
//                                                                         194 * fem,
//                                                                         0 * fem,
//                                                                         194 * fem,
//                                                                         6 * fem),
//                                                                     width:
//                                                                     double.infinity,
//                                                                     height:
//                                                                     60 * fem,
//                                                                     decoration:
//                                                                     BoxDecoration(
//                                                                       borderRadius:
//                                                                       BorderRadius.circular(30 * fem),
//                                                                       image:
//                                                                       const DecorationImage(
//                                                                         fit: BoxFit.cover,
//                                                                         image: NetworkImage(
//                                                                           "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Container(
//                                                                     // autogroupkg8gQKi (obd53QjXDk74WfGeHkg8G)
//                                                                     margin: EdgeInsets.fromLTRB(
//                                                                         20 * fem,
//                                                                         0 * fem,
//                                                                         22 * fem,
//                                                                         12.79 * fem),
//                                                                     width:
//                                                                     double.infinity,
//                                                                     child:
//                                                                     Row(
//                                                                       crossAxisAlignment:
//                                                                       CrossAxisAlignment.start,
//                                                                       children: [
//                                                                         Container(
//                                                                           // vectorvor (2958:521)
//                                                                           margin: EdgeInsets.fromLTRB(0 * fem, 2 * fem, 142.5 * fem, 0 * fem),
//                                                                           width: 13 * fem,
//                                                                           height: 33 * fem,
//                                                                           child: Image.asset(
//                                                                             'assets/page-1/images/vector-jKW.png',
//                                                                             width: 13 * fem,
//                                                                             height: 33 * fem,
//                                                                           ),
//                                                                         ),
//                                                                         Container(
//                                                                           // autogroupyqpxFbE (obdB3EjxG3FnEim7TyQpx)
//                                                                           margin: EdgeInsets.fromLTRB(0 * fem, 6 * fem, 139.53 * fem, 0 * fem),
//                                                                           width: 96.97 * fem,
//                                                                           child: Column(
//                                                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                                                             children: [
//                                                                               Container(
//                                                                                 // alexyXE (2958:519)
//                                                                                 margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0.97 * fem, 12.78 * fem),
//                                                                                 child: Text(
//                                                                                   "N/A",
//                                                                                   textAlign: TextAlign.center,
//                                                                                   style: SafeGoogleFont(
//                                                                                     'Inter',
//                                                                                     fontSize: 12 * ffem,
//                                                                                     fontWeight: FontWeight.w400,
//                                                                                     height: 1.2125 * ffem / fem,
//                                                                                     color: const Color(0xff000000),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                               SizedBox(
//                                                                                 // group3616Lx (2958:512)
//                                                                                 width: double.infinity,
//                                                                                 child: Row(
//                                                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                                                   children: [
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:513)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/group-95T.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:514)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/group-yah.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:515)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/group-yah.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:516)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/unfillstar.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 8.03 * fem,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       // streamlineinterfacefavoritesta (2958:517)
//                                                                                       width: 12.97 * fem,
//                                                                                       height: 12.44 * fem,
//                                                                                       child: Image.asset(
//                                                                                         'assets/page-1/images/unfillstar.png',
//                                                                                         width: 12.97 * fem,
//                                                                                         height: 12.44 * fem,
//                                                                                       ),
//                                                                                     ),
//                                                                                   ],
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                         SizedBox(
//                                                                           // vectorKWY (2958:522)
//                                                                           width: 14 * fem,
//                                                                           height: 33 * fem,
//                                                                           child: Image.asset(
//                                                                             'assets/page-1/images/vector-DCt.png',
//                                                                             width: 14 * fem,
//                                                                             height: 33 * fem,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Text(
//                                                                     // compassionateinsightfulcounsel (2958:520)
//                                                                     'N/A',
//                                                                     textAlign:
//                                                                     TextAlign.center,
//                                                                     style:
//                                                                     SafeGoogleFont(
//                                                                       'Inter',
//                                                                       fontSize:
//                                                                       11 * ffem,
//                                                                       fontWeight:
//                                                                       FontWeight.w400,
//                                                                       height: 1.2125 *
//                                                                           ffem /
//                                                                           fem,
//                                                                       fontStyle:
//                                                                       FontStyle.italic,
//                                                                       color:
//                                                                       const Color(0xffa09d9d),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     // Container(
//                                                     //   // frame134m7e (2958:505)
//                                                     //   margin: EdgeInsets
//                                                     //       .fromLTRB(
//                                                     //       0 * fem,
//                                                     //       0 * fem,
//                                                     //       8.29 * fem,
//                                                     //       0 * fem),
//                                                     //   width: 33.78 * fem,
//                                                     //   height: 6.43 * fem,
//                                                     //   child: Image.asset(
//                                                     //     'assets/page-1/images/frame-134.png',
//                                                     //     width:
//                                                     //     33.78 * fem,
//                                                     //     height:
//                                                     //     6.43 * fem,
//                                                     //   ),
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//
//                                         Container(
//                                           // group374Gq6 (2958:538)
//                                           margin:
//                                           EdgeInsets.fromLTRB(
//                                               8 * fem,
//                                               0 * fem,
//                                               11 * fem,
//                                               0 * fem),
//                                           width: double.infinity,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .center,
//                                             children: [
//                                               const SizedBox(
//                                                 height: 8,
//                                               ),
//                                               Container(
//                                                 // autogroupndmaoq2 (obcXDzR7vjLQoZdzSNDMA)
//                                                 padding: EdgeInsets
//                                                     .fromLTRB(
//                                                     16.5 * fem,
//                                                     0 * fem,
//                                                     16.5 * fem,
//                                                     12.79 *
//                                                         fem),
//                                                 width:
//                                                 double.infinity,
//                                                 height: 61 * fem,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .start,
//                                                   children: [
//                                                     Container(
//                                                       // giveareviewLKA (2958:502)
//                                                       margin: EdgeInsets
//                                                           .fromLTRB(
//                                                           0.5 *
//                                                               fem,
//                                                           0 *
//                                                               fem,
//                                                           0 *
//                                                               fem,
//                                                           3.78 *
//                                                               fem),
//                                                       child: Text(
//                                                         'Give a Review',
//                                                         style:
//                                                         SafeGoogleFont(
//                                                           'Inter',
//                                                           fontSize:
//                                                           16 *
//                                                               ffem,
//                                                           fontWeight:
//                                                           FontWeight
//                                                               .w700,
//                                                           height: 1.7002272606 *
//                                                               ffem /
//                                                               fem,
//                                                           color: const Color(
//                                                               0xff000000),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       // group360eKr (2958:496)
//                                                       child: Row(
//                                                         crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                         children: [
//                                                           SizedBox(
//                                                             // streamlineinterfacefavoritesta (2958:497)
//                                                             width: 12.97 *
//                                                                 fem,
//                                                             height: 12.44 *
//                                                                 fem,
//                                                             child: Image
//                                                                 .asset(
//                                                               'assets/page-1/images/unfillstar.png',
//                                                               width:
//                                                               12.97 * fem,
//                                                               height:
//                                                               12.44 * fem,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             width: 8.03 *
//                                                                 fem,
//                                                           ),
//                                                           SizedBox(
//                                                             // streamlineinterfacefavoritesta (2958:498)
//                                                             width: 12.97 *
//                                                                 fem,
//                                                             height: 12.44 *
//                                                                 fem,
//                                                             child: Image
//                                                                 .asset(
//                                                               'assets/page-1/images/unfillstar.png',
//                                                               width:
//                                                               12.97 * fem,
//                                                               height:
//                                                               12.44 * fem,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             width: 8.03 *
//                                                                 fem,
//                                                           ),
//                                                           SizedBox(
//                                                             // streamlineinterfacefavoritesta (2958:499)
//                                                             width: 12.97 *
//                                                                 fem,
//                                                             height: 12.44 *
//                                                                 fem,
//                                                             child: Image
//                                                                 .asset(
//                                                               'assets/page-1/images/unfillstar.png',
//                                                               width:
//                                                               12.97 * fem,
//                                                               height:
//                                                               12.44 * fem,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             width: 8.03 *
//                                                                 fem,
//                                                           ),
//                                                           SizedBox(
//                                                             // streamlineinterfacefavoritesta (2958:500)
//                                                             width: 12.97 *
//                                                                 fem,
//                                                             height: 12.44 *
//                                                                 fem,
//                                                             child: Image
//                                                                 .asset(
//                                                               'assets/page-1/images/group-PhK.png',
//                                                               width:
//                                                               12.97 * fem,
//                                                               height:
//                                                               12.44 * fem,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             width: 8.03 *
//                                                                 fem,
//                                                           ),
//                                                           SizedBox(
//                                                             // streamlineinterfacefavoritesta (2958:501)
//                                                             width: 12.97 *
//                                                                 fem,
//                                                             height: 12.44 *
//                                                                 fem,
//                                                             child: Image
//                                                                 .asset(
//                                                               'assets/page-1/images/group-PhK.png',
//                                                               width:
//                                                               12.97 * fem,
//                                                               height:
//                                                               12.44 * fem,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // group365t1E (2958:491)
//                                                 padding: EdgeInsets
//                                                     .fromLTRB(
//                                                     16 * fem,
//                                                     8 * fem,
//                                                     17 * fem,
//                                                     8 * fem),
//                                                 width:
//                                                 double.infinity,
//                                                 height: 38 * fem,
//                                                 decoration:
//                                                 BoxDecoration(
//                                                   border: Border.all(
//                                                       color: const Color(
//                                                           0xffd5cfcf)),
//                                                   color: const Color(
//                                                       0xffffffff),
//                                                 ),
//                                                 child: Row(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     Container(
//                                                       // commentaue (2958:493)
//                                                       margin: EdgeInsets
//                                                           .fromLTRB(
//                                                           0 *
//                                                               fem,
//                                                           0 *
//                                                               fem,
//                                                           276 *
//                                                               fem,
//                                                           0 * fem),
//                                                       child: Text(
//                                                         'Comment...',
//                                                         style:
//                                                         SafeGoogleFont(
//                                                           'Inter',
//                                                           fontSize:
//                                                           14 *
//                                                               ffem,
//                                                           fontWeight:
//                                                           FontWeight
//                                                               .w500,
//                                                           height: 1.7034202251 *
//                                                               ffem /
//                                                               fem,
//                                                           color: const Color(
//                                                               0xffd5cfcf),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       // icbaselinesend7Pn (2958:494)
//                                                       width:
//                                                       21 * fem,
//                                                       height:
//                                                       18 * fem,
//                                                       child: Image
//                                                           .asset(
//                                                         'assets/page-1/images/ic-baseline-send.png',
//                                                         width: 21 *
//                                                             fem,
//                                                         height: 18 *
//                                                             fem,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               // group371aXa (2936:506)
//               //width: double.infinity,
//               child: Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     // autogroupuuww8oz (obZ7jq9Hv3ndwJa9LuuwW)
//                     width: double.infinity,
//                     height: 113 * fem,
//                     child: Expanded(
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             // frame324GvC (2936:447)
//                             left: 0 * fem,
//                             top: 55 * fem,
//                             child: Container(
//                               padding: EdgeInsets.fromLTRB(
//                                   16 * fem,
//                                   8 * fem,
//                                   16 * fem,
//                                   8 * fem),
//                               width: 430 * fem,
//                               height: 57 * fem,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: const Color(
//                                         0x35000000)),
//                               ),
//                               child: SizedBox(
//                                 // group370NiL (2936:483)
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 child: Row(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment
//                                       .center,
//                                   children: [
//                                     Container(
//                                       // group347Kda (2936:448)
//                                       margin: EdgeInsets
//                                           .fromLTRB(
//                                           0 * fem,
//                                           0 * fem,
//                                           115 * fem,
//                                           0 * fem),
//                                       height:
//                                       double.infinity,
//                                       child: Row(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .center,
//                                         children: [
//                                           Container(
//                                             // group345fBe (2936:458)
//                                             margin: EdgeInsets
//                                                 .fromLTRB(
//                                                 0 * fem,
//                                                 0 * fem,
//                                                 5 * fem,
//                                                 0 * fem),
//                                             width:
//                                             42 * fem,
//                                             height: double
//                                                 .infinity,
//                                             child: Stack(
//                                               children: [
//                                                 Positioned(
//                                                   // group298bLC (2936:459)
//                                                   left: 0 *
//                                                       fem,
//                                                   top: 0 *
//                                                       fem,
//                                                   child:
//                                                   Align(
//                                                     child:
//                                                     SizedBox(
//                                                       width:
//                                                       42 * fem,
//                                                       height:
//                                                       41 * fem,
//                                                       child:
//                                                       Image.asset(
//                                                         'assets/page-1/images/group-298.png',
//                                                         width: 42 * fem,
//                                                         height: 41 * fem,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Positioned(
//                                                   // conversationi9v (2936:461)
//                                                   left: 10.7692871094 *
//                                                       fem,
//                                                   top: 9.4614257812 *
//                                                       fem,
//                                                   child:
//                                                   Align(
//                                                     child:
//                                                     SizedBox(
//                                                       width:
//                                                       21.54 * fem,
//                                                       height:
//                                                       21.03 * fem,
//                                                       child:
//                                                       Image.asset(
//                                                         'assets/page-1/images/conversation.png',
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             // group346qEY (2936:449)
//                                             margin: EdgeInsets
//                                                 .fromLTRB(
//                                                 0 *
//                                                     fem,
//                                                 0.5 *
//                                                     fem,
//                                                 0 * fem,
//                                                 1 * fem),
//                                             width:
//                                             115 * fem,
//                                             height: double
//                                                 .infinity,
//                                             child: Stack(
//                                               children: [
//                                                 Positioned(
//                                                   // personalsessionmdz (2936:453)
//                                                   left: 0 *
//                                                       fem,
//                                                   top: 0 *
//                                                       fem,
//                                                   child:
//                                                   Align(
//                                                     child:
//                                                     SizedBox(
//                                                       width:
//                                                       97 * fem,
//                                                       height:
//                                                       15 * fem,
//                                                       child:
//                                                       Text(
//                                                         'Personal Session',
//                                                         style: SafeGoogleFont(
//                                                           'Inter',
//                                                           fontSize: 12 * ffem,
//                                                           fontWeight: FontWeight.w400,
//                                                           height: 1.2125 * ffem / fem,
//                                                           color: const Color(0xff000000),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Positioned(
//                                                   // group344gW4 (2936:454)
//                                                   left: 0 *
//                                                       fem,
//                                                   top: 14.5 *
//                                                       fem,
//                                                   child:
//                                                   SizedBox(
//                                                     width:
//                                                     115 * fem,
//                                                     height:
//                                                     25 * fem,
//                                                     child:
//                                                     Expanded(
//                                                       child: Row(
//                                                         crossAxisAlignment:
//                                                         CrossAxisAlignment.center,
//                                                         children: [
//                                                           Container(
//                                                             // rupeebsv (2936:457)
//                                                             margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 1 * fem),
//                                                             width: 11 * fem,
//                                                             height: 14 * fem,
//                                                             child: Image.asset(
//                                                               'assets/page-1/images/rupee-12.png',
//                                                               fit: BoxFit.cover,
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                             // LKi (2936:455)
//                                                             margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 0 * fem),
//                                                             child: Text(
//                                                               counsellorDetailController.cousnellorlist_detail[0].personalSessionPrice == null ? "0" : counsellorDetailController.cousnellorlist_detail[0].personalSessionPrice.toString(),
//                                                               style: SafeGoogleFont(
//                                                                 'Inter',
//                                                                 fontSize: 20 * ffem,
//                                                                 fontWeight: FontWeight.w600,
//                                                                 height: 1.2125 * ffem / fem,
//                                                                 color: const Color(0xff000000),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                             // onwardsTfE (2936:456)
//                                                             margin: EdgeInsets.fromLTRB(0 * fem, 4 * fem, 0 * fem, 0 * fem),
//                                                             child: Text(
//                                                               ' Onwards',
//                                                               style: SafeGoogleFont(
//                                                                 'Inter',
//                                                                 fontSize: 12 * ffem,
//                                                                 fontWeight: FontWeight.w500,
//                                                                 height: 1.2125 * ffem / fem,
//                                                                 color: const Color(0xff6b6b6b),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         onTapBook(context);
//                                       },
//                                       child: Container(
//                                         // group349P36 (2936:462)
//                                         width: 116 * fem,
//                                         height:
//                                         double.infinity,
//                                         decoration:
//                                         BoxDecoration(
//                                           color: const Color(
//                                               0xff1f0a68),
//                                           borderRadius:
//                                           BorderRadius
//                                               .circular(
//                                               5 * fem),
//                                         ),
//                                         child: Center(
//                                           child: Center(
//                                             child: Text(
//                                               'Book',
//                                               textAlign:
//                                               TextAlign
//                                                   .center,
//                                               style:
//                                               SafeGoogleFont(
//                                                 'Inter',
//                                                 fontSize:
//                                                 16 *
//                                                     ffem,
//                                                 fontWeight:
//                                                 FontWeight
//                                                     .w400,
//                                                 height:
//                                                 1.2125 *
//                                                     ffem /
//                                                     fem,
//                                                 color: const Color(
//                                                     0xffffffff),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             // frame32649E (2936:484)
//                             left: 0 * fem,
//                             top: 0 * fem,
//                             child: Container(
//                               padding: EdgeInsets.fromLTRB(
//                                   16 * fem,
//                                   8 * fem,
//                                   16 * fem,
//                                   8 * fem),
//                               width: 430 * fem,
//                               height: 57 * fem,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: const Color(
//                                         0x35000000)),
//                               ),
//                               child: SizedBox(
//                                 // group370y1J (2936:485)
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 child: Row(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment
//                                       .center,
//                                   children: [
//                                     Container(
//                                       // group347XHi (2936:486)
//                                       margin: EdgeInsets
//                                           .fromLTRB(
//                                           0 * fem,
//                                           0 * fem,
//                                           123 * fem,
//                                           0 * fem),
//                                       height:
//                                       double.infinity,
//                                       child: Row(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .center,
//                                         children: [
//                                           Container(
//                                             // autogroupvexiTSG (obZYj7WRacadntT6aVeXi)
//                                             margin: EdgeInsets
//                                                 .fromLTRB(
//                                                 0 * fem,
//                                                 0 * fem,
//                                                 8 * fem,
//                                                 0 * fem),
//                                             width: 42 * fem,
//                                             height: double
//                                                 .infinity,
//                                             child: Stack(
//                                               children: [
//                                                 Positioned(
//                                                   // group345C8x (2936:496)
//                                                   left: 0 *
//                                                       fem,
//                                                   top: 0 *
//                                                       fem,
//                                                   child:
//                                                   Align(
//                                                     child:
//                                                     SizedBox(
//                                                       width:
//                                                       42 * fem,
//                                                       height:
//                                                       41 * fem,
//                                                       child:
//                                                       Image.asset(
//                                                         'assets/page-1/images/ellipse-47-xPB.png',
//                                                         width:
//                                                         42 * fem,
//                                                         height:
//                                                         41 * fem,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Positioned(
//                                                   // usersgroupJxg (2936:503)
//                                                   left: 11 *
//                                                       fem,
//                                                   top: 10 *
//                                                       fem,
//                                                   child:
//                                                   Align(
//                                                     child:
//                                                     SizedBox(
//                                                       width:
//                                                       21 * fem,
//                                                       height:
//                                                       21 * fem,
//                                                       child:
//                                                       Image.asset(
//                                                         'assets/page-1/images/usergroup.png',
//                                                         fit:
//                                                         BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             // group346EbS (2936:487)
//                                             margin: EdgeInsets
//                                                 .fromLTRB(
//                                                 0 * fem,
//                                                 0.5 *
//                                                     fem,
//                                                 0 * fem,
//                                                 1 * fem),
//                                             width:
//                                             105 * fem,
//                                             height: double
//                                                 .infinity,
//                                             child: Stack(
//                                               children: [
//                                                 Positioned(
//                                                   // groupsessionZtc (2936:491)
//                                                   left: 0 *
//                                                       fem,
//                                                   top: 0 *
//                                                       fem,
//                                                   child:
//                                                   Align(
//                                                     child:
//                                                     SizedBox(
//                                                       width:
//                                                       83 * fem,
//                                                       height:
//                                                       15 * fem,
//                                                       child:
//                                                       Text(
//                                                         'Group Session',
//                                                         style:
//                                                         SafeGoogleFont(
//                                                           'Inter',
//                                                           fontSize: 12 * ffem,
//                                                           fontWeight: FontWeight.w400,
//                                                           height: 1.2125 * ffem / fem,
//                                                           color: const Color(0xff000000),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Positioned(
//                                                   // group344UEt (2936:492)
//                                                   left: 0 *
//                                                       fem,
//                                                   top: 14.5 *
//                                                       fem,
//                                                   child:
//                                                   SizedBox(
//                                                     width: 105 *
//                                                         fem,
//                                                     height: 25 *
//                                                         fem,
//                                                     child:
//                                                     Row(
//                                                       crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                       children: [
//                                                         Container(
//                                                           // rupeezU8 (2936:495)
//                                                           margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 1 * fem),
//                                                           width: 11 * fem,
//                                                           height: 14 * fem,
//                                                           child: Image.asset(
//                                                             'assets/page-1/images/rupee-12.png',
//                                                             fit: BoxFit.cover,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           // vcg (2936:493)
//                                                           counsellorDetailController.cousnellorlist_detail[0].groupSessionPrice == null ? "0" : counsellorDetailController.cousnellorlist_detail[0].groupSessionPrice.toString(),
//                                                           style: SafeGoogleFont(
//                                                             'Inter',
//                                                             fontSize: 20 * ffem,
//                                                             fontWeight: FontWeight.w600,
//                                                             height: 1.2125 * ffem / fem,
//                                                             color: const Color(0xff000000),
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           // onwards5Va (2936:494)
//                                                           margin: EdgeInsets.fromLTRB(0 * fem, 4 * fem, 0 * fem, 0 * fem),
//                                                           child: Text(
//                                                             ' Onwards',
//                                                             style: SafeGoogleFont(
//                                                               'Inter',
//                                                               fontSize: 12 * ffem,
//                                                               fontWeight: FontWeight.w500,
//                                                               height: 1.2125 * ffem / fem,
//                                                               color: const Color(0xff6b6b6b),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         onTapBook(context);
//                                       },
//                                       child: Container(
//                                         // group349oRa (2936:500)
//                                         width: 116 * fem,
//                                         height:
//                                         double.infinity,
//                                         decoration:
//                                         BoxDecoration(
//                                           color: const Color(
//                                               0xff1f0a68),
//                                           borderRadius:
//                                           BorderRadius
//                                               .circular(
//                                               5 * fem),
//                                         ),
//                                         child: Center(
//                                           child: Center(
//                                             child: Text(
//                                               'Book',
//                                               textAlign:
//                                               TextAlign
//                                                   .center,
//                                               style:
//                                               SafeGoogleFont(
//                                                 'Inter',
//                                                 fontSize:
//                                                 16 *
//                                                     ffem,
//                                                 fontWeight:
//                                                 FontWeight
//                                                     .w400,
//                                                 height:
//                                                 1.2125 *
//                                                     ffem /
//                                                     fem,
//                                                 color: const Color(
//                                                     0xffffffff),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// //updated