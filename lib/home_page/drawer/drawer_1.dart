// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/home_page/drawer/image_saved_screen.dart';
import 'package:myapp/home_page/help_screen.dart';
import 'package:myapp/home_page/homepage.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/page-1/splash_screen_2.dart';
import 'package:myapp/page-1/splash_screen_n.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homepagecontainer.dart';

class Drawer1 extends StatefulWidget {
  const Drawer1({super.key});

  @override
  State<Drawer1> createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {
  String path = '';
  String name = "";

  @override
  void initState() {
    getAllInfo();
    super.initState();
  }

  void getAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    path = prefs.getString("profile_image_path") ?? " ";
    name = prefs.getString("name") ?? "N/A";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 262,
      backgroundColor: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 164,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: path != " "
                                ? Image.file(File(path), fit: BoxFit.cover)
                                :  Image.asset(
                              'assets/page-1/images/profilepic.jpg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                  name,
                    style: SafeGoogleFont(
                      "Inter",
                      color: Color(0xff1F0A68),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      //Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePageContainer()));
                    },
                    child: ListTile(
                      leading: Image.asset(
                        'assets/page-1/images/Home1.png',
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        "Home",
                        style: SafeGoogleFont(
                          "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      shape: Border(
                          bottom: BorderSide(
                        color: Colors.black.withOpacity(0.09),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: Column(
            //     children: [
            //       ListTile(
            //         leading: Image.asset(
            //           'assets/page-1/images/help.jpg',
            //           height: 20,
            //           width: 20,
            //           fit: BoxFit.cover,
            //         ),
            //         title: Text(
            //           "About Us",
            //           style: SafeGoogleFont(
            //             "Inter",
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         shape: Border(
            //             bottom: BorderSide(
            //           color: Colors.black.withOpacity(0.09),
            //         )),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpScreen()));
                    },
                    leading: Image.asset(
                      'assets/page-1/images/Question.jpg',
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      "Help?",
                      style: SafeGoogleFont(
                        "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    shape: Border(
                        bottom: BorderSide(
                      color: Colors.black.withOpacity(0.09),
                    )),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 14.0),
            //   child: Column(
            //     children: [
            //       ListTile(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       const FeedScreen(name: '', id: '')));
            //         },
            //         leading: Image.asset(
            //           'assets/page-1/images/test 1.png',
            //           height: 20,
            //           width: 20,
            //           fit: BoxFit.cover,
            //         ),
            //         title: Text(
            //           "Psychometric Test",
            //           style: SafeGoogleFont(
            //             "Inter",
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         shape: Border(
            //             bottom: BorderSide(
            //           color: Colors.black.withOpacity(0.09),
            //         )),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Alert!'),
                        content: const Text('Are you sure to logout!'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                            onPressed: () async {
                              await _logout();
                              if (mounted) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SplashScreenNew()));
                              }
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ListTile(
                  leading: Image.asset(
                    'assets/page-1/images/logout1.jpg',
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Log out',
                    style: SafeGoogleFont(
                      "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  shape: Border(
                    bottom: BorderSide(
                      color: Colors.black.withOpacity(0.09),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/page-1/images/sortmycollege-logo-1.png",
              height: 61,
              width: 229,
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Future _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreenNew()),
        (route) => false,
      );
    }
  }
}
// Container(
// padding: EdgeInsets.fromLTRB(
// 23 * fem, 2 * fem, 0 * fem, 0 * fem),
// height: double.infinity,
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// GestureDetector(
// onTap: () {
// EasyLoading.showToast("",
// toastPosition:
// EasyLoadingToastPosition.bottom);
// },
// child: Container(
// margin: EdgeInsets.fromLTRB(
// 0 * fem, 0 * fem, 23 * fem, 0 * fem),
// padding: EdgeInsets.fromLTRB(
// 15 * fem, 4 * fem, 9 * fem, 6 * fem),
// width: 110 * fem,
// height: 114 * fem,
// clipBehavior: Clip.antiAlias,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(5),
// boxShadow: [
// BoxShadow(
// offset: const Offset(0, 4),
// blurRadius: 4,
// color: Colors.black.withOpacity(0.1),
// ),
// ],
// ),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.center,
// children: [
// Expanded(
// child: Container(
// margin: EdgeInsets.fromLTRB(0 * fem,
// 0 * fem, 0 * fem, 7 * fem),
// width: double.infinity,
// height: 62 * fem,
// child: Stack(
// children: [
// Align(
// child: SizedBox(
// width: 72 * fem,
// height: 55 * fem,
// child: TextButton(
// onPressed: () {},
// style: TextButton.styleFrom(
// padding: EdgeInsets.zero,
// ),
// child: Container(),
// ),
// ),
// ),
// Align(
// child: SizedBox(
// width: 82 * fem,
// height: 58 * fem,
// child: Image.asset(
// 'assets/page-1/images/untitled-design-6-1.png',
// fit: BoxFit.cover,
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// Container(
// margin: EdgeInsets.fromLTRB(
// 0 * fem, 0 * fem, 7 * fem, 0 * fem),
// child: Text(
// 'Entrance \nPreparation',
// textAlign: TextAlign.center,
// style: SafeGoogleFont(
// 'Inter',
// fontSize: 12 * ffem,
// fontWeight: FontWeight.w700,
// height: 1.2125 * ffem / fem,
// color: const Color(0xff000000),
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// TextButton(
// onPressed: () {
// EasyLoading.showToast("Coming Soon",
// toastPosition:
// EasyLoadingToastPosition.bottom);
// },
// style: TextButton.styleFrom(
// padding: EdgeInsets.zero,
// ),
// child: Container(
// padding: EdgeInsets.fromLTRB(
// 20 * fem, 8 * fem, 20 * fem, 13 * fem),
// width: 110 * fem,
// height: 114 * fem,
// clipBehavior: Clip.antiAlias,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(5),
// boxShadow: [
// BoxShadow(
// offset: const Offset(0, 4),
// blurRadius: 4,
// color: Colors.black.withOpacity(0.1),
// ),
// ],
// ),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.center,
// children: [
// Container(
// margin: EdgeInsets.fromLTRB(
// 0 * fem, 0 * fem, 0 * fem, 9 * fem),
// width: 68 * fem,
// height: 66 * fem,
// child: Image.asset(
// 'assets/page-1/images/mask-group-SbT.png',
// width: 68 * fem,
// height: 66 * fem,
// ),
// ),
// Container(
// margin: EdgeInsets.fromLTRB(
// 0 * fem, 0 * fem, 1 * fem, 0 * fem),
// child: Text(
// 'Connect',
// textAlign: TextAlign.center,
// style: SafeGoogleFont(
// 'Inter',
// fontSize: 12 * ffem,
// fontWeight: FontWeight.w700,
// height: 1.2125 * ffem / fem,
// color: const Color(0xff000000),
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// ),
