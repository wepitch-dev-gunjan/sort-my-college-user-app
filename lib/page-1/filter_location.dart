import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

import 'filter_pricerange.dart';
import 'filter_degree.dart';
import 'filter_course.dart';
import 'filter_experince.dart';

import '../home_page/homepagecontainer_2.dart';

class Filter_Location extends StatefulWidget {
  const Filter_Location({super.key});

  @override
  State<Filter_Location> createState() => _Filter_LocationState();
}

class _Filter_LocationState extends State<Filter_Location> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        // iphone1415promax2c4Y (2471:997)
        width: double.infinity,
        height: 932 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // epfeedwsW (2456:292)
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
                  // rectangle251UsS (2471:990)
                  width: double.infinity,
                  child: Center(
                    // rectangle2513fe (2456:300)
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
                // autogroupnuy6z56 (obA99caCFBB2kmDH4nUy6)
                width: double.infinity,
                height: 795 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      // more11Kt4 (2456:293)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 15 * fem, 15 * fem),
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/page-1/images/more-1-1-vXi.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      // autogroupk2p2TDa (ob8HnXoQkAFEbJAJhk2P2)
                      margin: EdgeInsets.fromLTRB(
                          7 * fem, 0 * fem, 11 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // filtersnme (2456:302)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 290 * fem, 0 * fem),
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
                            // clearall61e (2456:303)
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
                      // autogroups8baE7r (ob8TCRnUbgPHF7XdBs8BA)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 15 * fem, 0 * fem),
                      width: double.infinity,
                      height: 720 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              // autogrouppysgx3r (ob8hMgricGS9RozZgpySg)
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
                                    // group148dvg (2456:304)
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
                                                    const Filter_Degree()),
                                            (route) => false);
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
                                  Container(
                                    // group149gtx (2456:307)
                                    width: double.infinity,
                                    height: 59 * fem,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0x1c000000)),
                                      color: const Color(0xffffffff),
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
                                  TextButton(
                                    // group150aUY (2459:489)
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
                                    // group151ezC (2459:320)
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Filter_Experince()),
                                          (route) => false);
                                    },
                                    child: Container(
                                      // group330KqS (2806:708)
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            // autogroupr1pnQM6 (ob8y1uS4svmh3XL7yr1PN)
                            width: 236 * fem,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // group146kQx (2456:313)
                                  padding: EdgeInsets.fromLTRB(
                                      0 * fem, 21 * fem, 0 * fem, 21 * fem),
                                  width: double.infinity,
                                  height: 59 * fem,
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
                                        // autogroup9x6pfXv (ob97GAhAJqMRv78Wr9X6p)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 156 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Text(
                                          'Country',
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
                                      Container(
                                        // downarrowZtC (2459:335)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                        width: 14 * fem,
                                        height: 14 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/down-arrow.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // group152VWx (2459:336)
                                  padding: EdgeInsets.fromLTRB(
                                      0 * fem, 21 * fem, 0 * fem, 21 * fem),
                                  width: double.infinity,
                                  height: 59 * fem,
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
                                        // autogroupq23aoXe (ob9GktsWcyB4ysKksq23a)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 181 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Text(
                                          'State',
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
                                      Container(
                                        // downarrow7HS (2459:340)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                        width: 14 * fem,
                                        height: 14 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/down-arrow.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // group157dma (2806:703)
                                  padding: EdgeInsets.fromLTRB(
                                      0 * fem, 21 * fem, 0 * fem, 21 * fem),
                                  width: double.infinity,
                                  height: 59 * fem,
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
                                        // autogroupojctYde (ob9RFeiTRiob6HbvNojCt)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 194 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Text(
                                          'City',
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
                                      Container(
                                        // downarrowTEp (2806:707)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                        width: 14 * fem,
                                        height: 14 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/down-arrow.png',
                                          fit: BoxFit.cover,
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
                // autogrouptymsAuv (ob9z53NGE7mMkj9ektymS)
                width: double.infinity,
                height: 50 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      // group1447KN (2456:294)
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
                      // group145aye (2456:297)
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePageContainer_2()),
    );
    return true;
  }
}
