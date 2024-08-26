// import 'package:flutter/material.dart';
// import 'package:myapp/other/api_service.dart';
// import 'package:myapp/utils.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../other/constants.dart';
// import 'otp.dart';
// import 'package:flutter/services.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   _Signup createState() => _Signup();
// }

// class _Signup extends State<Signup> {
//   final _nameController = TextEditingController();
//   final phonecontroller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     configLoading();
//   }

//   // bool isLoading = false;
//   void onTapGettingstarted(BuildContext context, String email) async {
//     await EasyLoading.show(
//       status: "Loading...",
//       dismissOnTap: false,
//     );

//     ApiService.callVerifyOtp(email).then((value) async {
//       print(value);

//       if (value["message"] == "Email sent successfully") {
//         EasyLoading.showToast(value["message"],
//             toastPosition: EasyLoadingToastPosition.bottom);
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString("name", _nameController.text.toString());
//         if (!mounted) return;
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => Otp(email)));
//       } else if (value["error"] == "Something went wrong!") {
//         EasyLoading.showToast(
//           "404 Page Not Found!",
//           toastPosition: EasyLoadingToastPosition.bottom,
//         );
//       } else {
//         EasyLoading.showToast(value["error"],
//             toastPosition: EasyLoadingToastPosition.bottom);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 430;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;
//     return Material(
//       type: MaterialType.transparency,
//       child: Container(
//         // signupUAD (437:25)
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           color: Color(0xffffffff),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 // autogroupgkwwc1X (AXy7wVdzv9LSi1ZVtyGKww)
//                 padding: EdgeInsets.fromLTRB(
//                     65 * fem, 148 * fem, 71 * fem, 49 * fem),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffffffff),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(50 * fem),
//                     topRight: Radius.circular(50 * fem),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       // sortmycollegelogo1tjj (437:29)
//                       margin: EdgeInsets.fromLTRB(
//                           0 * fem, 0 * fem, 0 * fem, 24 * fem),
//                       width: 294 * fem,
//                       height: 80 * fem,
//                       child: Image.asset(
//                         'assets/page-1/images/sortmycollege-logo-1-cZX.png',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     // Container(
//                     //   // sortyourentirecollegejourney1Z (437:30)
//                     //   margin: EdgeInsets.fromLTRB(
//                     //       22 * fem, 0 * fem, 0 * fem, 0 * fem),
//                     //   child: Text(
//                     //     'All in one platform for student',
//                     //     textAlign: TextAlign.center,
//                     //     style: SafeGoogleFont(
//                     //       'Roboto',
//                     //       fontSize: 16 * ffem,
//                     //       fontWeight: FontWeight.w700,
//                     //       height: 1.1725 * ffem / fem,
//                     //       color: const Color(0xff1f0a68),
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               Container(
//                 // autogroupltfbWFK (AXy8yJFgfd4aiSGkjeLtfb)
//                 padding:
//                     EdgeInsets.fromLTRB(60 * fem, 50 * fem, 60 * fem, 51 * fem),
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       // autogroups3swDQd (AXy84jvvc4rqKvoPDJs3sw)
//                       margin: EdgeInsets.fromLTRB(
//                           0 * fem, 0 * fem, 0 * fem, 20 * fem),
//                       padding: EdgeInsets.fromLTRB(
//                           15 * fem, 15 * fem, 15 * fem, 13 * fem),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: const Color(0xff000000)),
//                         color: const Color(0xffffffff),
//                         borderRadius: BorderRadius.circular(10 * fem),
//                       ),
//                       child: SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           controller: _nameController,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(40),
//                           ],
//                           decoration: const InputDecoration(
//                             hintStyle:
//                                 TextStyle(color: Colors.black, fontSize: 15.0),
//                             hintText: "Enter Your Full Name",
//                             border: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                           ),
//                           style: SafeGoogleFont(
//                             'Roboto',
//                             fontSize: 18 * ffem,
//                             fontWeight: FontWeight.w400,
//                             height: 1.1810 * ffem / fem,
//                             color: const Color(0xff000000),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // autogrouprbz9U5f (AXy8AQS9uGhFg15ZzJrBz9)
//                       margin: EdgeInsets.fromLTRB(
//                           0 * fem, 0 * fem, 0 * fem, 20 * fem),
//                       padding: EdgeInsets.fromLTRB(
//                           15 * fem, 15 * fem, 15 * fem, 13 * fem),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: const Color(0xff000000)),
//                         color: const Color(0xffffffff),
//                         borderRadius: BorderRadius.circular(10 * fem),
//                       ),
//                       child: SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           controller: phonecontroller,
//                           keyboardType: TextInputType.emailAddress,
//                           // keyboardType: TextInputType.phone, changed for testing purpose
//                           inputFormatters: const [
//                             // LengthLimitingTextInputFormatter(10),changed for testing purpose
//                           ],
//                           decoration: const InputDecoration(
//                             hintStyle:
//                                 TextStyle(color: Colors.black, fontSize: 15.0),
//                             hintText: "Enter Your Email",
//                             border: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                           ),
//                           style: SafeGoogleFont(
//                             'Roboto',
//                             fontSize: 18 * ffem,
//                             fontWeight: FontWeight.w400,
//                             height: 1.1525 * ffem / fem,
//                             color: const Color(0xff000000),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         if (check_val()) {
//                           onTapGettingstarted(
//                               context, phonecontroller.text.toString());
//                         }
//                       },
//                       child: Container(
//                         // autogroupbjvs8AD (AXy8Fjcc4e4weRaT58bjVs)p
//                         margin: EdgeInsets.fromLTRB(
//                             0 * fem, 0 * fem, 0 * fem, 20 * fem),
//                         width: double.infinity,
//                         height: 45 * fem,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: const Color(0xff000000)),
//                           color: const Color(0xff1f0a68),
//                           borderRadius: BorderRadius.circular(10 * fem),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Generate OTP',
//                             textAlign: TextAlign.center,
//                             style: SafeGoogleFont(
//                               'Roboto',
//                               fontSize: 18 * ffem,
//                               fontWeight: FontWeight.w400,
//                               height: 1.1725 * ffem / fem,
//                               color: const Color(0xffffffff),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // onTapGettingstarted_login(context);
//                       },
//                       child: Container(
//                         // alreadyhaveanaccountsigninygd (437:58)
//                         margin: EdgeInsets.fromLTRB(
//                             0 * fem, 0 * fem, 8 * fem, 48 * fem),
//                         constraints: BoxConstraints(
//                           maxWidth: 216 * fem,
//                         ),
//                         child: RichText(
//                           textAlign: TextAlign.center,
//                           text: TextSpan(
//                             style: SafeGoogleFont(
//                               'Inter',
//                               fontSize: 15 * ffem,
//                               fontWeight: FontWeight.w400,
//                               height: 1.5303726196 * ffem / fem,
//                               color: const Color(0xff000000),
//                             ),
//                             children: [
//                               TextSpan(
//                                 text: 'Already have an account?\n',
//                                 style: SafeGoogleFont(
//                                   'Roboto',
//                                   fontSize: 17 * ffem,
//                                   fontWeight: FontWeight.w400,
//                                   height: 1.4826653059 * ffem / fem,
//                                   color: const Color(0xff000000),
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: 'Log in',
//                                 style: SafeGoogleFont(
//                                   'Roboto',
//                                   fontSize: 18 * ffem,
//                                   fontWeight: FontWeight.w700,
//                                   height: 1.4826653059 * ffem / fem,
//                                   color: const Color(0xff000000),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Container(
//                     //   // autogroupeuimZoF (AXy8Lu8ff6DGS2BgJsEUiM)
//                     //   margin: EdgeInsets.fromLTRB(
//                     //       13 * fem, 0 * fem, 20 * fem, 28 * fem),
//                     //   width: double.infinity,
//                     //   child: Row(
//                     //     crossAxisAlignment: CrossAxisAlignment.center,
//                     //     children: [
//                     //       Container(
//                     //         // rectangle63hPf (437:39)
//                     //         margin: EdgeInsets.fromLTRB(
//                     //             0 * fem, 3 * fem, 14 * fem, 0 * fem),
//                     //         width: 70 * fem,
//                     //         height: 1 * fem,
//                     //         decoration: BoxDecoration(
//                     //           borderRadius: BorderRadius.circular(10 * fem),
//                     //           color: const Color(0xffffffff),
//                     //         ),
//                     //       ),
//                     //       // Container(
//                     //       //   // orcontinuewithE8h (437:37)
//                     //       //   margin: EdgeInsets.fromLTRB(
//                     //       //       0 * fem, 0 * fem, 16 * fem, 0 * fem),
//                     //       //   child: Text(
//                     //       //     'or continue with',
//                     //       //     style: SafeGoogleFont(
//                     //       //       'Roboto',
//                     //       //       fontSize: 15 * ffem,
//                     //       //       fontWeight: FontWeight.w400,
//                     //       //       height: 1.1725 * ffem / fem,
//                     //       //       color: const Color(0xff000000),
//                     //       //     ),
//                     //       //   ),
//                     //       // ),
//                     //       Container(
//                     //         // rectangle64wJ1 (437:41)
//                     //         margin: EdgeInsets.fromLTRB(
//                     //             0 * fem, 3 * fem, 0 * fem, 0 * fem),
//                     //         width: 40 * fem,
//                     //         height: 1 * fem,
//                     //         decoration: BoxDecoration(
//                     //           borderRadius: BorderRadius.circular(10 * fem),
//                     //           color: const Color(0xffffffff),
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     // Container(
//                     //   // autogroupzamprA5 (AXy8VtsgJeezWcGv1dZamP)
//                     //   margin: EdgeInsets.fromLTRB(
//                     //       13 * fem, 0 * fem, 20 * fem, 0 * fem),
//                     //   width: double.infinity,
//                     //   height: 44 * fem,
//                     //   child: Row(
//                     //     crossAxisAlignment: CrossAxisAlignment.center,
//                     //     children: [
//                     //       Container(
//                     //         // autogroupu7mkxyo (AXy8c4N5JcBWRAE4Ktu7mK)
//                     //         margin: EdgeInsets.fromLTRB(
//                     //             0 * fem, 0 * fem, 37 * fem, 0 * fem),
//                     //         padding: EdgeInsets.fromLTRB(
//                     //             21 * fem, 13 * fem, 21 * fem, 12 * fem),
//                     //         width: 120 * fem,
//                     //         height: double.infinity,
//                     //         decoration: BoxDecoration(
//                     //           border:
//                     //           Border.all(color: const Color(0xff000000)),
//                     //           color: const Color(0xffffffff),
//                     //           borderRadius: BorderRadius.circular(10 * fem),
//                     //         ),
//                     //         child: Container(
//                     //           // group53kM (437:48)
//                     //           padding: EdgeInsets.fromLTRB(
//                     //               0 * fem, 0 * fem, 0.64 * fem, 0 * fem),
//                     //           width: double.infinity,
//                     //           height: double.infinity,
//                     //           child: Row(
//                     //             crossAxisAlignment: CrossAxisAlignment.end,
//                     //             children: [
//                     //               Container(
//                     //                 // googley8D (437:51)
//                     //                 margin: EdgeInsets.fromLTRB(
//                     //                     0 * fem, 0 * fem, 5 * fem, 1 * fem),
//                     //                 width: 18 * fem,
//                     //                 height: 18 * fem,
//                     //                 child: Image.asset(
//                     //                   'assets/page-1/images/google.png',
//                     //                   width: 18 * fem,
//                     //                   height: 18 * fem,
//                     //                 ),
//                     //               ),
//                     //               Container(
//                     //                 // googlesearchengineicon1g2d (437:49)
//                     //                 margin: EdgeInsets.fromLTRB(
//                     //                     0 * fem, 0 * fem, 0 * fem, 0.42 * fem),
//                     //                 width: 49.36 * fem,
//                     //                 height: 15.38 * fem,
//                     //                 child: Image.asset(
//                     //                   'assets/page-1/images/googlesearch-engineicon-1.png',
//                     //                   width: 49.36 * fem,
//                     //                   height: 15.38 * fem,
//                     //                 ),
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         ),
//                     //       ),
//                     //       Container(
//                     //         // autogroupsf29ynR (AXy8hohVtGdcMeT52SSf29)
//                     //         padding: EdgeInsets.fromLTRB(
//                     //             27 * fem, 12 * fem, 26.94 * fem, 11 * fem),
//                     //         width: 120 * fem,
//                     //         height: double.infinity,
//                     //         decoration: BoxDecoration(
//                     //           border:
//                     //           Border.all(color: const Color(0xff000000)),
//                     //           color: const Color(0xffffffff),
//                     //           borderRadius: BorderRadius.circular(10 * fem),
//                     //         ),
//                     //         child: SizedBox(
//                     //           // group46c9 (437:43)
//                     //           width: double.infinity,
//                     //           height: double.infinity,
//                     //           child: Row(
//                     //             crossAxisAlignment: CrossAxisAlignment.start,
//                     //             children: [
//                     //               Container(
//                     //                 // groupedf (437:44)
//                     //                 margin: EdgeInsets.fromLTRB(
//                     //                     0 * fem, 0 * fem, 8.24 * fem, 0 * fem),
//                     //                 width: 12.82 * fem,
//                     //                 height: 18.2 * fem,
//                     //                 child: Image.asset(
//                     //                   'assets/page-1/images/group.png',
//                     //                   width: 12.82 * fem,
//                     //                   height: 18.2 * fem,
//                     //                 ),
//                     //               ),
//                     //               Text(
//                     //                 // applemCV (437:47)
//                     //                 'Apple',
//                     //                 textAlign: TextAlign.center,
//                     //                 style: SafeGoogleFont(
//                     //                   'Prompt',
//                     //                   fontSize: 14 * ffem,
//                     //                   fontWeight: FontWeight.w400,
//                     //                   height: 1.4818750109 * ffem / fem,
//                     //                   color: const Color(0xff000000),
//                     //                 ),
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /*void onTapGettingstarted_login(BuildContext context) {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => const Login()));
//   }*/

