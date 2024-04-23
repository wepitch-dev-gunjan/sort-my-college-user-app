import 'package:flutter/material.dart';
// import 'package:myapp/page-1/counsellor_details_page2.dart';
import 'package:myapp/page-1/splash_screen_2.dart';
// import 'package:myapp/page-1/welcome-screen.dart';
import 'package:myapp/utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // splashscreen1pV (437:5)
        padding:
            EdgeInsets.fromLTRB(28.5 * fem, 50 * fem, 20.5 * fem, 100 * fem),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                // sortmycollegelogo1WFT (1115:272)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 16 * fem, 24 * fem),
                width: 294 * fem,
                height: 80 * fem,
                child: Image.asset(
                  'assets/page-1/images/sortmycollege-logo-1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              // sortyourentirecollegejourneyDQ (1115:271)
              margin: EdgeInsets.fromLTRB(6 * fem, 0 * fem, 0 * fem, 91 * fem),
              child: Text(
                'Sort Your Entire College Journey!',
                textAlign: TextAlign.center,
                style: SafeGoogleFont(
                  'Roboto',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.1725 * ffem / fem,
                  color: const Color(0xff1f0a68),
                ),
              ),
            ),
            Container(
              // untitleddesign41haq (1012:223)
              margin: EdgeInsets.fromLTRB(17 * fem, 0 * fem, 0 * fem, 34 * fem),
              width: 301 * fem,
              height: 238 * fem,
              child: Image.asset(
                'assets/page-1/images/untitled-design-4-1.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              // makingastudentslifesimple27K (1012:217)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 22 * fem),
              constraints: BoxConstraints(
                maxWidth: 381 * fem,
              ),
              child: Text(
                'Making A Students Life \nSimple ',
                textAlign: TextAlign.center,
                style: SafeGoogleFont(
                  'Montserrat',
                  fontSize: 32 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.2175 * ffem / fem,
                  color: const Color(0xff000000),
                ),
              ),
            ),
            Container(
              // group135K6R (1012:218)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 6.4 * fem, 64.99 * fem),
              width: 23.6 * fem,
              height: 6.01 * fem,
              child: Image.asset(
                'assets/page-1/images/group-135.png',
                width: 23.6 * fem,
                height: 6.01 * fem,
              ),
            ),
            Container(
              // autogroupcwbsQtZ (AXy71GhMBQq3TFBbukcWBs)
              margin: EdgeInsets.fromLTRB(
                  72.5 * fem, 0 * fem, 80.5 * fem, 33 * fem),
              width: double.infinity,
              height: 44 * fem,
              decoration: BoxDecoration(
                color: const Color(0xff1f0a68),
                borderRadius: BorderRadius.circular(10 * fem),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x3f000000),
                    offset: Offset(2 * fem, 3 * fem),
                    blurRadius: 1.5 * fem,
                  ),
                ],
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    onTapGettingstarted(context);
                  },
                  child: Text(
                    'Getting Started',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.1725 * ffem / fem,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // alreadyhaveanaccountsignineY1 (1012:216)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 17 * fem, 0 * fem),
              constraints: BoxConstraints(
                maxWidth: 170 * fem,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: SafeGoogleFont(
                    'Roboto',
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.4818749746 * ffem / fem,
                    color: const Color(0xff1f0a68),
                  ),
                  children: [
                    TextSpan(
                      text: 'Already have an account?\n',
                      style: SafeGoogleFont(
                        'Roboto',
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.4826653059 * ffem / fem,
                        color: const Color(0xff1f0a68),
                      ),
                    ),
                    TextSpan(
                      text: 'Sign in',
                      style: SafeGoogleFont(
                        'Roboto',
                        fontSize: 17 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.4826653059 * ffem / fem,
                        color: const Color(0xff1f0a68),
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

  void onTapGettingstarted(BuildContext context) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageContainer()));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const SplashScreen2()));

    //Navigator.push(context, MaterialPageRoute(builder: (context) => EducationLevel()));
  }
}
