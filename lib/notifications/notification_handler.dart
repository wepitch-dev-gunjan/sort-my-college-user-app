import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../firebase_options.dart';
import 'notification_service.dart';

class NotificationHandler {
  static Future<void> initializeNotifications() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await NotificationServices().requestPermission();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    MessageService.forgroundMessage();
    MessageService.firebaseInit();
    MessageService.backgroudAndTerminateAppNavatior();

    // await NotificationServices().getAccessToken();
    await NotificationServices().getToken();
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log("📩 Background message received: ${message.messageId}");
  }
}

class TopicManager {
  /// Subscribe to a specific topic
  static Future<void> subscribe(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic).then((_) {
      log("✅ Successfully subscribed to topic: $topic");
    }).catchError((error) {
      log("❌ Error subscribing to topic: $error");
    });
  }

  /// Unsubscribe from a specific topic
  static Future<void> unsubscribe(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic).then((_) {
      log("✅ Successfully unsubscribed from topic: $topic");
    }).catchError((error) {
      log("❌ Error unsubscribing from topic: $error");
    });
  }
}
