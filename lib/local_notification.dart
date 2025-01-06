// String logoName = 'mipmap/ic_iauncher';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/navigation.dart';

String logoName = 'logo';

class LocalNotification {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Android and iOS initialization settings
  AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('@drawable/logo');
  // AndroidInitializationSettings androidInitializationSettings =
  //      AndroidInitializationSettings(logoName);

  final DarwinInitializationSettings _iosSetting =
      const DarwinInitializationSettings();

  // Initialization method for local notifications
  Future<void> initializeLocalNotification(RemoteMessage message) async {
    log("Initializing local notification...");

    // Initialization settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings, iOS: _iosSetting);

    try {
      // Use initialization settings in the plugin
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (payload) {
        navigateTo(const Notification2());
      });

      log("Local notification initialized successfully.");
    } catch (e) {
      log("Error initializing local notification: $e");
    }
  }

  // Method to send or show notifications
  Future<void> sendNotification(RemoteMessage message) async {
    try {
      log("Preparing to send notification...");
      log("Message data: ${message.data}");
      log("Notification title: ${message.notification?.title}");
      log("Notification body: ${message.notification?.body}");

      // Android notification channel setup
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification?.android?.channelId ?? 'default_channel',
        message.notification?.android?.channelId ?? 'Default Channel',
        importance: Importance.max,
        showBadge: true,
        playSound: true,
      );

      // Android notification details
      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: 'Your channel description',
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
              ticker: 'ticker',
              icon: '@drawable/logo');

      // iOS notification details
      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      // Notification details
      final NotificationDetails notificationDetails =
          NotificationDetails(android: androidDetails, iOS: iosDetails);

      // Show notification
      await _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? "Default Title",
        message.notification?.body ?? "Default Body",
        notificationDetails,
      );

      log("Notification sent successfully.");
    } catch (e) {
      log("Error sending notification: $e");
    }
  }
}


// class LocalNotifaication {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   //   initalize the android or ios drawin setting
//   // final AndroidInitializationSettings _androidSetting =
//   //     AndroidInitializationSettings(logoName);
//   AndroidInitializationSettings androidInitializationSettings =
//       const AndroidInitializationSettings('@mipmap/ic_launcher');

//   final DarwinInitializationSettings _iosSetting =
//       const DarwinInitializationSettings();

//   // // Initaliztion Mehtod for Local Notificaion
//   initailzeLocalNotifcation(RemoteMessage message) async {
//     //   initalize setting instace  2. assign android or ios setting to this instace
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: androidInitializationSettings, iOS: _iosSetting);

//     // use this initalize setting to flutterlocalnoticationplugin
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (payload) {
//       // handle interaction or navigate to user to screen when app is active for android

//       // navigateCallScreen(message);
//     });
//   }

//   // // Send or show Notifation mehtod
//   sendNotification(RemoteMessage message) async {
//     log("${message.notification!.title.toString()}");

//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//       message.notification!.android!.channelId.toString(),
//       message.notification!.android!.channelId.toString(),
//       importance: Importance.max,
//       showBadge: true,
//       playSound: true,
//       // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')
//     );
//     //  create android or ios notificationDetails
//     final AndroidNotificationDetails andoridDetais = AndroidNotificationDetails(
//       channel.id.toString(),
//       channel.name.toString(),
//       channelDescription: 'your channel description',
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//       ticker: 'ticker',
//       sound: channel.sound,
//       fullScreenIntent: false, // Important for full-screen behavior
//       actions: [
//         // const AndroidNotificationAction('accept_action', 'Accept',
//         //     titleColor: Colors.blue),
//         // const AndroidNotificationAction('decline_action', 'Decline',
//         //     titleColor: Colors.red),
//       ],
//     );

//     // for ios details
//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     // define android or ios notificaton detils to NotifcationDetials Instace
//     final NotificationDetails notificationDetails =
//         NotificationDetails(android: andoridDetais, iOS: iosDetails);

//     try {
//       await _flutterLocalNotificationsPlugin.show(
//         0,
//         message.notification!.title.toString(),
//         message.notification!.body.toString(),
//         notificationDetails,
//       );
//       // await navigateCallScreen(message);
//     } catch (err) {}
//   }
// }

// // user navaifation or show to call scree
// navigateCallScreen(RemoteMessage message) async {
//   dynamic data = message.data;
//   return navigateTo(NotificationScreen(data: data));
// }
