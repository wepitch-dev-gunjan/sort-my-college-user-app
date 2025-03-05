import 'dart:io';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/utils/navigation.dart';
import '../home_page/counsellor_page/counsellor_details_screen.dart';
import '../home_page/entrance_preparation/screens/announcement_screen.dart';
import '../webinar_page/widget/webinar_detail_page_widget.dart';
import 'local_notification.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  List<String> scopes = [
    "https://www.googleapis.com/auth/firebase.messaging",
    "https://www.googleapis.com/auth/firebase.database",
  ];

  Future<void> requestPermission() async {
    log("BaseURl==>>>${dotenv.env['BASEURL']}");

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      // AppSettings.openAppSettings(type: AppSettingsType.notification);
      log('User declined or has not accepted permission');
    }
  }

  Future<String?> getToken() async {
    String? token = await messaging.getToken();
    log('FCM TOKEN: $token');
    return token;
  }
}

class MessageService {
  static void firebaseInit() {
    log("Initializing Firebase Messaging...");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message title: ${message.notification?.title ?? "No title"}');
      log('Message body: ${message.notification?.body ?? "No body"}');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        if (Platform.isIOS) {
          forgroundMessage();
          LocalNotification().initializeLocalNotification(message);
        } else if (Platform.isAndroid) {
          LocalNotification().initializeLocalNotification(message);
          LocalNotification().sendNotification(message);
        }
      }
    });

    log("Firebase Messaging initialized.");
  }

  static Future<void> backgroudAndTerminateAppNavatior() async {
    // Ensure app is fully initialized before handling navigation
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // when app is terminated
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          handleNotificationNavigation(initialMessage);
        });
      }
    });

    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleNotificationNavigation(message);
    });
  }

  // foregorud state in Ios app
  static Future forgroundMessage() async {
    log("IOS Running");
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

// Function to handle navigation based on message type
void handleNotificationNavigation(RemoteMessage message) {
  if (message.data['type'] == 'webinar') {
    navigateTo(WebinarDetailsPageWidget(webinarId: message.data['id']));
  } else if (message.data['type'] == 'session') {
    navigateTo(CounsellorDetailsScreen(id: message.data['id']));
  } else if (message.data['type'] == 'announcement') {
    navigateTo(AnnouncementScreen(id: message.data['id']));
  } else if (message.data['type'] == 'session_booking') {
    navigateTo(const HomePageContainerAfterBooking());
  } else {
    navigateTo(const HomePageContainer());
  }
}
