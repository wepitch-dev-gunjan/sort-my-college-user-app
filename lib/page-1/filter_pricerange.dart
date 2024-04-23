import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

import 'filter_location.dart';
import 'filter_course.dart';
import 'filter_experince.dart';

import '../home_page/homepagecontainer_2.dart';

class Filter_PriceRange extends StatefulWidget {
  const Filter_PriceRange({super.key});

  @override
  State<Filter_PriceRange> createState() => _Filter_PriceRangeState();
}

class _Filter_PriceRangeState extends State<Filter_PriceRange> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          // iphone1415promax1GWc (2471:996)
          width: double.infinity,
          height: 932 * fem,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Container(
            // epfeedCv4 (2454:162)
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    // rectangle2518oi (2471:989)
                    width: double.infinity,
                    child: Center(
                      // rectangle2516kY (2456:266)
                      child: SizedBox(
                        width: double.infinity,
                        height: 87 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0x23000000)),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  // autogroupvbc4RXv (ob7554dV9qgW5kfXkVBC4)
                  width: double.infinity,
                  height: 795 * fem,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        // more11MwN (2454:202)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 15 * fem, 15 * fem),
                        width: 24 * fem,
                        height: 24 * fem,
                        child: Image.asset(
                          'assets/page-1/images/more-1-1-Za8.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        // autogroupzzt2gik (ob5kSbeQyqeeG6WDAZzT2)
                        margin: EdgeInsets.fromLTRB(
                            7 * fem, 0 * fem, 11 * fem, 11 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // filtersDTn (2456:268)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 292 * fem, 0 * fem),
                              child: Text(
                                'Filters',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2125 * ffem / fem,
                                  color: const Color(0xff000000),
                                ),
                              ),
                            ),
                            Text(
                              // clearallKFv (2456:270)
                              'CLEAR ALL',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.2125 * ffem / fem,
                                color: const Color(0xfc1f0a68),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // autogroupfvuarFr (ob5u71svhpeMCQSDkfVua)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 15 * fem, 0 * fem),
                        width: double.infinity,
                        height: 720 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // autogroupdn7zmNp (ob66S2LX7VV3Lxomkdn7z)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 20 * fem, 0 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 400 * fem),
                              width: 159 * fem,
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xfff5f5f5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // group1483LL (2456:283)
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 21 * fem, 10 * fem, 17 * fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0x1c000000)),
                                      color: const Color(0xfff5f5f5),
                                    ),
                                    child: Text(
                                      'Degree',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2125 * ffem / fem,
                                        color: const Color(0xff575454),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    // group149jDA (2456:284)
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Filter_Location()),
                                            (route) => false);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 59 * fem,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0x1c000000)),
                                          color: const Color(0xfff5f5f5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Location Focused',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: const Color(0xff575454),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    // group150CMe (2456:287)
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Filter_Course()),
                                            (route) => false);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(10 * fem,
                                            21 * fem, 10 * fem, 21 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0x1c000000)),
                                          color: const Color(0xfff5f5f5),
                                        ),
                                        child: Text(
                                          'Courses Focused',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2125 * ffem / fem,
                                            color: const Color(0xff575454),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    // group151UKA (2456:317)
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Filter_PriceRange()),(route) => false);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(11 * fem,
                                            21 * fem, 11 * fem, 21 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0x1c000000)),
                                          color: const Color(0xffffffff),
                                        ),
                                        child: Text(
                                          'Price Range',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2125 * ffem / fem,
                                            color: const Color(0xff575454),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    // group154M84 (2459:329)
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Filter_Experince()),
                                            (route) => false);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(11 * fem,
                                            21 * fem, 11 * fem, 21 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0x1c000000)),
                                          color: const Color(0xfff5f5f5),
                                        ),
                                        child: Text(
                                          'Experience',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2125 * ffem / fem,
                                            color: const Color(0xff575454),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // slideryesXzx (2926:378)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 33 * fem, 0 * fem, 0 * fem),
                              width: 206 * fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // autogroupovgyTNp (obHXgoXDCUNgsEL1XovgY)
                                    margin: EdgeInsets.fromLTRB(
                                        2 * fem, 0 * fem, 4 * fem, 4 * fem),
                                    width: double.infinity,
                                    height: 39 * fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // bgBpc (I2926:378;2465:853)
                                          left: 0 * fem,
                                          top: 31 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 200 * fem,
                                              height: 4 * fem,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100 * fem),
                                                  color:
                                                      const Color(0x33b1a0eb),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // fillJPS (I2926:378;2465:854)
                                          left: 22 * fem,
                                          top: 0 * fem,
                                          child: Container(
                                            width: 157 * fem,
                                            height: 39 * fem,
                                            decoration: BoxDecoration(
                                              color: const Color(0xff1f0a68),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      100 * fem),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // knobminRDA (I2926:378;2465:862)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      82 * fem,
                                                      0 * fem),
                                                  width: 36 * fem,
                                                  height: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        // tooltipkFS (I2926:378;2465:864)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                0 * fem,
                                                                3 * fem),
                                                        width: double.infinity,
                                                        height: 24 * fem,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4 * fem),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              // bgGja (I2926:378;2465:865)
                                                              left: 0 * fem,
                                                              top: 0 * fem,
                                                              child: Align(
                                                                child: SizedBox(
                                                                  width:
                                                                      36 * fem,
                                                                  height:
                                                                      23.59 *
                                                                          fem,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/page-1/images/bgback.png',
                                                                    width: 36 *
                                                                        fem,
                                                                    height:
                                                                        23.59 *
                                                                            fem,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              // valueNnc (I2926:378;2465:868)
                                                              left: 3.5 * fem,
                                                              top: 3 * fem,
                                                              child: Center(
                                                                child: Align(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 29 *
                                                                        fem,
                                                                    height: 15 *
                                                                        fem,
                                                                    child: Text(
                                                                      '1000',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          SafeGoogleFont(
                                                                        'Inter',
                                                                        fontSize:
                                                                            12 *
                                                                                ffem,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        height: 1.2125 *
                                                                            ffem /
                                                                            fem,
                                                                        color: const Color(
                                                                            0xffffffff),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // ellipse4QY (I2926:378;2465:863)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                12 * fem,
                                                                0 * fem,
                                                                12 * fem,
                                                                0 * fem),
                                                        width: double.infinity,
                                                        height: 12 * fem,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6 * fem),
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0x19000000)),
                                                          color: const Color(
                                                              0xffffffff),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                  0x19000000),
                                                              offset: Offset(
                                                                  0 * fem,
                                                                  2 * fem),
                                                              blurRadius:
                                                                  2 * fem,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  // knobmaxYqW (I2926:378;2465:855)
                                                  width: 39 * fem,
                                                  height: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        // tooltip6c8 (I2926:378;2465:857)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                0 * fem,
                                                                3 * fem),
                                                        width: double.infinity,
                                                        height: 24 * fem,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4 * fem),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              // bg2Et (I2926:378;2465:858)
                                                              left: 0 * fem,
                                                              top: 0 * fem,
                                                              child: Align(
                                                                child: SizedBox(
                                                                  width:
                                                                      39 * fem,
                                                                  height:
                                                                      23.59 *
                                                                          fem,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/page-1/images/bgback.png',
                                                                    width: 39 *
                                                                        fem,
                                                                    height:
                                                                        23.59 *
                                                                            fem,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              // valueMHA (I2926:378;2465:861)
                                                              left: 4.5 * fem,
                                                              top: 3 * fem,
                                                              child: Center(
                                                                child: Align(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 31 *
                                                                        fem,
                                                                    height: 15 *
                                                                        fem,
                                                                    child: Text(
                                                                      '4000',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          SafeGoogleFont(
                                                                        'Inter',
                                                                        fontSize:
                                                                            12 *
                                                                                ffem,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        height: 1.2125 *
                                                                            ffem /
                                                                            fem,
                                                                        color: const Color(
                                                                            0xffffffff),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // ellipseeXA (I2926:378;2465:856)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                14 * fem,
                                                                0 * fem,
                                                                13 * fem,
                                                                0 * fem),
                                                        width: double.infinity,
                                                        height: 12 * fem,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6 * fem),
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0x19000000)),
                                                          color: const Color(
                                                              0xffffffff),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                  0x19000000),
                                                              offset: Offset(
                                                                  0 * fem,
                                                                  2 * fem),
                                                              blurRadius:
                                                                  2 * fem,
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
                                    ),
                                  ),
                                  SizedBox(
                                    // stepsscaledLet (I2926:378;2465:869)
                                    width: double.infinity,
                                    height: 16 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // evU (I2926:378;2465:870)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 13.9 * fem, 0 * fem),
                                          padding: EdgeInsets.fromLTRB(0 * fem,
                                              6 * fem, 0 * fem, 0 * fem),
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                          child: Text(
                                            '0',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 8 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: const Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // L2c (I2926:378;2465:872)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 13.9 * fem, 0 * fem),
                                          width: 4 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                        ),
                                        Container(
                                          // 4UQ (I2926:378;2465:874)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 11.9 * fem, 0 * fem),
                                          padding: EdgeInsets.fromLTRB(0 * fem,
                                              6 * fem, 0 * fem, 0 * fem),
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '10',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 8 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2125 * ffem / fem,
                                                color: const Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // YeU (I2926:378;2465:876)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 11.9 * fem, 0 * fem),
                                          width: 6 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                        ),
                                        Container(
                                          // 5uJ (I2926:378;2465:878)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 12.9 * fem, 0 * fem),
                                          padding: EdgeInsets.fromLTRB(0 * fem,
                                              6 * fem, 0 * fem, 0 * fem),
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '20',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 8 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2125 * ffem / fem,
                                                color: const Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // N7i (I2926:378;2465:880)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 11.9 * fem, 0 * fem),
                                          width: 5 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                        ),
                                        Container(
                                          // u7e (I2926:378;2465:882)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 11.9 * fem, 0 * fem),
                                          padding: EdgeInsets.fromLTRB(0 * fem,
                                              6 * fem, 0 * fem, 0 * fem),
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '30',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 8 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2125 * ffem / fem,
                                                color: const Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // nhE (I2926:378;2465:884)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 11.9 * fem, 0 * fem),
                                          width: 5 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                        ),
                                        Container(
                                          // iqn (I2926:378;2465:886)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 10.9 * fem, 0 * fem),
                                          padding: EdgeInsets.fromLTRB(0 * fem,
                                              6 * fem, 0 * fem, 0 * fem),
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '40',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 8 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2125 * ffem / fem,
                                                color: const Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // oMS (I2926:378;2465:888)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 11.9 * fem, 0 * fem),
                                          width: 5 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                        ),
                                        Container(
                                          // wCk (I2926:378;2465:890)
                                          padding: EdgeInsets.fromLTRB(0 * fem,
                                              6 * fem, 0 * fem, 0 * fem),
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x33000000),
                                            borderRadius:
                                                BorderRadius.circular(1 * fem),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '50',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 8 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2125 * ffem / fem,
                                                color: const Color(0xff000000),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  // autogroup1gwcqct (ob6uABUiYdStxGLg11gWC)
                  width: double.infinity,
                  height: 50 * fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        // group144b6G (2454:261)
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 215 * fem,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0x23000000)),
                            color: const Color(0xffffffff),
                          ),
                          child: Center(
                            child: Text(
                              'CLOSE',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.2125 * ffem / fem,
                                color: const Color(0xff7f7e85),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        // group145Ufr (2454:262)
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 215 * fem,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0x38000000)),
                            color: const Color(0xffb1a0ea),
                          ),
                          child: Center(
                            child: Text(
                              'APPLY',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.2125 * ffem / fem,
                                color: const Color(0xffffffff),
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
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePageContainer_2()),
    );
    return true;
  }
}
