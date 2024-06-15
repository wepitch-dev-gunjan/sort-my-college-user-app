import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:myapp/home_page/counsellor_page/counsellor_details_screen.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/other/listcontroler.dart';
import 'package:myapp/page-1/dashboard_session_page.dart';
import 'package:myapp/utils.dart';
import 'package:share_plus/share_plus.dart';

class CounsellorListPage_offline extends StatefulWidget {
  const CounsellorListPage_offline({super.key});

  @override
  State<CounsellorListPage_offline> createState() =>
      _CounsellorListPage_offlineState();
}

class _CounsellorListPage_offlineState
    extends State<CounsellorListPage_offline> {
  final ListController listController = Get.put(ListController());

  bool isCounsellorsLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchCounsellorData();
  }

  Future<void> _fetchCounsellorData() async {
    setState(() {
      isCounsellorsLoading = true;
    });

    try {
      var value = await ApiService.getCounsellorData();
      if (value.isNotEmpty) {
        listController.cousnellorlist_data = value;
      }
    } catch (error) {
      EasyLoading.showToast("Error fetching data",
          toastPosition: EasyLoadingToastPosition.bottom);
    } finally {
      setState(() {
        isCounsellorsLoading = false;
      });
    }
  }

  Future<void> _refresh() async {
    await _fetchCounsellorData();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: isCounsellorsLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 0.5 * fem),
                    padding: EdgeInsets.fromLTRB(
                        20 * fem, 60.79 * fem, 2 * fem, 12.40 * fem),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomePageContainer()));
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff1f0a68),
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          'Find Counsellors',
                          style: TextStyle(
                            color: Color(0xff1f0a68),
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Stack(
                        children: [
                          RefreshIndicator(
                            onRefresh: _refresh,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    // color: Colors.red,
                                    width: double.infinity,
                                    height: 100.35 * fem,
                                    // margin: const EdgeInsets.only(
                                    // left: 18.0, top: 5.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                20,
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // left: 0 * fem,
                                            // top: 15.3145446777 * fem,
                                            child: Align(
                                                child: Container(
                                              height: 60.5,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: const Offset(0, 1),
                                                    blurRadius: 2,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                          Positioned(
                                            left: 150 * fem,
                                            bottom: 20 * fem,
                                            child: Row(
                                              children: [
                                                for (int i = 0; i < 3; i++)
                                                  TabPageSelectorIndicator(
                                                    backgroundColor:
                                                        selectedIndex == i
                                                            ? const Color(
                                                                0xff1F0A68)
                                                            : Colors.grey,
                                                    borderColor:
                                                        Colors.transparent,
                                                    size: 7,
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            left: 13.28515625 * fem,
                                            top: 27.3145446777 * fem,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: SizedBox(
                                                width: 245 * fem,
                                                height: 40 * fem,
                                                child: CarouselSlider(
                                                  items: [
                                                    Text(
                                                      'Follow your favourite experts',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 14 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.3252271925 *
                                                            ffem /
                                                            fem,
                                                        color: const Color(
                                                            0xFF2A2F33),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Attend popular workshops on various topics",
                                                      textAlign: TextAlign.left,
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 14 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.3252271925 *
                                                            ffem /
                                                            fem,
                                                        color: const Color(
                                                            0xFF2A2F33),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Confused about your career? Book a counsellor now!',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 14 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.3252271925 *
                                                            ffem /
                                                            fem,
                                                        color: const Color(
                                                            0xFF2A2F33),
                                                      ),
                                                    ),
                                                  ],
                                                  options: CarouselOptions(
                                                      onPageChanged:
                                                          (index, reason) {
                                                        setState(() {
                                                          selectedIndex = index;
                                                        });
                                                      },
                                                      viewportFraction: 1,
                                                      autoPlay: true),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 290.75 * fem,
                                            top: 10 * fem,
                                            bottom: 10,
                                            child: Align(
                                              child: SizedBox(
                                                width: 100.5 * fem,
                                                height: 128.5 * fem,
                                                child: Image.asset(
                                                  'assets/page-1/images/graduation-hat.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  listController.cousnellorlist_data.isEmpty
                                      ? Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // alignment: Alignment.bottomCenter,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height /
                                                  3.5,
                                            ),
                                            const Text("Data not Found")
                                          ],
                                        )
                                      : listController.cousnellorlist_data[0]
                                                  .name ==
                                              "none"
                                          ? const Center(
                                              child:
                                                  Text("Something went wrong!"),
                                            )

//=====================================! Counsellors Card !=======================================

                                          : Container(
                                              // color: Colors.red,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: RefreshIndicator(
                                                onRefresh: () {
                                                  return Future<void>.delayed(
                                                      const Duration(
                                                          seconds: 2), () {
                                                    ApiService
                                                        .getCounsellorData();
                                                  });
                                                },
                                                child: ListView.builder(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 14,
                                                  ),
                                                  itemCount: listController
                                                      .cousnellorlist_data
                                                      .length,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var coursesFocused =
                                                        listController
                                                                .cousnellorlist_data[
                                                                    index]
                                                                .coursesFocused ??
                                                            [];
                                                    return Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Card(
                                                          elevation: 2,
                                                          // color: Colors.red,
                                                          color: const Color(
                                                              0xffffffff),
                                                          surfaceTintColor:
                                                              const Color(
                                                                  0xffffffff),
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                              10 * fem,
                                                              10 * fem,
                                                              10 * fem,
                                                              10.73 * fem,
                                                            ),
                                                            width: 390 * fem,
                                                            height: 224 * fem,
                                                            decoration:
                                                                BoxDecoration(
                                                              // color:
                                                              //     Colors.red,
                                                              color: const Color(
                                                                  0xffffffff),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                7 * fem,
                                                              ),
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  // group24uNH (730:15)
                                                                  left:
                                                                      10 * fem,
                                                                  child:
                                                                      SizedBox(
                                                                    width: 370 *
                                                                        fem,
                                                                    height:
                                                                        320.1 *
                                                                            fem,
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          // rectangle101cGh (730:16)
                                                                          left: 10 *
                                                                              fem,
                                                                          top: 3.4286193848 *
                                                                              fem,
                                                                          child:
                                                                              Align(
                                                                            child:
                                                                                SizedBox(
                                                                              width: 95 * fem,
                                                                              height: 104 * fem,
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(75 * fem),
                                                                                child: Image.network(
                                                                                  listController.cousnellorlist_data[index].profilePic,
                                                                                  fit: BoxFit.cover,
                                                                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                                    //print("Exception >> ${exception.toString()}");
                                                                                    return Image.asset(
                                                                                      'assets/page-1/images/comming_soon.png',
                                                                                      fit: BoxFit.cover,
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          left: 123 *
                                                                              fem,
                                                                          top: 70.4285888672 *
                                                                              fem,
                                                                          right:
                                                                              1 * fem,
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Row(
                                                                                children: coursesFocused.isNotEmpty
                                                                                    ? List.generate(
                                                                                        coursesFocused.length,
                                                                                        (index) => Container(
                                                                                          margin: const EdgeInsets.only(right: 5.0),
                                                                                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                                                                          height: 18 * fem,
                                                                                          decoration: BoxDecoration(
                                                                                            color: const Color(0xff1f0a68),
                                                                                            borderRadius: BorderRadius.circular(3 * fem),
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              coursesFocused[index],
                                                                                              style: SafeGoogleFont(
                                                                                                'Inter',
                                                                                                fontSize: 11 * ffem,
                                                                                                fontWeight: FontWeight.w700,
                                                                                                height: 1.0,
                                                                                                color: const Color(0xffffffff),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : [
                                                                                        Container(
                                                                                          margin: const EdgeInsets.only(right: 5.0),
                                                                                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                                                                          height: 18 * fem,
                                                                                          decoration: BoxDecoration(
                                                                                            color: const Color(0xff1f0a68),
                                                                                            borderRadius: BorderRadius.circular(3 * fem),
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              'N/A',
                                                                                              style: SafeGoogleFont(
                                                                                                'Inter',
                                                                                                fontSize: 11 * ffem,
                                                                                                fontWeight: FontWeight.w700,
                                                                                                height: 1.0,
                                                                                                color: const Color(0xffffffff),
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
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                370 * fem,
                                                                            height:
                                                                                270.1 * fem,
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                Positioned(
                                                                                  left: 11.2578125 * fem,
                                                                                  top: 0 * fem,
                                                                                  child: SizedBox(
                                                                                    width: 355.39 * fem,
                                                                                    height: 200.43 * fem,
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                                      children: [
                                                                                        Container(
                                                                                          margin: EdgeInsets.fromLTRB(111.74 * fem, 0 * fem, 4.07 * fem, 32.92 * fem),
                                                                                          width: double.infinity,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                margin: EdgeInsets.fromLTRB(0 * fem, 14.43 * fem, 0, 0 * fem),
                                                                                                child: Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Container(
                                                                                                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4.25 * fem),
                                                                                                      child: Text(
                                                                                                        "${listController.cousnellorlist_data[index].name} ",
                                                                                                        style: SafeGoogleFont(
                                                                                                          'Inter',
                                                                                                          fontSize: 22 * ffem,
                                                                                                          fontWeight: FontWeight.w700,
                                                                                                          height: 1.2125 * ffem / fem,
                                                                                                          color: const Color(0xFF41403F),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      listController.cousnellorlist_data[index].designation,
                                                                                                      style: SafeGoogleFont(
                                                                                                        'Inter',
                                                                                                        fontSize: 12 * ffem,
                                                                                                        fontWeight: FontWeight.w400,
                                                                                                        height: 1.2125 * ffem / fem,
                                                                                                        color: const Color(0xff696969),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                  if (Platform.isIOS) {
                                                                                                    Share.share('https://apps.apple.com/in/app/sort-my-college/id6480402447');
                                                                                                  } else if (Platform.isAndroid) {
                                                                                                    Share.share('https://play.google.com/store/apps/details?id=com.sortmycollege');
                                                                                                  } else {
                                                                                                    throw 'Platform not supported';
                                                                                                  }
                                                                                                },
                                                                                                child: Container(
                                                                                                  margin: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                                                                                                  width: 17.42 * fem,
                                                                                                  height: 18.86 * fem,
                                                                                                  child: Image.asset(
                                                                                                    'assets/page-1/images/group-38-oFX.png',
                                                                                                    width: 17.42 * fem,
                                                                                                    height: 18.86 * fem,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 3.3 * fem),
                                                                                        ),

////================================================================================================================! Rating ! ============================================================================

                                                                                        Container(
                                                                                          margin: EdgeInsets.fromLTRB(30.79 * fem, 0 * fem, 0 * fem, 8.5 * fem),
                                                                                          width: double.infinity,
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                margin: EdgeInsets.fromLTRB(80 * fem, 1.26 * fem, 4.13 * fem, 0 * fem),
                                                                                                width: 10.41 * fem,
                                                                                                height: 10.41 * fem,
                                                                                                child: Image.asset(
                                                                                                  'assets/page-1/images/clock-circular-outline-Ra1.png',
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                listController.cousnellorlist_data[index].nextSession,
                                                                                                textAlign: TextAlign.center,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                style: SafeGoogleFont(
                                                                                                  'Inter',
                                                                                                  fontSize: 12 * ffem,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  height: 1 * ffem / fem,
                                                                                                  color: const Color(0xff414040),
                                                                                                ),
                                                                                              ),
                                                                                              const Spacer(),
                                                                                              Image.asset(
                                                                                                height: 8,
                                                                                                width: 8,
                                                                                                'assets/page-1/images/star.png',
                                                                                                fit: BoxFit.cover,
                                                                                              ),
                                                                                              const SizedBox(width: 2),
                                                                                              Text(
                                                                                                listController.cousnellorlist_data[index].averageRating,
                                                                                                textAlign: TextAlign.center,
                                                                                                style: SafeGoogleFont(
                                                                                                  'Inter',
                                                                                                  fontSize: 9 * ffem,
                                                                                                  fontWeight: FontWeight.w700,
                                                                                                  height: 1 * ffem / fem,
                                                                                                  color: const Color(0xff000000),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),

//============================================================================! Btns Upper Part ! =========================================================

                                                                                Positioned(
                                                                                  left: 15.095703125 * fem,
                                                                                  top: 120.1729736328 * fem,
                                                                                  child: SizedBox(
                                                                                    width: 330.19 * fem,
                                                                                    height: 41.88 * fem,
                                                                                    child: Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                                      children: [
                                                                                        Container(
                                                                                          margin: EdgeInsets.fromLTRB(0 * fem, 1.35 * fem, 23.41 * fem, 3.21 * fem),
                                                                                          height: double.infinity,
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 3.33 * fem),
                                                                                                child: Text(
                                                                                                  'Experience',
                                                                                                  style: SafeGoogleFont(
                                                                                                    'Inter',
                                                                                                    fontSize: 11 * ffem,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    height: 1.2125 * ffem / fem,
                                                                                                    color: const Color(0xFF8D8888),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Container(
                                                                                                margin: EdgeInsets.fromLTRB(0 * fem, 3 * fem, 1.34 * fem, 0 * fem),
                                                                                                child: Text(
                                                                                                  "${listController.cousnellorlist_data[index].experienceInYears}"
                                                                                                  " year",
                                                                                                  style: SafeGoogleFont(
                                                                                                    'Inter',
                                                                                                    fontSize: 13 * ffem,
                                                                                                    fontWeight: FontWeight.w700,
                                                                                                    height: 1.2125 * ffem / fem,
                                                                                                    color: const Color(0xff000000),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 19.05 * fem, 0.81 * fem),
                                                                                          constraints: BoxConstraints(
                                                                                            maxWidth: 3 * fem,
                                                                                          ),
                                                                                          child: Text(
                                                                                            '.\n.\n.\n.\n.\n.\n.\n.\n.',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: SafeGoogleFont(
                                                                                              'Inter',
                                                                                              fontSize: 9 * ffem,
                                                                                              fontWeight: FontWeight.w400,
                                                                                              height: 0.4849999746 * ffem / fem,
                                                                                              color: const Color(0xff9a9898),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 23.67 * fem, 1.09 * fem),
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 5.45 * fem),
                                                                                                child: Text(
                                                                                                  'Session',
                                                                                                  style: SafeGoogleFont(
                                                                                                    'Inter',
                                                                                                    fontSize: 11 * ffem,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    height: 1.2125 * ffem / fem,
                                                                                                    color: const Color(0xff8d8888),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Container(
                                                                                                margin: EdgeInsets.fromLTRB(2.42 * fem, 3 * fem, 0 * fem, 0 * fem),
                                                                                                child: Text(
                                                                                                  '${listController.cousnellorlist_data[index].totalSessions}',
                                                                                                  style: SafeGoogleFont(
                                                                                                    'Inter',
                                                                                                    fontSize: 13 * ffem,
                                                                                                    fontWeight: FontWeight.w700,
                                                                                                    height: 1.2125 * ffem / fem,
                                                                                                    color: const Color(0xff000000),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 26.73 * fem, 0.95 * fem),
                                                                                          constraints: BoxConstraints(
                                                                                            maxWidth: 3 * fem,
                                                                                          ),
                                                                                          child: Text(
                                                                                            '.\n.\n.\n.\n.\n.\n.\n.\n.',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: SafeGoogleFont(
                                                                                              'Inter',
                                                                                              fontSize: 9 * ffem,
                                                                                              fontWeight: FontWeight.w400,
                                                                                              height: 0.4849999746 * ffem / fem,
                                                                                              color: const Color(0xff9a9898),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 17.6 * fem, 0 * fem),
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 6.53 * fem),
                                                                                                child: Text(
                                                                                                  'Rewards',
                                                                                                  style: SafeGoogleFont(
                                                                                                    'Inter',
                                                                                                    fontSize: 11 * ffem,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    height: 1.2125 * ffem / fem,
                                                                                                    color: const Color(0xff8d8888),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Container(
                                                                                                margin: EdgeInsets.fromLTRB(0 * fem, 3 * fem, 3.09 * fem, 0 * fem),
                                                                                                child: Text(
                                                                                                  " ${listController.cousnellorlist_data[index].rewardPoints} +",
                                                                                                  style: SafeGoogleFont(
                                                                                                    'Inter',
                                                                                                    fontSize: 13 * ffem,
                                                                                                    fontWeight: FontWeight.w700,
                                                                                                    height: 1.2125 * ffem / fem,
                                                                                                    color: const Color(0xff000000),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 16.73 * fem, 1.88 * fem),
                                                                                          constraints: BoxConstraints(
                                                                                            maxWidth: 3 * fem,
                                                                                          ),
                                                                                          child: Text(
                                                                                            '.\n.\n.\n.\n.\n.\n.\n.\n.',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: SafeGoogleFont(
                                                                                              'Inter',
                                                                                              fontSize: 9 * ffem,
                                                                                              fontWeight: FontWeight.w400,
                                                                                              height: 0.4849999746 * ffem / fem,
                                                                                              color: const Color(0xff9a9898),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            Container(
                                                                                              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 6.53 * fem),
                                                                                              child: Text(
                                                                                                'Reviews',
                                                                                                style: SafeGoogleFont(
                                                                                                  'Inter',
                                                                                                  fontSize: 11 * ffem,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  height: 1.2125 * ffem / fem,
                                                                                                  color: const Color(0xff8d8888),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              margin: EdgeInsets.fromLTRB(0 * fem, 3 * fem, 4.34 * fem, 0 * fem),
                                                                                              child: Text(
                                                                                                '${listController.cousnellorlist_data[index].reviews}',
                                                                                                style: SafeGoogleFont(
                                                                                                  'Inter',
                                                                                                  fontSize: 13 * ffem,
                                                                                                  fontWeight: FontWeight.w700,
                                                                                                  height: 1.2125 * ffem / fem,
                                                                                                  color: const Color(0xff000000),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),

//==========================================================================================! Btns !=======================================

                                                                                Positioned(
                                                                                  left: 15.095703125 * fem,
                                                                                  top: 180.1729736328 * fem,
                                                                                  child: SizedBox(
                                                                                    width: 330.19 * fem,
                                                                                    height: 41.88 * fem,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                              log("idddddddd => ${listController.cousnellorlist_data[index].id}");
                                                                                              return CounsellorDetailsScreen(
                                                                                                id: listController.cousnellorlist_data[index].id,
                                                                                              );
                                                                                            }));
                                                                                          },
                                                                                          child: Container(
                                                                                            width: 120,
                                                                                            height: 40,
                                                                                            decoration: ShapeDecoration(
                                                                                              color: Colors.white,
                                                                                              shape: RoundedRectangleBorder(
                                                                                                side: BorderSide(
                                                                                                  width: 0.50,
                                                                                                  color: Colors.black.withOpacity(0.7400000095367432),
                                                                                                ),
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                              ),
                                                                                            ),
                                                                                            child: const SizedBox(
                                                                                              width: 100.09,
                                                                                              height: 16.05,
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  'Visit Profile',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: Color(0xFF262626),
                                                                                                    fontSize: 13,
                                                                                                    fontFamily: 'Inter',
                                                                                                    fontWeight: FontWeight.w700,
                                                                                                    height: 0.07,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            String id = listController.cousnellorlist_data[index].id;
                                                                                            String name = listController.cousnellorlist_data[index].name;
                                                                                            String designation = listController.cousnellorlist_data[index].designation;
                                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => CounsellingSessionPage(id: listController.cousnellorlist_data[index].id, name: name, designation: designation, selectedIndex_get: 0, profileurl: listController.cousnellorlist_data[index].profilePic)));
                                                                                          },
                                                                                          child: Container(
                                                                                            width: 120,
                                                                                            height: 40,
                                                                                            decoration: ShapeDecoration(
                                                                                              color: const Color(0xff1F0A68),
                                                                                              shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                              ),
                                                                                            ),
                                                                                            child: const SizedBox(
                                                                                              width: 110.09,
                                                                                              height: 16.05,
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  'Book Now',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.white,
                                                                                                    fontSize: 13,
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
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /*void onTapgotocounsellor(BuildContext context,
      {required String name, required String id}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CounsellingSessionPage(name: name, id: id)));
  }*/

  Future<bool> _onBackPressed() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomePageContainer()));
    return true;
  }
}
