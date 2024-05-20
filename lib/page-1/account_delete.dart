import 'package:flutter/material.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/page-1/otp_screen_new.dart';
import 'package:myapp/page-1/splash_screen_1.dart';
import 'package:myapp/phone/login_screen_n.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../other/constants.dart';
import 'package:flutter/services.dart';

class AccountDelete extends StatefulWidget {
  const AccountDelete({super.key});

  @override
  _AccountDelete createState() => _AccountDelete();
}

class _AccountDelete extends State<AccountDelete> {

  @override
  void initState() {
    super.initState();
    configLoading();
  }


  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop){
        _onBackPressed(context);
      },


      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/page-1/images/Group 627.png',
                fit: BoxFit.cover,
                height: 244,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text('We Have Received Account Delete Request Your Account Will Be Delete in 48 hours',
                style:TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black
                ),),

            ],
          ),
        ),
      ),
    );
  }


  Future<bool> _onBackPressed(
      BuildContext context) async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const SplashScreen1(isLoggedIn: false)));
    return true;
  }


}

