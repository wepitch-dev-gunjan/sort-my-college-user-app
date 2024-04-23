import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/page-1/otp_screen_new.dart';
import 'package:myapp/page-1/otp_screen_new_login.dart';
import 'package:myapp/page-1/sign_up_screen_new.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import '../other/constants.dart';

class LoginScreenNew extends StatefulWidget {
  static String verify = '';

  const LoginScreenNew({Key? key}) : super(key: key);

  @override
  _LoginScreenNewState createState() => _LoginScreenNewState();
}

class _LoginScreenNewState extends State<LoginScreenNew> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    //configLoading();
  }

  var phone = '';
  bool isLoading = false;
  String code = '';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    var mHeight = MediaQuery.sizeOf(context).height;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/page-1/images/Group 627.png',
                fit: BoxFit.cover,
                height: 250,
              ),
              const SizedBox(height: 10,),
              const Text(
                'Let’s get you started!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              SizedBox(
                height: mHeight * 0.04,
              ),
              const Text(
                ' Your phone number will be your\npassword, we will send you a code\n on your mobile device which will',
                style: TextStyle(fontSize: 14),
              ),
              const Text(
                'allow you to login!',
                style: TextStyle(fontSize: 14),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(60 * fem, 37 * fem, 60 * fem, 91 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogrouprbz9U5f (AXy8AQS9uGhFg15ZzJrBz9)
                      margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
                      padding: EdgeInsets.fromLTRB(
                          15 * fem, 15 * fem, 15 * fem, 13 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorsConst.appBarColor,),
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10 * fem),
                      ),
                      child: SizedBox(
                        height: 30,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          // keyboardType: TextInputType.phone, changed for testing purpose
                          inputFormatters:  [
                            LengthLimitingTextInputFormatter(14),
                          ],
                          decoration: const InputDecoration(
                            hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 15.0),
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
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       value: isChecked,
                    //       overlayColor: MaterialStatePropertyAll(Color(0xff1F0A68)),
                    //       onChanged: (value) {
                    //         setState(() {
                    //           isChecked = value!;
                    //         });
                    //       },
                    //     ),
                    //     const Text(
                    //       'I accept terms and conditions',
                    //       style: TextStyle(
                    //           fontSize: 14, fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 18,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (check_val()) {
                            onTapGettingstarted(
                                context, phoneController.text.toString());
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
                        child: const Text('Log In',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(color: Colors.black, endIndent: 60, indent: 60),
                    SizedBox(
                      height: mHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account? ',
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.4826653059 * ffem / fem,
                            color: const Color(0xff000000),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreenNew()));
                          },
                          child: Text(
                            'Sign up',
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 17 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.4826653059 * ffem / fem,
                              color: const Color(0xff1F0A68),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     launchUrlString(
                    //         'https://sortmycollege.com/terms-and-conditions/');
                    //   },
                    //   child: Text(
                    //     "By continuing , I agree with the Terms and Conditions , Privacy Policy",
                    //     style: SafeGoogleFont(
                    //       "Roboto",
                    //       fontSize: 10,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapGettingstarted(BuildContext context, String phoneNumber) async {
    await EasyLoading.show(
      dismissOnTap: false,
    );

    ApiService.callVerifyOtpByPhone(phoneNumber).then((value) async {
      print(value);

      if (value["message"]["description"] == "Message in progress") {
        EasyLoading.showToast(value["message"]["description"],
            toastPosition: EasyLoadingToastPosition.bottom);
        if (!mounted) return;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OtpScreenNewLogin(phoneNumber)));
      } else {
        EasyLoading.showToast(value["message"]["description"],
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }


  // void onTapGettingstarted(BuildContext context, String phone) async {
  //   await EasyLoading.show(
  //     status: "Loading...",
  //     dismissOnTap: false,
  //   );
  //
  //   ApiService.callVerifyOtp(phone).then((value) async {
  //     print(value);
  //
  //     if (value["message"] == "Email sent successfully") {
  //       EasyLoading.showToast(value["message"],
  //           toastPosition: EasyLoadingToastPosition.bottom,);
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString("name", nameController.text.toString());
  //       if (!mounted) return;
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => const PhoneOtpScreenNew()));
  //     } else if (value["error"] == "Something went wrong!") {
  //       EasyLoading.showToast(
  //         "404 Page Not Found!",
  //         toastPosition: EasyLoadingToastPosition.bottom,
  //       );
  //     } else {
  //       EasyLoading.showToast(value["error"],
  //           toastPosition: EasyLoadingToastPosition.bottom);
  //     }
  //   });
  // }

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
     if (phoneController.text.toString().trim().isEmpty) {
      EasyLoading.showToast(AppConstants.phoneerror,
          toastPosition: EasyLoadingToastPosition.bottom);
      isvaluevalid = false;
    }
    return isvaluevalid;
  }

  // bool check_val() {
  //   bool isvaluevalid = true;
  //
  //   if (nameController.text.toString().trim().isEmpty) {
  //     EasyLoading.showToast(AppConstants.USER_EMAIL,
  //         toastPosition: EasyLoadingToastPosition.bottom);
  //     isvaluevalid = false;
  //   } else if (phoneController.text.toString().trim().isEmpty) {
  //     EasyLoading.showToast(AppConstants.phoneerror,
  //         toastPosition: EasyLoadingToastPosition.bottom);
  //     isvaluevalid = false;
  //   } else if (validateMobile(phoneController.text.toString().trim())) {
  //     EasyLoading.showToast(AppConstants.phonenotvalid,
  //         toastPosition: EasyLoadingToastPosition.bottom);
  //     isvaluevalid = false;
  //   }
  //
  //   return isvaluevalid;
  // }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60
      ..textColor = Colors.black
      ..radius = 20
      ..backgroundColor = Colors.transparent
      ..maskColor = Colors.white
      ..indicatorColor = Color(0xff1f0a68)
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[]
      ..indicatorType = EasyLoadingIndicatorType.circle;
  }

  bool isEmail(String em) {
    bool isvaluevalid = false;
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(em)) {
      isvaluevalid = true;
    } else {
      EasyLoading.showToast(AppConstants.valid_email,
          toastPosition: EasyLoadingToastPosition.bottom);
      isvaluevalid = false;
    }
    return isvaluevalid;
  }
}
