import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';
import 'filter_pricerange.dart';
import 'filter_degree.dart';
import 'filter_location.dart';
import 'filter_experince.dart';

class Filter_Course extends StatefulWidget {
  const Filter_Course({super.key});

  @override
  State<Filter_Course> createState() => _Filter_CourseState();
}

class _Filter_CourseState extends State<Filter_Course> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        // iphone1415promax3YSU (2471:1048)
        width: double.infinity,
        height: 932 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // epfeedHQ4 (2459:443)
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
                  // rectangle251p96 (2471:991)
                  width: double.infinity,
                  child: Center(
                    // rectangle251nLp (2459:451)
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
                // autogroupdr9eiEU (obEQwfMRRT3AyyLiodr9e)
                width: double.infinity,
                height: 795 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      // more113nY (2459:444)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 15 * fem, 15 * fem),
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/page-1/images/more-1-2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      // autogroup9kaqNK2 (obC36TNmyGGDiXssJ9KAQ)
                      margin: EdgeInsets.fromLTRB(
                          7 * fem, 0 * fem, 11 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // filters6kp (2459:453)
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
                            // clearall176 (2459:454)
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
                      // autogroup7arv8xQ (obCHFiT1yrK5uELoo7ARv)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 15 * fem, 0 * fem),
                      width: double.infinity,
                      height: 720 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // autogroup6b68Tjn (obCazhtTitiTqaLSh6B68)
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
                                TextButton(
                                  // group148kit (2459:455)
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Filter_Degree()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(11 * fem,
                                          21 * fem, 11 * fem, 21 * fem),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0x1c000000)),
                                        color: const Color(0xfff2f2f2),
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
                                  ),
                                ),
                                TextButton(
                                  // group1491ui (2459:458)
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Filter_Location()),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 59 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0x1c000000)),
                                        color: const Color(0xfff2f2f2),
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
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Filter_Course()),(route) => false);
                                  },
                                  child: Container(
                                    // group150VZz (2459:492)
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 21 * fem, 10 * fem, 21 * fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0x1c000000)),
                                      color: const Color(0xffffffff),
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
                                TextButton(
                                  // group151nJC (2459:474)
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Filter_PriceRange()),
                                      );
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Filter_Experince()),
                                    );
                                  },
                                  child: Container(
                                    // group156TQL (2459:486)
                                    padding: EdgeInsets.fromLTRB(
                                        11 * fem, 21 * fem, 11 * fem, 21 * fem),
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
                              ],
                            ),
                          ),
                          SizedBox(
                            // autogroupucmvwqJ (obCs55SEHdTyX1ochuCmv)
                            width: 236 * fem,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // group1465Ri (2459:495)
                                  padding: EdgeInsets.fromLTRB(
                                      6 * fem, 22 * fem, 134 * fem, 21 * fem),
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
                                        // tickPxC (2459:498)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 1 * fem, 3 * fem, 0 * fem),
                                        width: 14 * fem,
                                        height: 15 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/tick.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        // managementXHi (2459:497)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                        child: Text(
                                          'Management',
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
                                TextButton(
                                  // group1722VN (2471:1042)
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 59 * fem,
                                    child: Container(
                                      // group169N3S (I2471:1042;2471:1016)
                                      padding: EdgeInsets.fromLTRB(
                                          6 * fem, 21 * fem, 6 * fem, 21 * fem),
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0x1c000000)),
                                        color: const Color(0xffffffff),
                                      ),
                                      child: SizedBox(
                                        // group1706VE (I2471:1042;2471:1018)
                                        width: 88.5 * fem,
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // tickeWk (I2471:1042;2471:1020)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  2 * fem,
                                                  6.5 * fem,
                                                  0 * fem),
                                              width: 14 * fem,
                                              height: 15 * fem,
                                              child: Image.asset(
                                                'assets/page-1/images/tick.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              // engineeringyov (I2471:1042;2471:1019)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  2 * fem),
                                              child: Text(
                                                'Engineering',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 12 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2125 * ffem / fem,
                                                  color:
                                                      const Color(0xff575454),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // group158tfz (2463:503)
                                  padding: EdgeInsets.fromLTRB(
                                      5 * fem, 22 * fem, 111 * fem, 20 * fem),
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
                                        // tickQPS (2463:531)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 1 * fem, 0 * fem),
                                        width: 16 * fem,
                                        height: 17 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/tick.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        // medicalhealthjgc (2463:505)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 2 * fem),
                                        child: Text(
                                          'Medical & Health',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2125 * ffem / fem,
                                            color: const Color(0xff1f0a68),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // group159eHn (2463:507)
                                  padding: EdgeInsets.fromLTRB(
                                      6 * fem, 22 * fem, 185 * fem, 21 * fem),
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
                                        // tick4MW (2463:510)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 1 * fem, 5 * fem, 0 * fem),
                                        width: 14 * fem,
                                        height: 15 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/tick.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        // lawbMS (2463:509)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                        child: Text(
                                          'Law',
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
                                  // group160WUQ (2463:511)
                                  padding: EdgeInsets.fromLTRB(
                                      6 * fem, 22 * fem, 152 * fem, 21 * fem),
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
                                        // tick2Br (2463:514)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 1 * fem, 2 * fem, 0 * fem),
                                        width: 14 * fem,
                                        height: 15 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/tick.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        // pharmacyZSg (2463:513)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                        child: Text(
                                          'Pharmacy',
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
                                  // group165UJk (2463:532)
                                  padding: EdgeInsets.fromLTRB(
                                      5 * fem, 22 * fem, 104 * fem, 20 * fem),
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
                                        // tickByr (2463:535)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 2 * fem, 0 * fem),
                                        width: 16 * fem,
                                        height: 17 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/tick.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        // hotelmangementiyn (2463:534)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 2 * fem),
                                        child: Text(
                                          'Hotel Mangement',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2125 * ffem / fem,
                                            color: const Color(0xff1f0a68),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // group162EhE (2463:519)
                                  padding: EdgeInsets.fromLTRB(
                                      6 * fem, 22 * fem, 139 * fem, 21 * fem),
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
                                        // tickAKz (2463:522)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 1 * fem, 3 * fem, 0 * fem),
                                        width: 14 * fem,
                                        height: 15 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/tick.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        // architectureJSC (2463:521)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                        child: Text(
                                          'Architecture',
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
                                  // group163DJG (2463:523)
                                  padding: EdgeInsets.fromLTRB(
                                      6 * fem, 22 * fem, 164 * fem, 21 * fem),
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
                                        // tick7eY (2463:526)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 1 * fem, 3 * fem, 0 * fem),
                                        width: 14 * fem,
                                        height: 15 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/tick.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        // science3o6 (2463:525)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                        child: Text(
                                          'Science',
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
                                  // group164yAx (2463:527)
                                  padding: EdgeInsets.fromLTRB(
                                      6 * fem, 22 * fem, 147 * fem, 21 * fem),
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
                                        // tickHSY (2463:530)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 1 * fem, 3 * fem, 0 * fem),
                                        width: 14 * fem,
                                        height: 15 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/tick.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        // agricultureczc (2463:529)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                        child: Text(
                                          'Agriculture',
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
                // autogroup2pmrwX6 (obEBHPStAZ5sGwqKa2Pmr)
                width: double.infinity,
                height: 50 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      // group144GpG (2459:445)
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
                      // group145ZHa (2459:448)
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
    );
  }

  Future<bool> _onBackPressed() async {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const HomePageContainer_2()),
    // );
    Navigator.pop(context);
    return true;
  }
}
