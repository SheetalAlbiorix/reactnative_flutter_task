// This file will handle the setup and display of notifications.

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // const initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        /*onSelectNotification: onSelectNotification*/);

    // Request notification permissions
    await _requestNotificationPermission();
  }

  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.request().isGranted) {
      // Permission is granted, you can show notifications.
    } else {
      // Permission is not granted, handle accordingly (e.g., show an explanation dialog).
    }
  }

  Future<void> showNotification() async {
    print("Attempting to show notification...");

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id', // Change this to a unique channel ID
      'Channel Name', // Change this to a descriptive channel name
      // 'Channel Description',
      // Change this to a descriptive channel description, comment this line for flutter_local_notification ^9.0.0
      importance: Importance.high,
      priority: Priority.high,
    );
    // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics,
    );

    try {
      await _flutterLocalNotificationsPlugin.show(
        0, // Change this to a unique notification ID
        'Notification Title',
        'Notification Body',
        platformChannelSpecifics,
        payload: 'Custom Payload',
      );
      print("Notification displayed successfully!");
    } catch (e) {
      print("Error displaying notification: $e");
    }
  }

  Future<void> onSelectNotification(String? payload) async {
    // Handle the tapped notification here (if needed).
  }
}
