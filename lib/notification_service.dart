import 'dart:developer';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/navigation.dart';
import 'local_notification.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  List<String> scopes = [
    "https://www.googleapis.com/auth/firebase.messaging",
    "https://www.googleapis.com/auth/firebase.database",
  ];

  Future<void> requestPermission() async {
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
      AppSettings.openAppSettings();
      log('User declined or has not accepted permission');
    }
  }

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({}), scopes);

    final accessToken = client.credentials.accessToken.data;
    log("ACCESS Token =>>$accessToken");
    return accessToken;
  }

  Future<String?> getToken() async {
    String? token = await messaging.getAPNSToken();
    log('FCM TOKEN: $token');
    return token;
  }
}

class MessageService {
  static void firebaseInit() {
    log("Initializing Firebase Messaging...");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        log('Got a message whilst in the foreground!');
        log('Message title: ${message.notification?.title ?? "No title"}');
        log('Message body: ${message.notification?.body ?? "No body"}');
        log('Message data: ${message.data}');
      }

      if (message.notification != null) {
        if (Platform.isIOS) {
          forgroundMessage();
        }

        if (Platform.isAndroid) {
          LocalNotification().initializeLocalNotification(message);
          LocalNotification().sendNotification(message);
        }
      }
    });

    log("Firebase Messaging initialized.");
  }

  //handle  tap or navigation user  on notification when app is in background or terminated
  static Future<void> backgroudAndTerminateAppNavatior() async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      navigateTo(const Notification2());
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      navigateTo(const Notification2());
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



// class MessageServiece {
//   static void firebaseInit() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         log('Got a message whilst in the foreground!');
//         log('Message title: ${message.notification?.title}');
//         log('Message body: ${message.notification?.body}');
//       }

//       if (message.notification != null) {
//         log('Start${message.notification}');
//         LocalNotifaication().sendNotification(message);
//         log('Notification displayed.');
//       }
//     });
//   }
// }
