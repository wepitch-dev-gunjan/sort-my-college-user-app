import 'package:flutter/material.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/page-1/otp_screen_new.dart';
import 'package:myapp/phone/login_screen_n.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../other/constants.dart';
import 'package:flutter/services.dart';

class SignupScreenNew extends StatefulWidget {
  const SignupScreenNew({super.key});

  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<SignupScreenNew> {
  final _nameController = TextEditingController();
  final phonecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    configLoading();
  }

  // bool isLoading = false;
  void onTapGettingstarted(BuildContext context, String phoneNumber) async {
    if (!isChecked) {
      EasyLoading.showToast(
        'Please accept terms and conditions',
        toastPosition: EasyLoadingToastPosition.bottom,
      );
      return;
    }

    await EasyLoading.show(
      dismissOnTap: false,
    );

    ApiService.callVerifyOtpByPhone(phoneNumber).then((value) async {
      print(value);

      if (value["message"]["description"] == "Message in progress") {
        EasyLoading.showToast(value["message"]["description"],
            toastPosition: EasyLoadingToastPosition.bottom);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("name", _nameController.text.toString());
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OtpScreenNew(phoneNumber)));
      } else {
        EasyLoading.showToast(value["message"]["description"],
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
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
              const Text(
                'Please enter your details and we will',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Text(
                'text you a code which will allow',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Text(
                'you to log in!',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        60 * fem, 32 * fem, 60 * fem, 51 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          padding: EdgeInsets.fromLTRB(
                              15 * fem, 15 * fem, 15 * fem, 13 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorsConst.appBarColor,
                            ),
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          child: SizedBox(
                            height: 20,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: _nameController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(40),
                              ],
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.black54, fontSize: 15.0),
                                hintText: "Full Name",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.1810 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          padding: EdgeInsets.fromLTRB(
                              15 * fem, 15 * fem, 15 * fem, 13 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorsConst.appBarColor,
                            ),
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          child: SizedBox(
                            height: 20,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: phonecontroller,
                              keyboardType: TextInputType.phone,
                              // keyboardType: TextInputType.phone, changed for testing purpose
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(14),
                              ],
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.black54, fontSize: 15.0),
                                hintText: "Phone Number",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.1525 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: 8,
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                'I accept terms and conditions',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (check_val()) {
                                onTapGettingstarted(
                                    context, phonecontroller.text.toString());
                              }
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
                        const Divider(
                            color: Colors.black, endIndent: 60, indent: 60),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 17 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.4826653059 * ffem / fem,
                                color: const Color(0xff1f0a68),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreenNew()));
                              },
                              child: Text(
                                'Log in',
                                style: SafeGoogleFont(
                                  'Roboto',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4826653059 * ffem / fem,
                                  color: const Color(0xff000000),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  bool check_val() {
    bool isvaluevalid = true;
    if (_nameController.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.fullnameerror,
          toastPosition: EasyLoadingToastPosition.bottom);
      isvaluevalid = false;
    } else if (phonecontroller.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.phoneerror,
          toastPosition: EasyLoadingToastPosition.bottom);
      isvaluevalid = false;
    }

    return isvaluevalid;
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
}
