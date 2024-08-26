import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/other/constants.dart';
import 'package:myapp/page-1/sign_up_screen_new.dart';
import 'package:myapp/page-1/splash_screen_1.dart';
import 'package:myapp/page-1/splash_screen_n.dart';
import 'package:myapp/phone/login_screen.dart';
import 'package:myapp/slide_screen.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/utils/common.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page/homepagecontainer.dart';

class OtpScreenNewLogin extends StatefulWidget {
  final String phoneNumber;
  const OtpScreenNewLogin(this.phoneNumber, {super.key});

  @override
  State<OtpScreenNewLogin> createState() => _OtpScreenNewLoginState();
}

class _OtpScreenNewLoginState extends State<OtpScreenNewLogin> {
  OtpFieldController otpController = OtpFieldController();

  String otp = "";
  Duration duration = const Duration(minutes: 2);
  Timer? timer;
  bool isResendOtpEnabled = false;
  @override
  void initState() {
    super.initState();
    configLoading();
    startTimer();
  }

  void addTime() {
    const subSeconds = 1;

    setState(() {
      if (duration.inMinutes == 0 && duration.inSeconds == 0) {
        isResendOtpEnabled = true;
        timer!.cancel();
      } else {
        final seconds = duration.inSeconds - subSeconds;
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    double mHeight = MediaQuery.sizeOf(context).height;
    double mWidth = MediaQuery.sizeOf(context).width;

    var code = '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/page-1/images/www 1 (1).png',
                      height: 240,
                      width: 280,
                    ),
                  ],
                ),
              ),
              Container(
                height: ffem * 500,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffF6F7F7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 40, left: 20, right: 20, bottom: ffem * 1),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            73 * fem, 10 * fem, 47 * fem, 6 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            OTPTextField(
                                controller: otpController,
                                length: 4,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldWidth: 40,
                                //fieldStyle: FieldStyle.box,
                                outlineBorderRadius: 15,
                                style: const TextStyle(fontSize: 17),
                                onCompleted: (pin) {
                                  print("Completed: $pin");
                                  otp = pin;
                                }),
                            const SizedBox(height: 16),
                            Text(
                                "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}"),
                            Container(
                              // didntreceiveanotpresendotpX1s (437:94)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 60 * fem, 2 * fem, 15 * fem),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Did not receive an OTP?',
                                    style: SafeGoogleFont(
                                      'Roboto',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.1725 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      if (isResendOtpEnabled) {
                                        EasyLoading.show();
                                        ApiService.callVerifyOtpByPhone(
                                                widget.phoneNumber)
                                            .then((value) {
                                          if (value["message"]["description"] ==
                                              "Message in progress") {
                                            duration =
                                                const Duration(minutes: 2);
                                            setState(() {
                                              isResendOtpEnabled = false;
                                            });
                                            startTimer();
                                            EasyLoading.showToast(
                                                value["message"]["description"],
                                                toastPosition:
                                                    EasyLoadingToastPosition
                                                        .bottom);
                                          } else {
                                            EasyLoading.showToast(
                                                value["message"]["description"],
                                                toastPosition:
                                                    EasyLoadingToastPosition
                                                        .bottom);
                                          }
                                        });
                                      } else {}
                                    },
                                    child: Text(
                                      ' Resend OTP',
                                      style: SafeGoogleFont(
                                        'Roboto',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.1725 * ffem / fem,
                                        decoration: isResendOtpEnabled
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        color: isResendOtpEnabled
                                            ? const Color(0xff000000)
                                            : Colors.grey,
                                        decorationColor:
                                            const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (otp.isEmpty) {
                                  EasyLoading.showToast(AppConstants.otperror,
                                      toastPosition:
                                          EasyLoadingToastPosition.bottom);
                                } else {
                                  await EasyLoading.show(dismissOnTap: false);
                                  ApiService()
                                      .loginVerify(
                                          otp: otp.toString(),
                                          number: widget.phoneNumber)
                                      .then((value) async {
                                    if (value["message"] ==
                                            "OTP verified successfully" &&
                                        value["already_registered"] == true) {
                                      EasyLoading.dismiss();
                                      EasyLoading.showToast("You are login now",
                                          toastPosition:
                                              EasyLoadingToastPosition.bottom);
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          "phone_number", widget.phoneNumber);

                                      prefs.setBool("authLogin", true);
                                      prefs.setString("auth", value["token"]);
                                      prefs.setString("token", value["token"]);

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePageContainer()));
                                    } else {
                                      EasyLoading.dismiss();

                                      ShowSnackBarMsg(value['error'],
                                          color: Colors.red);
                                    }
                                    EasyLoading.dismiss();
                                  });
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 45 * fem,
                                decoration: BoxDecoration(
                                  color: const Color(0xff1f0a68),
                                  borderRadius: BorderRadius.circular(10 * fem),
                                ),
                                child: Center(
                                  child: Text(
                                    'Submit OTP',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Roboto',
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.1725 * ffem / fem,
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
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 60
    ..textColor = Colors.black
    ..radius = 20
    ..backgroundColor = Colors.transparent
    ..maskColor = Colors.white
    ..indicatorColor = const Color(0xff1f0a68)
    ..userInteractions = false
    ..dismissOnTap = false
    ..boxShadow = <BoxShadow>[]
    ..indicatorType = EasyLoadingIndicatorType.circle;
}


// void onTapGettingstarted(BuildContext context) {
//   Navigator.pushReplacement(context,
//       MaterialPageRoute(builder: (context) =>  QNAScreen()));
// }
