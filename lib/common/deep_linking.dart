import 'dart:developer';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:myapp/home_page/entrance_preparation/screens/visit_profile_page.dart';
import 'package:myapp/page-1/splash_screen_n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page/counsellor_page/counsellor_details_screen.dart';


class DeepLinkHandler {
  final BuildContext context;
  late final AppLinks _appLinks;

  DeepLinkHandler(this.context);

  void init() async {
    _appLinks = AppLinks();

    // Listen for real-time deep links
    _appLinks.uriLinkStream.listen(
      (Uri? uri) {
        if (uri != null) {
          log("Received URI: $uri");
          _handleIncomingLink(uri);
        } else {
          log("Received a null URI.");
        }
      },
      onError: (err) {
        log("Error in link stream: $err");
      },
    );

    // Handle the initial deep link when the app launches
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        log("Initial URI: $initialUri");
        _handleIncomingLink(initialUri);
      } else {
        log("No initial URI received.");
      }
    } catch (e) {
      log("Error in getting initial link: $e");
    }
  }

  void _handleIncomingLink(Uri? uri) async {
    // Check login status
    final bool isLoggedIn = await isUserLoggedIn();
    log("Is User Logged In: $isLoggedIn");

    if (!isLoggedIn) {
      // Redirect to Login Screen if not logged in
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SplashScreenNew(), // Your login screen widget
          ),
        );
      } else {
        log("Context is not mounted. Skipping navigation.");
      }
      return;
    }

    // Handle the URI if user is logged in
    if (uri != null && uri.pathSegments.isNotEmpty) {
      final String type = uri.pathSegments[0]; // 'counsellor' or 'ep'
      final String? id =
          uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;

      log("URI Path Segments: ${uri.pathSegments}");
      log("Type: $type, ID: $id");

      if (id != null) {
        if (type == 'counsellor') {
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CounsellorDetailsScreen(id: id),
              ),
            );
          } else {
            log("Context is not mounted. Skipping navigation.");
          }
        } else if (type == 'ep') {
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VisitProfilePage(id: id),
              ),
            );
          } else {
            log("Context is not mounted. Skipping navigation.");
          }
        } else {
          log("URI type not recognized: $type");
        }
      } else {
        log("ID is missing in the URI.");
      }
    } else {
      log("URI doesn't match expected path or is null.");
      // Optionally navigate to a default screen if URI is invalid
      // if (context.mounted) {
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => const DefaultScreen()), // Your default screen
      //   );
      // }
    }
  }
}

Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool("authLogin") ?? false; // Default: false
}


// import 'dart:async';
// import 'package:app_links/app_links.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// class AppLinksDeepLink {
//   AppLinksDeepLink._privateConstructor();

//   static final AppLinksDeepLink _instance = AppLinksDeepLink._privateConstructor();

//   static AppLinksDeepLink get instance => _instance;

//   late AppLinks _appLinks;
//   StreamSubscription<Uri>? _linkSubscription;

//   @override
//   void onInit() {
//     super.onInit();
//     _appLinks = AppLinks();
//     initDeepLinks();
//   }

//   Future<void> initDeepLinks() async {
//     // Check initial link if app was in cold state (terminated)
//     final appLink = await _appLinks.getInitialLink();
//     if (appLink != null) {
//       var uri = Uri.parse(appLink.toString());
//       print(' here you can redirect from url as per your need ');
//     }

//     // Handle link when app is in warm state (front or background)
//     _linkSubscription = _appLinks.uriLinkStream.listen((uriValue) {
//       print(' you will listen any url updates ');
//       print(' here you can redirect from url as per your need ');
//     },onError: (err){
//       debugPrint('====>>> error : $err');
//     },onDone: () {
//       _linkSubscription?.cancel();
//     },);
//   }
// }
