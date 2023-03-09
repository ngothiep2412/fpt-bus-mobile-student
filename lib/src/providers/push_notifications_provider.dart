import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PushNotificationsProvider {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  void initPushNotifications() async {
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void onMessageListener(BuildContext context) async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('NEW NOTIFICATION');
      }
    });
    // PRIMER PLANO
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('NEW NOTIFICATION IN FOREGROUND');
      showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification!.body != null) {
        Get.toNamed('/navigation/home/notifications');
      }
    });
  }

  void showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      String sentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(
        DateTime.fromMillisecondsSinceEpoch(
          message.sentTime?.millisecondsSinceEpoch ??
              DateTime.now().millisecondsSinceEpoch,
        ),
      );

      // Add the sent time to the notification body
      String notificationBody = '${notification.body} - Sent at: $sentTime';

      plugin.show(
        notification.hashCode,
        notification.title,
        notificationBody,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }
}
