
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:myapp/home_page/entrance_preparation/screens/visit_profile_page.dart';

class DeepLinkHandler {
  final BuildContext context;
  late final AppLinks _appLinks;

  DeepLinkHandler(this.context);

  void init() async {
    _appLinks = AppLinks();

    _appLinks.uriLinkStream.listen(
      (Uri? uri) {
        log("Received URI: $uri");
        _handleIncomingLink(uri);
      },
      onError: (err) {
        log("Error in link stream: $err");
      },
    );

    // Handle initial deep link when the app launches
    try {
      final initialUri = await _appLinks.getInitialLink();
      log("Initial URI: $initialUri");
      _handleIncomingLink(initialUri);
    } catch (e) {
      log("Error in getting initial link: $e");
    }
  }

  void _handleIncomingLink(Uri? uri) {

    if (uri != null && uri.pathSegments.isNotEmpty) {
      final String type = uri.pathSegments[0]; // 'counsellor' ya 'ep'
      final String? id =
          uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;

      if (id != null) {
        if (type == 'counsellor') {
          // Counsellor ke liye navigate karega
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => CounsellorProfilePage(
          //       id: id,
          //     ),
          //   ),
          // );
        } else if (type == 'ep') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VisitProfilePage(
                id: id,
              ),
            ),
          );
        } else {
          log("URI type not recognized: $type");
        }
      } else {
        log("ID is missing in the URI.");
      }
    } else {
      log("URI doesn't match expected path or is null.");
    }
  }
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
