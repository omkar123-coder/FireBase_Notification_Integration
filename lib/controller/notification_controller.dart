import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math' as math;

class NotificationController {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static AndroidNotificationChannel get channel => AndroidNotificationChannel(
    'high_importance_channel_v2',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification'),
  );


  static AndroidNotificationDetails get notificationDetails => AndroidNotificationDetails(
    'high_importance_channel_v2',
    'High Importance Notifications',
    channelDescription: 'This channel is used for important notifications.',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    ongoing: true,
    sound: RawResourceAndroidNotificationSound('notification'),
  );

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    final androidPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    androidPlugin?.createNotificationChannel(channel);

    log((await FirebaseMessaging.instance.getToken()).toString(), name: 'DeviceId');
  }

  static Future<void> showLocalNotification(RemoteMessage message) async {

    NotificationDetails platformDetails = NotificationDetails(
      android: notificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      math.Random().nextInt(1000),
      message.notification?.title,
      message.notification?.body,
      platformDetails,
      payload: jsonEncode(message.data),
    );
  }
}