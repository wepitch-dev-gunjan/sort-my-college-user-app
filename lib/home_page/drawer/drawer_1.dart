// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/home_page/help_screen.dart';
import 'package:myapp/page-1/splash_screen_n.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  void initState() {
    getAllInfo();
    super.initState();
  }

  void getAllInfo() async {
    ApiService.get_profile().then((value) => loadDefaultValue());
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
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
              width: width * 0.57,
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Future _accountDelete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await EasyLoading.show(
      dismissOnTap: false,
    );

    Future.delayed(const Duration(seconds: 1), () async {
      await prefs.clear();
      EasyLoading.dismiss();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AccountDelete()),
          (route) => false,
        );
      }
    });
  }

  Future _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AccountDelete()),
        (route) => false,
      );
    }
  }
}