//   bool validateMobile(String value) {
//     String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//     RegExp regExp = RegExp(patttern);
//     if (!regExp.hasMatch(value)) {
//       return true;
//     }
//     return false;
//   }

//   bool check_val() {
//     bool isvaluevalid = true;
//     if (_nameController.text.toString().trim().isEmpty) {
//       EasyLoading.showToast(AppConstants.fullnameerror,
//           toastPosition: EasyLoadingToastPosition.bottom);
//       isvaluevalid = false;
//     } else if (phonecontroller.text.toString().trim().isEmpty) {
//       EasyLoading.showToast(AppConstants.phoneerror,
//           toastPosition: EasyLoadingToastPosition.bottom);
//       isvaluevalid = false;
//     }

//     // else if (validateMobile(phonecontroller.text.toString().trim())) {
//     //   EasyLoading.showToast(AppConstants.phonenotvalid,
//     //       toastPosition: EasyLoadingToastPosition.bottom);
//     //   isvaluevalid = false;
//     // } // changed for testing purposes

//     return isvaluevalid;
//   }

//   void configLoading() {
//     EasyLoading.instance
//       ..displayDuration = const Duration(milliseconds: 2000)
//       ..loadingStyle = EasyLoadingStyle.custom
//       ..indicatorSize = 60
//       ..textColor = Colors.black
//       ..radius = 20
//       ..backgroundColor = Colors.transparent
//       ..maskColor = Colors.white
//       ..indicatorColor = const Color(0xff1f0a68)
//       ..userInteractions = false
//       ..dismissOnTap = false
//       ..boxShadow = <BoxShadow>[]
//       ..indicatorType = EasyLoadingIndicatorType.circle;
//   }
// }
