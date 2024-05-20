import 'package:flutter/material.dart';

class HiddenText extends StatelessWidget {
  final String id;

  const HiddenText({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: Text(id),
    );
  }
}
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:get/route_manager.dart';
// import 'package:myapp/home_page/counsellor_page/counsellor_details_screen.dart';
// import 'package:myapp/home_page/homepagecontainer.dart';
// import 'package:myapp/other/api_service.dart';
// import 'package:myapp/other/listcontroler.dart';
// import 'package:myapp/page-1/dashboard_session_page.dart';
// import 'package:myapp/utils.dart';
// import 'package:share_plus/share_plus.dart';
//
// class CounsellorListPage_offline extends StatefulWidget {
//   const CounsellorListPage_offline({super.key});
//
//   @override
//   State<CounsellorListPage_offline> createState() =>
//       _CounsellorListPage_offlineState();
// }
//
// class _CounsellorListPage_offlineState
//     extends State<CounsellorListPage_offline> {
//   final ListController listController = Get.put(ListController());
//
//   @override
//   void initState() {
//     super.initState();
//     ApiService.getCounsellorData();
//   }
//
//   Future<void> _refresh() {
//     return Future.delayed(const Duration(seconds: 1), () {
//       ApiService.getCounsellorData().then((value) {
//         if (value.isNotEmpty) {
//           setState(() {});
//         }
//         if (value[0].name == "none") {
//           EasyLoading.showToast("404 Page Not Found",
//               toastPosition: EasyLoadingToastPosition.bottom);
//         }
//         setState(() {});
//       });
//     });
//   }
//
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 460;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;
//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           color: Color(0xffffffff),
//         ),
//         child: Obx(
//               () => listController.isLoading.value
//               ? const Center(child: CircularProgressIndicator())
//               : Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 // group47BNR (730:3)
//                 margin: EdgeInsets.fromLTRB(
//                     0 * fem, 0 * fem, 0 * fem, 0.5 * fem),
//                 padding: EdgeInsets.fromLTRB(
//                     20 * fem, 60.79 * fem, 2 * fem, 12.40 * fem),
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                   const HomePageContainer()));
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.only(left: 10),
//                           child: Icon(
//                             Icons.arrow_back_ios,
//                             color: Color(0xff1f0a68),
//                             size: 25,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // counselor8BB (730:7)
//                       child: const Text(
//                         'Find Counsellors',
//                         style: TextStyle(
//                           color: Color(0xff1f0a68),
//                           fontSize: 18,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w600,
//                           height: 0,
//                         ),
//                       ),
//                     ),
//                     Spacer(),
//                     Expanded(
//                       child: Container(
//                         // layer2oHK (730:5)
//                         margin: EdgeInsets.fromLTRB(
//                             8 * fem, 0 * fem, 0 * fem, 0 * fem),
//                         width: 70.39 * fem,
//                         height: 25 * fem,
//                         child: Image.asset(
//                           'assets/page-1/images/layer-3.png',
//                           width: 26.39 * fem,
//                           height: 25 * fem,
//                           color: Color(0xff1f0a68),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: SizedBox(
//                   // autogroup13ehpiD (5rq67B26ka2aqeMhbB13eh)
//                   child: Stack(
//                     children: [
//                       RefreshIndicator(
//                         onRefresh: _refresh,
//                         child: SingleChildScrollView(
//                           physics: const AlwaysScrollableScrollPhysics(),
//                           child: Column(
//                             children: [
//                               Container(
//                                 // sliderhqs (742:104)
//                                 width: double.infinity,
//                                 height: 100.35 * fem,
//                                 margin: const EdgeInsets.only(
//                                     left: 18.0, top: 5.0),
//                                 child: Stack(
//                                   children: [
//                                     Positioned(
//                                       // groupRms (742:105)
//                                       left: 0 * fem,
//                                       top: 15.3145446777 * fem,
//                                       child: Align(
//                                           child: Container(
//                                             height: 60.5,
//                                             width: 330.5,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                               BorderRadius.circular(10),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   offset: const Offset(0, 1),
//                                                   blurRadius: 2,
//                                                   color: Colors.black
//                                                       .withOpacity(0.1),
//                                                 ),
//                                               ],
//                                             ),
//                                           )),
//                                     ),
//                                     Positioned(
//                                       left: 150 * fem,
//                                       bottom: 20 * fem,
//                                       child: Row(
//                                         children: [
//                                           TabPageSelectorIndicator(
//                                               backgroundColor:
//                                               selectedIndex == 0
//                                                   ? const Color(
//                                                   0xff1F0A68)
//                                                   : Colors.grey,
//                                               borderColor:
//                                               Colors.transparent,
//                                               size: 7),
//                                           TabPageSelectorIndicator(
//                                               backgroundColor:
//                                               selectedIndex == 1
//                                                   ? const Color(
//                                                   0xff1F0A68)
//                                                   : Colors.grey,
//                                               borderColor:
//                                               Colors.transparent,
//                                               size: 7),
//                                           TabPageSelectorIndicator(
//                                               backgroundColor:
//                                               selectedIndex == 2
//                                                   ? const Color(
//                                                   0xff1F0A68)
//                                                   : Colors.grey,
//                                               borderColor:
//                                               Colors.transparent,
//                                               size: 7)
//                                         ],
//                                       ),
//                                     ),
//                                     Positioned(
//                                       // whatentranceexaminationsshould (742:113)
//                                       left: 13.28515625 * fem,
//                                       top: 27.3145446777 * fem,
//                                       child: Align(
//                                         alignment: Alignment.topLeft,
//                                         child: SizedBox(
//                                           width: 245 * fem,
//                                           height: 40 * fem,
//                                           child: CarouselSlider(
//                                             items: [
//                                               Text(
//                                                 'Follow your favourite experts',
//                                                 style: SafeGoogleFont(
//                                                   'Inter',
//                                                   fontSize: 14 * ffem,
//                                                   fontWeight:
//                                                   FontWeight.w500,
//                                                   height: 1.3252271925 *
//                                                       ffem /
//                                                       fem,
//                                                   color: const Color(
//                                                       0xFF2A2F33),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "Attend popular workshops on various topics",
//                                                 textAlign: TextAlign.left,
//                                                 style: SafeGoogleFont(
//                                                   'Inter',
//                                                   fontSize: 14 * ffem,
//                                                   fontWeight:
//                                                   FontWeight.w500,
//                                                   height: 1.3252271925 *
//                                                       ffem /
//                                                       fem,
//                                                   color: const Color(
//                                                       0xFF2A2F33),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 'Confused about your career? Book a counsellor now!',
//                                                 style: SafeGoogleFont(
//                                                   'Inter',
//                                                   fontSize: 14 * ffem,
//                                                   fontWeight:
//                                                   FontWeight.w500,
//                                                   height: 1.3252271925 *
//                                                       ffem /
//                                                       fem,
//                                                   color: const Color(
//                                                       0xFF2A2F33),
//                                                 ),
//                                               ),
//                                             ],
//                                             options: CarouselOptions(
//                                                 onPageChanged:
//                                                     (index, reason) {
//                                                   setState(() {
//                                                     selectedIndex = index;
//                                                   });
//                                                 },
//                                                 viewportFraction: 1,
//                                                 autoPlay: true),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       // graduationhataoB (742:114)
//                                       left: 290.75 * fem,
//                                       top: 6 * fem,
//                                       bottom: 7,
//                                       child: Align(
//                                         child: SizedBox(
//                                           width: 88.5 * fem,
//                                           height: 120.5 * fem,
//                                           child: Image.asset(
//                                             'assets/page-1/images/graduation-hat.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               listController.cousnellorlist_data.isEmpty
//                                   ? Container(
//                                 // height: double.maxFinite,
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   // alignment: Alignment.bottomCenter,
//                                   children: [
//                                     SizedBox(
//                                       height:
//                                       MediaQuery.sizeOf(context)
//                                           .height /
//                                           3.5,
//                                     ),
//                                     const Text("Data not Found")
//                                   ],
//                                 ),
//                               )
//                                   : listController.cousnellorlist_data[0]
//                                   .name ==
//                                   "none"
//                                   ? const Center(
//                                 child: Text(
//                                     "Something went wrong!"),
//                               )
//                                   : GestureDetector(
//                                 onTap: (){
//                                   String id = listController.cousnellorlist_data[0].id;
//                                   String name = listController.cousnellorlist_data[0].name;
//
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => CounsellorDetailsScreen(id: id, name: name)));
//                                 },
//                                 child: Container(
//                                   color: Colors.white,
//                                   margin:
//                                   const EdgeInsets.fromLTRB(
//                                       0, 10, 0, 10),
//                                   child: RefreshIndicator(
//                                     onRefresh: () {
//                                       return Future<void>.delayed(
//                                           const Duration(
//                                               seconds: 2), () {
//                                         ApiService
//                                             .getCounsellorData();
//                                       });
//                                     },
//                                     child: ListView.builder(
//                                       padding: const EdgeInsets
//                                           .symmetric(
//                                           horizontal: 10),
//                                       itemCount: listController
//                                           .cousnellorlist_data
//                                           .length,
//                                       physics:
//                                       const BouncingScrollPhysics(),
//                                       shrinkWrap: true,
//                                       primary: false,
//                                       itemBuilder:
//                                           (context, index) {
//                                         return Row(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment
//                                               .end,
//                                           children: [
//                                             Container(
//                                               // group25Cyf (730:13)
//                                               margin: EdgeInsets
//                                                   .fromLTRB(
//                                                   20 * fem,
//                                                   10 * fem,
//                                                   10 * fem,
//                                                   10.73 *
//                                                       fem),
//                                               width: 400 * fem,
//                                               height: 280 * fem,
//                                               decoration:
//                                               BoxDecoration(
//                                                 color: const Color(
//                                                     0xfff7f4ff),
//                                                 borderRadius:
//                                                 BorderRadius
//                                                     .circular(
//                                                     7 * fem),
//                                               ),
//                                               child: Stack(
//                                                 children: [
//                                                   Positioned(
//                                                     // group24uNH (730:15)
//                                                     left:
//                                                     10 * fem,
//                                                     child:
//                                                     SizedBox(
//                                                       width: 370 *
//                                                           fem,
//                                                       height:
//                                                       320.1 *
//                                                           fem,
//                                                       child:
//                                                       Stack(
//                                                         children: [
//                                                           Positioned(
//                                                             // rectangle101cGh (730:16)
//                                                             left: 10 *
//                                                                 fem,
//                                                             top: 3.4286193848 *
//                                                                 fem,
//                                                             child:
//                                                             Align(
//                                                               child:
//                                                               SizedBox(
//                                                                 width: 95 * fem,
//                                                                 height: 104 * fem,
//                                                                 child: ClipRRect(
//                                                                   borderRadius: BorderRadius.circular(75 * fem),
//                                                                   child: Image.network(
//                                                                     listController.cousnellorlist_data[index].profilePic,
//                                                                     fit: BoxFit.cover,
//                                                                     errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                                                                       //print("Exception >> ${exception.toString()}");
//                                                                       return Image.asset('assets/page-1/images/comming_soon.png',fit: BoxFit.cover,);
//                                                                     },
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Positioned(
//                                                             // group15tk1 (730:17)
//                                                             left: 123 *
//                                                                 fem,
//                                                             top: 70.4285888672 *
//                                                                 fem,
//                                                             child:
//                                                             Container(
//                                                               width:
//                                                               52 * fem,
//                                                               height:
//                                                               18 * fem,
//                                                               decoration:
//                                                               BoxDecoration(
//                                                                 color: const Color(0xff1f0a68),
//                                                                 borderRadius: BorderRadius.circular(3 * fem),
//                                                               ),
//                                                               child:
//                                                               Center(
//                                                                 child: Text(
//                                                                   "N/A",
//                                                                   style: SafeGoogleFont(
//                                                                     'Inter',
//                                                                     fontSize: 11 * ffem,
//                                                                     fontWeight: FontWeight.w700,
//                                                                     height: 0,
//                                                                     color: const Color(0xffffffff),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Positioned(
//                                                             // group25kfj (730:23)
//                                                             left: 180 *
//                                                                 fem,
//                                                             top: 70.4285888672 *
//                                                                 fem,
//                                                             child:
//                                                             Container(
//                                                               width:
//                                                               29.74 * fem,
//                                                               height:
//                                                               18 * fem,
//                                                               decoration:
//                                                               BoxDecoration(
//                                                                 color: const Color(0xff1f0a68),
//                                                                 borderRadius: BorderRadius.circular(3 * fem),
//                                                               ),
//                                                               child:
//                                                               Center(
//                                                                 child: Text(
//                                                                   'N/A',
//                                                                   style: SafeGoogleFont(
//                                                                     'Inter',
//                                                                     fontSize: 12 * ffem,
//                                                                     fontWeight: FontWeight.w700,
//                                                                     height: 1.2125 * ffem / fem,
//                                                                     color: const Color(0xffffffff),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Positioned(
//                                                             child:
//                                                             SizedBox(
//                                                               width:
//                                                               370 * fem,
//                                                               height:
//                                                               270.1 * fem,
//                                                               child:
//                                                               Stack(
//                                                                 children: [
//                                                                   Positioned(
//                                                                     // rectangle107TMB (730:30)
//                                                                     left: 0 * fem,
//                                                                     top: 115.0888214111 * fem,
//                                                                     child: Align(
//                                                                       child: SizedBox(
//                                                                         width: 370 * fem,
//                                                                         height: 182.01 * fem,
//                                                                         child: Container(
//                                                                           decoration: BoxDecoration(
//                                                                             borderRadius: BorderRadius.circular(10 * fem),
//                                                                             color: const Color(0xffffffff),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Positioned(
//                                                                     // group22y4d (730:31)
//                                                                     left: 11.2578125 * fem,
//                                                                     top: 0 * fem,
//                                                                     child: SizedBox(
//                                                                       width: 355.39 * fem,
//                                                                       height: 200.43 * fem,
//                                                                       child: Column(
//                                                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                                                         children: [
//                                                                           Container(
//                                                                             // autogroupi45wHb7 (5rq74tvFbZcGmqkUCBi45w)
//                                                                             margin: EdgeInsets.fromLTRB(111.74 * fem, 0 * fem, 4.07 * fem, 32.92 * fem),
//                                                                             width: double.infinity,
//                                                                             child: Row(
//                                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                                                               children: [
//                                                                                 Container(
//                                                                                   // group18PPF (730:36)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 14.43 * fem, 0, 0 * fem),
//                                                                                   child: Column(
//                                                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                     children: [
//                                                                                       Container(
//                                                                                         // anshikamehrausP (730:37)
//                                                                                         margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4.25 * fem),
//                                                                                         child: Text(
//                                                                                           "${listController.cousnellorlist_data[index].name} ",
//                                                                                           style: SafeGoogleFont(
//                                                                                             'Inter',
//                                                                                             fontSize: 22 * ffem,
//                                                                                             fontWeight: FontWeight.w700,
//                                                                                             height: 1.2125 * ffem / fem,
//                                                                                             color: const Color(0xFF41403F),
//                                                                                           ),
//                                                                                         ),
//                                                                                       ),
//                                                                                       Text(
//                                                                                         // productdesignerwepitchd2h (730:38)
//                                                                                         "N/A",
//                                                                                         style: SafeGoogleFont(
//                                                                                           'Inter',
//                                                                                           fontSize: 12 * ffem,
//                                                                                           fontWeight: FontWeight.w400,
//                                                                                           height: 1.2125 * ffem / fem,
//                                                                                           color: const Color(0xff696969),
//                                                                                         ),
//                                                                                       ),
//                                                                                     ],
//                                                                                   ),
//                                                                                 ),
//                                                                                 GestureDetector(
//                                                                                   onTap: (){
//                                                                                     Share.share('https://play.google.com/store/apps/details?id=com.sortmycollege');
//                                                                                   },
//                                                                                   child: Container(
//                                                                                     margin: const EdgeInsets.fromLTRB(0, 14, 0, 0),
//                                                                                     // group38MUV (730:32)
//                                                                                     width: 17.42 * fem,
//                                                                                     height: 18.86 * fem,
//                                                                                     child: Image.asset(
//                                                                                       'assets/page-1/images/group-38-oFX.png',
//                                                                                       width: 17.42 * fem,
//                                                                                       height: 18.86 * fem,
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                           Container(
//                                                                             // autogroupgljmgWm (5rq7GDviByH7TzJqkBgLJM)
//                                                                             margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 3.3 * fem),
//                                                                           ),
//                                                                           Container(
//                                                                             // autogrouprcmfMPw (5rq7T8nCN5sYC595gTrcmf)
//                                                                             margin: EdgeInsets.fromLTRB(30.79 * fem, 0 * fem, 0 * fem, 8.5 * fem),
//                                                                             width: double.infinity,
//                                                                             child: Row(
//                                                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                                                               children: [
//                                                                                 Container(
//                                                                                   // clockcircularoutlineQuw (730:55)
//                                                                                   margin: EdgeInsets.fromLTRB(80 * fem, 1.26 * fem, 4.13 * fem, 0 * fem),
//                                                                                   width: 10.41 * fem,
//                                                                                   height: 10.41 * fem,
//                                                                                   child: Image.asset(
//                                                                                     'assets/page-1/images/clock-circular-outline-Ra1.png',
//                                                                                     fit: BoxFit.cover,
//                                                                                   ),
//                                                                                 ),
//                                                                                 Container(
//                                                                                   // nextsessionat800pm8L9 (730:73)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 51.8 * fem, 0 * fem),
//                                                                                   child: Text(
//                                                                                     'N/A',
//                                                                                     textAlign: TextAlign.center,
//                                                                                     style: SafeGoogleFont(
//                                                                                       'Inter',
//                                                                                       fontSize: 12 * ffem,
//                                                                                       fontWeight: FontWeight.w500,
//                                                                                       height: 1 * ffem / fem,
//                                                                                       color: const Color(0xff414040),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 Container(
//                                                                                   // starpim (730:70)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2.34 * fem, 0 * fem),
//                                                                                   width: 10 * fem,
//                                                                                   height: 10 * fem,
//                                                                                   child: Image.asset(
//                                                                                     'assets/page-1/images/star.png',
//                                                                                     fit: BoxFit.cover,
//                                                                                   ),
//                                                                                 ),
//                                                                                 Text(
//                                                                                   // 9W9 (730:71)
//                                                                                   '${listController.cousnellorlist_data[index].averageRating}',
//                                                                                   textAlign: TextAlign.center,
//                                                                                   style: SafeGoogleFont(
//                                                                                     'Inter',
//                                                                                     fontSize: 9 * ffem,
//                                                                                     fontWeight: FontWeight.w700,
//                                                                                     height: 1 * ffem / fem,
//                                                                                     color: const Color(0xff000000),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                           //updated
//                                                                           Container(
//                                                                             // group1324p9 (730:74)
//                                                                             margin: EdgeInsets.fromLTRB(0 * fem, 3.5 * fem, 3.29 * fem, 0 * fem),
//                                                                             height: 35 * fem,
//                                                                             child: Row(
//                                                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                                                               children: [
//                                                                                 GestureDetector(
//                                                                                   onTap: () {
//                                                                                     String id = listController.cousnellorlist_data[index].id;
//                                                                                     String name = listController.cousnellorlist_data[index].name;
//                                                                                     Navigator.push(
//                                                                                         context,
//                                                                                         MaterialPageRoute(
//                                                                                             builder: (context) => CounsellorDetailsScreen(id: id, name: name)));
//                                                                                   },
//                                                                                   child: SizedBox(
//                                                                                     width: 130.85,
//                                                                                     height: 25.09,
//                                                                                     child: Stack(
//                                                                                       children: [
//                                                                                         Positioned(
//                                                                                           child: Container(
//                                                                                             width: 130.85,
//                                                                                             height: 25.09,
//                                                                                             decoration: ShapeDecoration(
//                                                                                               color: Colors.white,
//                                                                                               shape: RoundedRectangleBorder(
//                                                                                                 side: BorderSide(
//                                                                                                   width: 0.50,
//                                                                                                   color: Colors.black.withOpacity(0.7400000095367432),
//                                                                                                 ),
//                                                                                                 borderRadius: BorderRadius.circular(16),
//                                                                                               ),
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                         const Positioned(
//                                                                                           left: 5.45,
//                                                                                           top: 13,
//                                                                                           child: SizedBox(
//                                                                                             width: 123.01,
//                                                                                             height: 16.05,
//                                                                                             child: Text(
//                                                                                               'Visit Profile',
//                                                                                               textAlign: TextAlign.center,
//                                                                                               style: TextStyle(
//                                                                                                 color: Color(0xFF262626),
//                                                                                                 fontSize: 14,
//                                                                                                 fontFamily: 'Inter',
//                                                                                                 fontWeight: FontWeight.w700,
//                                                                                                 height: 0.07,
//                                                                                               ),
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                       ],
//                                                                                     ),
//                                                                                   ),
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Positioned(
//                                                                     // group127Yc9 (730:56)
//                                                                     left: 15.095703125 * fem,
//                                                                     top: 170.1729736328 * fem,
//                                                                     child: SizedBox(
//                                                                       width: 330.19 * fem,
//                                                                       height: 41.88 * fem,
//                                                                       child: Row(
//                                                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                                                         children: [
//                                                                           Container(
//                                                                             // autogroupxdarfqB (5rq95AuqkATF4BMvwmXDaR)
//                                                                             margin: EdgeInsets.fromLTRB(0 * fem, 1.35 * fem, 23.41 * fem, 3.21 * fem),
//                                                                             height: double.infinity,
//                                                                             child: Column(
//                                                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                                                               children: [
//                                                                                 Container(
//                                                                                   // experiencezMf (730:57)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 3.33 * fem),
//                                                                                   child: Text(
//                                                                                     'Experience',
//                                                                                     style: SafeGoogleFont(
//                                                                                       'Inter',
//                                                                                       fontSize: 11 * ffem,
//                                                                                       fontWeight: FontWeight.w500,
//                                                                                       height: 1.2125 * ffem / fem,
//                                                                                       color: const Color(0xFF8D8888),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 Container(
//                                                                                   // yrsthw (730:61)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 3 * fem, 1.34 * fem, 0 * fem),
//                                                                                   child: Text(
//                                                                                     "${listController.cousnellorlist_data[index].experienceInYears}"
//                                                                                         " year",
//                                                                                     style: SafeGoogleFont(
//                                                                                       'Inter',
//                                                                                       fontSize: 13 * ffem,
//                                                                                       fontWeight: FontWeight.w700,
//                                                                                       height: 1.2125 * ffem / fem,
//                                                                                       color: const Color(0xff000000),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                           Container(
//                                                                             // zFB (730:65)
//                                                                             margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 19.05 * fem, 0.81 * fem),
//                                                                             constraints: BoxConstraints(
//                                                                               maxWidth: 3 * fem,
//                                                                             ),
//                                                                             child: Text(
//                                                                               '.\n.\n.\n.\n.\n.\n.\n.\n.',
//                                                                               textAlign: TextAlign.center,
//                                                                               style: SafeGoogleFont(
//                                                                                 'Inter',
//                                                                                 fontSize: 9 * ffem,
//                                                                                 fontWeight: FontWeight.w400,
//                                                                                 height: 0.4849999746 * ffem / fem,
//                                                                                 color: const Color(0xff9a9898),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Container(
//                                                                             // autogroupmychGyP (5rq9BvDbjLHY7cvriqmYch)
//                                                                             margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 23.67 * fem, 1.09 * fem),
//                                                                             child: Column(
//                                                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                                                               children: [
//                                                                                 Container(
//                                                                                   // sessionPo7 (730:59)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 5.45 * fem),
//                                                                                   child: Text(
//                                                                                     'Session',
//                                                                                     style: SafeGoogleFont(
//                                                                                       'Inter',
//                                                                                       fontSize: 11 * ffem,
//                                                                                       fontWeight: FontWeight.w500,
//                                                                                       height: 1.2125 * ffem / fem,
//                                                                                       color: const Color(0xff8d8888),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 Container(
//                                                                                   // JfB (730:62)
//                                                                                   margin: EdgeInsets.fromLTRB(2.42 * fem, 3 * fem, 0 * fem, 0 * fem),
//                                                                                   child: Text(
//                                                                                     '${listController.cousnellorlist_data[index].totalSessions}',
//                                                                                     style: SafeGoogleFont(
//                                                                                       'Inter',
//                                                                                       fontSize: 13 * ffem,
//                                                                                       fontWeight: FontWeight.w700,
//                                                                                       height: 1.2125 * ffem / fem,
//                                                                                       color: const Color(0xff000000),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                           Container(
//                                                                             // CkZ (730:66)
//                                                                             margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 26.73 * fem, 0.95 * fem),
//                                                                             constraints: BoxConstraints(
//                                                                               maxWidth: 3 * fem,
//                                                                             ),
//                                                                             child: Text(
//                                                                               '.\n.\n.\n.\n.\n.\n.\n.\n.',
//                                                                               textAlign: TextAlign.center,
//                                                                               style: SafeGoogleFont(
//                                                                                 'Inter',
//                                                                                 fontSize: 9 * ffem,
//                                                                                 fontWeight: FontWeight.w400,
//                                                                                 height: 0.4849999746 * ffem / fem,
//                                                                                 color: const Color(0xff9a9898),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Container(
//                                                                             // autogroupkgiuUTB (5rq9Haiq2Y7xThD3Vqkgiu)
//                                                                             margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 17.6 * fem, 0 * fem),
//                                                                             child: Column(
//                                                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                                                               children: [
//                                                                                 Container(
//                                                                                   // rewardsNoT (730:60)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 6.53 * fem),
//                                                                                   child: Text(
//                                                                                     'Rewards',
//                                                                                     style: SafeGoogleFont(
//                                                                                       'Inter',
//                                                                                       fontSize: 11 * ffem,
//                                                                                       fontWeight: FontWeight.w500,
//                                                                                       height: 1.2125 * ffem / fem,
//                                                                                       color: const Color(0xff8d8888),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 Container(
//                                                                                   // sVK (730:63)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 3 * fem, 3.09 * fem, 0 * fem),
//                                                                                   child: Text(
//                                                                                     " ${listController.cousnellorlist_data[index].rewardPoints} +",
//                                                                                     style: SafeGoogleFont(
//                                                                                       'Inter',
//                                                                                       fontSize: 13 * ffem,
//                                                                                       fontWeight: FontWeight.w700,
//                                                                                       height: 1.2125 * ffem / fem,
//                                                                                       color: const Color(0xff000000),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                           Container(
//                                                                             // BW1 (730:67)
//                                                                             margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 16.73 * fem, 1.88 * fem),
//                                                                             constraints: BoxConstraints(
//                                                                               maxWidth: 3 * fem,
//                                                                             ),
//                                                                             child: Text(
//                                                                               '.\n.\n.\n.\n.\n.\n.\n.\n.',
//                                                                               textAlign: TextAlign.center,
//                                                                               style: SafeGoogleFont(
//                                                                                 'Inter',
//                                                                                 fontSize: 9 * ffem,
//                                                                                 fontWeight: FontWeight.w400,
//                                                                                 height: 0.4849999746 * ffem / fem,
//                                                                                 color: const Color(0xff9a9898),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Container(
//                                                                             // autogroupjpq7GnM (5rq9PFE4KjxNomVEGqjpq7)
//                                                                             child: Column(
//                                                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                                                               children: [
//                                                                                 Container(
//                                                                                   // reviewsRQM (730:58)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 6.53 * fem),
//                                                                                   child: Text(
//                                                                                     'Reviews',
//                                                                                     style: SafeGoogleFont(
//                                                                                       'Inter',
//                                                                                       fontSize: 11 * ffem,
//                                                                                       fontWeight: FontWeight.w500,
//                                                                                       height: 1.2125 * ffem / fem,
//                                                                                       color: const Color(0xff8d8888),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 Container(
//                                                                                   // kfT7 (730:64)
//                                                                                   margin: EdgeInsets.fromLTRB(0 * fem, 3 * fem, 4.34 * fem, 0 * fem),
//                                                                                   child: Text(
//                                                                                     '${listController.cousnellorlist_data[index].reviews}',
//                                                                                     style: SafeGoogleFont(
//                                                                                       'Inter',
//                                                                                       fontSize: 13 * ffem,
//                                                                                       fontWeight: FontWeight.w700,
//                                                                                       height: 1.2125 * ffem / fem,
//                                                                                       color: const Color(0xff000000),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Positioned(
//                                                     // rectangle202WCq (782:2)
//                                                     left:
//                                                     10 * fem,
//                                                     top:
//                                                     220.5815429688 *
//                                                         fem,
//                                                     child: Align(
//                                                       child:
//                                                       SizedBox(
//                                                         width: 370 *
//                                                             fem,
//                                                         height:
//                                                         51.5 *
//                                                             fem,
//                                                         child:
//                                                         Container(
//                                                           decoration:
//                                                           BoxDecoration(
//                                                             color:
//                                                             const Color(0xffe1e0e0),
//                                                             borderRadius:
//                                                             BorderRadius.only(
//                                                               bottomRight:
//                                                               Radius.circular(10 * fem),
//                                                               bottomLeft:
//                                                               Radius.circular(10 * fem),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Positioned(
//                                                     // booknownAM (730:83)
//                                                     left:
//                                                     146.9609375 *
//                                                         fem,
//                                                     top:
//                                                     240.3315429688 *
//                                                         fem,
//                                                     child: Align(
//                                                       child:
//                                                       SizedBox(
//                                                         width: 91 *
//                                                             fem,
//                                                         height: 20 *
//                                                             fem,
//                                                         child:
//                                                         GestureDetector(
//                                                           onTap:
//                                                               () {
//                                                             onTapgotocounsellor(
//                                                                 context,
//                                                                 id: listController.cousnellorlist_data[index].id,
//                                                                 name: listController.cousnellorlist_data[index].name);
//                                                           },
//                                                           child:
//                                                           Text(
//                                                             'BOOK NOW',
//                                                             style:
//                                                             SafeGoogleFont(
//                                                               'Inter',
//                                                               fontSize:
//                                                               16 * ffem,
//                                                               fontWeight:
//                                                               FontWeight.w600,
//                                                               height: 1.2125 *
//                                                                   ffem /
//                                                                   fem,
//                                                               color:
//                                                               const Color(0xff262626),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void onTapgotocounsellor(BuildContext context,
//       {required String name, required String id}) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => CounsellingSessionPage(name: name, id: id)));
//   }
//
//   Future<bool> _onBackPressed() async {
//     Navigator.pushReplacement(context,
//         MaterialPageRoute(builder: (context) => const HomePageContainer()));
//     return true;
//   }
// }
