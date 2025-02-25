// ignore_for_file: unnecessary_null_comparison
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myapp/home_page/help_screen.dart';
import 'package:myapp/page-1/splash_screen_n.dart';
import 'package:myapp/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../notifications/notification_handler.dart';
import '../../other/api_service.dart';
import '../../page-1/account_delete.dart';
import '../homepagecontainer.dart';

class Drawer1 extends StatefulWidget {
  const Drawer1({super.key});

  @override
  State<Drawer1> createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {
  String path = '';
  String name = "";
  String appVersion = '';
  @override
  void initState() {
    getAllInfo();
    _getAppVersion();
    super.initState();
  }

  void getAllInfo() async {
    ApiService.get_profile().then((value) => loadDefaultValue());
  }

  Future<void> _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }

  void loadDefaultValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "N/A";
    if (prefs.getString("profile_pic") == null) {
      // load local pic
      path = prefs.getString("profile_pic_local")!;
    } else {
      path = prefs.getString("profile_pic") ?? "N/A";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      width: width * 0.63,
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
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/page-1/images/profilepic.jpg',
                                  fit: BoxFit.cover,
                                ),
                                if (path != null)
                                  Image.network(
                                    path,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.none,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return const SizedBox();
                                    },
                                  ),
                              ],
                            ),
                          ),
                        )
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
                      color: const Color(0xff1F0A68),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      leading: const Icon(
                        Icons.home_outlined,
                        size: 28,
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpScreen()));
                    },
                    leading: const Icon(
                      Icons.help_outline,
                      size: 28,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text('Alert!'),
                        content: const Text('Are you sure to logout!'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),

                          // TextButton(
                          //   onPressed: () async {
                          //     // Fetch the list of followed counsellors
                          //     var followedCounsellors =
                          //         await ApiService.getUserFollowing();

                          //     // Perform unsubscription in the background
                          //     Future.microtask(() async {
                          //       List<Future<void>> unsubscriptionFutures = [];

                          //       for (var counselor in followedCounsellors) {
                          //         if (counselor.containsKey('id')) {
                          //           String topic =
                          //               "counsellor_${counselor['id']}";
                          //           unsubscriptionFutures
                          //               .add(TopicManager.unsubscribe(topic));
                          //         }
                          //       }

                          //       // Unsubscribe from "smc_users"
                          //       unsubscriptionFutures
                          //           .add(TopicManager.unsubscribe("smc_users"));

                          //       // Wait for unsubscriptions to complete
                          //       await Future.wait(unsubscriptionFutures);

                          //       log("All topics unsubscribed successfully");
                          //     });

                          //     // Proceed with logout immediately
                          //     await _logout();
                          //     if (mounted) {
                          //       Navigator.pushReplacement(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 const SplashScreenNew()),
                          //       );
                          //     }
                          //   },
                          //   child: const Text('Logout'),
                          // )

                          // TextButton(
                          //   onPressed: () async {
                          //     await _logout();
                          //     if (mounted) {
                          //       Navigator.pushReplacement(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   const SplashScreenNew()));
                          //     }
                          //   },
                          //   child: const Text('Logout'),
                          // ),

                          TextButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              // 🔹 Get subscribed topics before removing them
                              List<String> subscribedTopics =
                                  prefs.getStringList('subscribedTopics') ?? [];

                              await prefs.remove('subscribedTopics');
                              await prefs.remove('allTopics');

                              // 🔹 Perform logout
                              await _logout();

                              // 🔹 Navigate to the new screen
                              if (mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashScreenNew()),
                                );
                              }

                              // 🔹 Perform unsubscription in the background after navigation
                              Future.microtask(() async {
                                List<Future<void>> unsubscriptionFutures =
                                    subscribedTopics
                                        .map((topic) =>
                                            TopicManager.unsubscribe(topic))
                                        .toList();

                                await Future.wait(unsubscriptionFutures);

                                log("✅ All subscribed topics unsubscribed");
                              });
                            },
                            child: const Text('Logout'),
                          )
                        ],
                      );
                    },
                  );
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    size: 28,
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
              width: width * 0.57,
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'App Version: $appVersion',
                style: SafeGoogleFont(
                  "Inter",
                  fontSize: 13.0,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear user session
  }
}
