// String logoName = 'mipmap/ic_iauncher';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myapp/home_page/notification_page/noti.dart';
import 'package:myapp/utils/navigation.dart';
import 'package:myapp/webinar_page/widget/webinar_detail_page_widget.dart';

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
        log("${message.data['type']}");

        if (message.data['type'] == 'webinar') {
          log("${message.data['id']}");
          navigateTo(WebinarDetailsPageWidget(webinarId: message.data['id']));

          
        }
        else{
            navigateTo(const Notification2());
        }
      
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

      // Notificati on details
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
