import 'package:flutter/material.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/page-1/sign-up.dart';
import 'package:myapp/page-1/sign_up_screen_new.dart';
import 'package:myapp/phone/login_screen_n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreenNew extends StatefulWidget {
  const SplashScreenNew({super.key});

  @override
  State<SplashScreenNew> createState() => _SplashScreenNewState();
}

class _SplashScreenNewState extends State<SplashScreenNew> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    var mHeight = MediaQuery.sizeOf(context).height;
    var mWidth = MediaQuery.sizeOf(context).width;
    print(mHeight);
    print(mWidth);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // sortmycollegelogo1WFT (1115:272)
              width: mWidth * 0.5,
              height: mHeight * 0.06,
              padding: const EdgeInsets.all(0),
              margin: EdgeInsets.fromLTRB(0, mHeight * 0.10,7, 36),
              child: Image.asset(
                'assets/page-1/images/sortmycollege-logo-1.png',
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.00,
            ),
            Container(
              width: 360,
              height: 270,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/page-1/images/splash_image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: mHeight * 0.03,
            ),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to SortMyCollege India’s First ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'Super App',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: ' for Students',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: mHeight * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50,right: 50),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreenNew()));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color: Color(0xff1F0A68), width: 1),
                        ),
                        padding: const EdgeInsets.all(8),
                      ),
                      child: const Text('Log In',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: mHeight * 0.02,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreenNew()));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                          backgroundColor: const Color(0xff1F0A68)),
                      child: const Text('Register',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
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
