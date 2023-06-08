import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotification {
  final String title;
  final String body;

  CustomNotification({
    required this.title,
    required this.body,
  });
}
class NotificationManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int notificationId = 0;

  Future<void> init() async {
    // Request permission for receiving notifications
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    // Configure the notification handler and initialize the notification plugin
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Handle notifications received in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        final customNotification = CustomNotification(
          title: 'Custom Notification Title',
          body: 'This is a custom notification',
        );
        showNotification(customNotification);
      }
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    //await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  Future<void> showNotification(CustomNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'school security id',
      'school',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Cancel previous notifications before showing a new one
    await _flutterLocalNotificationsPlugin.cancelAll();

    // Show the latest notification
    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      notification.title,
      notification.body,
      platformChannelSpecifics,
    );
    notificationId++;
  }
}
