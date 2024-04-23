import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

import 'filter_pricerange.dart';
import 'filter_location.dart';
import 'filter_course.dart';
import 'filter_experince.dart';

import '../home_page/homepagecontainer_2.dart';

class Filter_Degree extends StatefulWidget {
  const Filter_Degree({super.key});

  @override
  State<Filter_Degree> createState() => _Filter_DegreeState();
}

class _Filter_DegreeState extends State<Filter_Degree> {
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
                            7 * fem, 0 * fem, 10 * fem, 10 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // filtersDTn (2456:268)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 294 * fem, 0 * fem),
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
                                      color: const Color(0xffffffff),
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
                                                    Filter_Location()),
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
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Filter_PriceRange()),
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
                                                    Filter_Experince()),
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
                            SizedBox(
                              // autogroup6qv4Qs2 (ob6N1QiavY8zYjKQW6Qv4)
                              width: 236 * fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // group146D3n (2456:277)
                                    padding: EdgeInsets.fromLTRB(
                                        6 * fem, 21 * fem, 115 * fem, 21 * fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0x1c000000)),
                                      color: const Color(0xffffffff),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // tick6NU (2456:274)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              2 * fem, 6 * fem, 0 * fem),
                                          width: 14 * fem,
                                          height: 15 * fem,
                                          child: Image.asset(
                                            'assets/page-1/images/tick.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          // undergraduatecrc (2456:276)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 2 * fem),
                                          child: Text(
                                            'Under Graduate',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: const Color(0xff575454),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group147XCt (2456:278)
                                    padding: EdgeInsets.fromLTRB(
                                        5 * fem, 21 * fem, 123 * fem, 20 * fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0x1c000000)),
                                      color: const Color(0xffffffff),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // tickEd6 (2456:281)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              1 * fem, 3 * fem, 0 * fem),
                                          width: 16 * fem,
                                          height: 17 * fem,
                                          child: Image.asset(
                                            'assets/page-1/images/tick-h5A.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          // postgraduateaBA (2471:1006)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 3 * fem),
                                          child: TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                            ),
                                            child: SizedBox(
                                              width: 84 * fem,
                                              height: 15 * fem,
                                              child: Center(
                                                child: Text(
                                                  'Post Graduate',
                                                  textAlign: TextAlign.center,
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.2125 * ffem / fem,
                                                    color:
                                                        const Color(0xff1f0a68),
                                                  ),
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
