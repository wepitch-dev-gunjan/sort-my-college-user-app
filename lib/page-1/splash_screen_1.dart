import 'package:flutter/material.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/page-1/splash_screen_n.dart';
import 'package:myapp/shared/colors_const.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  static Future<bool?> loggIn() async {
    return await SharedPre.getAuthLogin();
  }

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 20), () async {
      bool? isLoggedIn = await SplashScreen1.loggIn();

      if (isLoggedIn == true) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomePageContainer()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SplashScreenNew()));
      }
     
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      body: Center(
        child: Image.asset(
          'assets/page-1/images/razerpay_logo.jpg',
        ),
      ),
    );
  }
}
