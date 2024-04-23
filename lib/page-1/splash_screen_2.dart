import 'package:flutter/material.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/page-1/sign-up.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    var mHeight = MediaQuery.sizeOf(context).height;
    var mWidth = MediaQuery.sizeOf(context).width;
    print(mHeight);
    print(mWidth);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // sortmycollegelogo1WFT (1115:272)
              width: mWidth * 0.7,
              height: mHeight * 0.08,
              padding: const EdgeInsets.all(0),

              margin: EdgeInsets.fromLTRB(0, mHeight * 0.12, 0, 24),

              child: Image.asset(
                'assets/page-1/images/sortmycollege-logo-1.png',
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            // Container(
            //   // sortyourentirecollegejourneyDQ (1115:271)
            //   margin: EdgeInsets.fromLTRB(0, 0, 0, mHeight * 0.04),
            //   child: Text(
            //     'All in one platform for student',
            //     textAlign: TextAlign.center,
            //     style: SafeGoogleFont(
            //       'Roboto',
            //       fontSize: 16,
            //       fontWeight: FontWeight.w700,
            //       height: 1.1725,
            //       color: const Color(0xff1f0a68),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              width: 340,
              height: 240,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/page-1/images/splash_image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // const Text.rich(
            //   TextSpan(
            //     children: [
            //       TextSpan(
            //         text: 'Welcome to SortMyCollege India’s First ',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 16,
            //           fontFamily: 'Montserrat',
            //           fontWeight: FontWeight.w500,
            //           height: 0,
            //         ),
            //       ),
            //       TextSpan(
            //         text: 'Super App',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 16,
            //           fontFamily: 'Montserrat',
            //           fontWeight: FontWeight.w500,
            //           height: 0,
            //         ),
            //       ),
            //       TextSpan(
            //         text: ' for Students',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 16,
            //           fontFamily: 'Montserrat',
            //           fontWeight: FontWeight.w500,
            //           height: 0,
            //         ),
            //       ),
            //     ],
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // CarouselSlider.builder(
            //     itemCount: sliderTextImages.length,
            //     itemBuilder: (context, index, realIndex) {
            //       var textImage = sliderTextImages[index];
            //       return Container(
            //         padding: const EdgeInsets.all(5),
            //         // makingastudentslifesimple27K (1012:217)
            //         margin: const EdgeInsets.symmetric(horizontal: 46),
            //         // height: 50,
            //         width: mWidth * 0.95,
            //         alignment: Alignment.center,
            //
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //               width: 5,
            //               color: const Color(0xff1F0A68),
            //             ),
            //             borderRadius: BorderRadius.circular(30)),
            //         child: Container(
            //           // height: mHeight * 0.1,
            //           // width: mWidth * 0.95,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(30),
            //               image: DecorationImage(
            //                   image: AssetImage(textImage), fit: BoxFit.fill)),
            //         ),
            //
            //         // child: Column(
            //         //   mainAxisAlignment: MainAxisAlignment.center,
            //         //   children: [
            //
            //         //     // Container(
            //         //     //   // color: Colors.red,
            //         //     //   // alignment: Alignment.bottomCenter,
            //         //     //   child: AnimatedTextKit(
            //         //     //       isRepeatingAnimation: true,
            //         //     //       repeatForever: true,
            //         //     //       stopPauseOnTap: true,
            //         //     //       animatedTexts: [
            //         //     //         TyperAnimatedText(
            //         //     //           "Making A Student's Life Simple ",
            //         //     //           // rotateOut: true,
            //         //     //           // textDirection: TextDirection.rtl,
            //         //     //           textAlign: TextAlign.center,
            //         //     //           // duration: const Duration(seconds: 1),
            //         //     //           textStyle: SafeGoogleFont(
            //         //     //             'Jost',
            //         //     //             fontSize: mHeight * 0.04,
            //         //     //             fontWeight: FontWeight.w400,
            //         //     //             height: 1.4,
            //         //     //             color: const Color(0xff1F0A68),
            //         //     //           ),
            //         //     //         ),
            //         //     //         TyperAnimatedText(
            //         //     //           "Sort Your College Life With Us",
            //
            //         //     //           textAlign: TextAlign.center,
            //         //     //           // rotateOut: true,
            //         //     //           // duration: const Duration(seconds: 1),
            //         //     //           textStyle: SafeGoogleFont(
            //         //     //             'Jost',
            //         //     //             fontSize: mHeight * 0.04,
            //         //     //             fontWeight: FontWeight.w400,
            //         //     //             height: 1.4,
            //         //     //             color: const Color(0xff1F0A68),
            //         //     //           ),
            //         //     //         ),
            //         //     //       ]),
            //         //     // ),
            //         //     // Expanded(
            //         //     //   child: Container(
            //         //     //     alignment: Alignment.topCenter,
            //         //     //     // group135K6R (1012:218)
            //         //     //     margin: const EdgeInsets.fromLTRB(0, 0, 6.4, 0),
            //         //     //     width: 200.6,
            //         //     //     height: 200.01,
            //
            //         //     //     child: ColorFiltered(
            //         //     //       colorFilter: const ColorFilter.mode(
            //         //     //           Color(0xff1F0A68), BlendMode.modulate),
            //         //     //       child: Lottie.asset(
            //         //     //         'assets/animations/loadingdot.json',
            //         //     //         fit: BoxFit.cover,
            //         //     //         alignment: Alignment.topCenter,
            //         //     //       ),
            //         //     //     ),
            //         //     //   ),
            //         //     // ),
            //         //   ],
            //         // ),
            //       );
            //     },
            //     options: CarouselOptions(
            //       viewportFraction: 1,
            //       height: 190,
            //       autoPlay: true,
            //       onPageChanged: (index, reason) {
            //         setState(() {
            //           selectIndex = index;
            //         });
            //       },
            //     )),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       '.',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: Color(0xFF1F0A68),
            //         fontSize: 25,
            //         fontFamily: 'Roboto',
            //         fontWeight: FontWeight.w500,
            //         height: 0,
            //       ),
            //     ),
            //     Text(
            //       '.',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: Color(0xFF1F0A68),
            //         fontSize: 25,
            //         fontFamily: 'Roboto',
            //         fontWeight: FontWeight.w500,
            //         height: 0,
            //       ),
            //     ),
            //     Text(
            //       '.',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: Color(0xFF1F0A68),
            //         fontSize: 25,
            //         fontFamily: 'Roboto',
            //         fontWeight: FontWeight.w500,
            //         height: 0,
            //       ),
            //     ),
            //     // TabPageSelectorIndicator(
            //     //     backgroundColor:
            //     //         selectIndex == 0 ? const Color(0xff1F0A68) : Colors.white,
            //     //     borderColor: const Color(0xff1F0A68),
            //     //     size: 10),
            //     // TabPageSelectorIndicator(
            //     //     backgroundColor:
            //     //         selectIndex == 1 ? const Color(0xff1F0A68) : Colors.white,
            //     //     borderColor: const Color(0xff1F0A68),
            //     //     size: 10),
            //     // TabPageSelectorIndicator(
            //     //     backgroundColor:
            //     //         selectIndex == 2 ? const Color(0xff1F0A68) : Colors.white,
            //     //     borderColor: const Color(0xff1F0A68),
            //     //     size: 10),
            //   ],
            // ),
            SizedBox(
              height: mHeight * 0.1,
            ),
            Container(
              // autogroupcwbsQtZ (AXy71GhMBQq3TFBbukcWBs)
              // margin: const EdgeInsets.fromLTRB(72.5, 0, 80.5, 33),
              width: 210,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xff1f0a68),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(2, 3),
                    blurRadius: 1.5,
                  ),
                ],
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    onTapGettingStarted(context);
                  },
                  child: Text(
                    'Getting Started',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.1725,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mHeight * 0.02,
            ),
            Container(
              // alreadyhaveanaccountsignineY1 (1012:216)
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              constraints: const BoxConstraints(
                  // maxWidth: 170,
                  ),
              child: Column(
                // textAlign: TextAlign.center,
                // text: TextSpan(
                //   style: SafeGoogleFont(
                //     'Roboto',
                //     fontSize: 15,
                //     fontWeight: FontWeight.w700,
                //     height: 1.4818749746,
                //     color: const Color(0xff1f0a68),
                //   ),
                children: [
                  Text(
                    'Already have an account?',
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4826653059,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                     /* SharedPreferences shared = await SharedPreferences.getInstance();
                      var token = shared.getString('token');
                      if (token != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                token == null ? const Login() : const HomePageContainer()));
                      }
                      else{
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                token == null ? const Login() : const HomePageContainer()));
                      }*/
                    },
                    child: Text(
                      'Log in',
                      style: SafeGoogleFont(
                        'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.4826653059,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         launchUrlString(
            //             'https://app.zoom.us/wc/join/6876923575?fromPWA=1&pwd=GCbNDEgI1W9UmcjX4H3A5NlhJbv0Gs.1&_x_zm_rtaid=dMkrHAzTSv2KH-k63GFIIg.1709188412516.3a0d504b72c1403587e5715af973a35f&_x_zm_rhtaid=220');
            //       },
            //       child: Text(
            //         'Zoom Meeting By Browser',
            //         style: SafeGoogleFont(
            //           'Roboto',
            //           fontSize: 12,
            //           fontWeight: FontWeight.w400,
            //           height: 1.4826653059,
            //           color: Colors.pinkAccent,
            //         ),
            //       ),
            //     ),
            //     const Text('|'),
            //     GestureDetector(
            //       onTap: () {
            //         launch(
            //             'https://us05web.zoom.us/j/6876923575?pwd=GCbNDEgI1W9UmcjX4H3A5NlhJbv0Gs.1');
            //       },
            //       child: Text(
            //         'Zoom Meeting By App',
            //         style: SafeGoogleFont(
            //           'Roboto',
            //           fontSize: 12,
            //           fontWeight: FontWeight.w400,
            //           height: 1.4826653059,
            //           color: Colors.pinkAccent,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                launchUrlString(
                    'https://sortmycollege.com/terms-and-conditions/');
              },
              child: Text(
                "By continuing , I agree with the Terms and Conditions , Privacy Policy",
                style: SafeGoogleFont(
                  "Roboto",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
          ],
        ),
      ),
    );
  }
  void launchUrlString(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}

void onTapGettingStarted(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");
  if (token != null) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                token == null ? const Signup() : const HomePageContainer()));
    SharedPre.saveAuthLogin(true);
  } else {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                token == null ? const Signup() : const HomePageContainer()));
  }
}
// void onTapLogIn(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var token = prefs.getString("token");
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//           token == null ? const Login() : const HomePageContainer()));
//
// }
