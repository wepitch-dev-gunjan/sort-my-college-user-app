import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myapp/notifications/notification_service.dart';

class LocalNotification {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Android and iOS initialization settings
  AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('@drawable/logo');

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
        handleNotificationNavigation(message);
      });

      log("Local notification initialized successfully.");
    } catch (e) {
      log("Error initializing local notification: $e");
    }
  }

  // Method to send or show notifications
  Future<void> sendNotification(RemoteMessage message) async {
    try {
      // log("Preparing to send notification...");
      // log("Message data: ${message.data}");
      // log("Notification title: ${message.notification?.title}");
      // log("Notification body: ${message.notification?.body}");
      // log("Notification body: ${message.notification?.android}");

      // const String customSound = 'alert';
      // AndroidNotificationSound loadSound =
      //     const RawResourceAndroidNotificationSound(customSound);
      // Android notification channel setup
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.data['channelId'] ?? 'default_channel',
        message.data['channelId'] ?? 'default_channel',
        importance: Importance.high,
        showBadge: true,
        playSound: true,
        enableVibration: true,
        // sound: loadSound,
      );

      // Android notification details
      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        channel.id,
        channel.name,
        // channelDescription: 'Your channel description',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        ticker: 'ticker',
        icon: '@drawable/logo',
        // sound: loadSound,
        // vibrationPattern: Int64List.fromList([0, 500, 1000, 500]),
      );

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
