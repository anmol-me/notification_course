import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../main.dart';

class NotificationController extends ChangeNotifier {
  // Singleton Pattern
  static final NotificationController _instance =
      NotificationController._internal();

  factory NotificationController() => _instance;

  NotificationController._internal();

  Future<void> initializeLocalNotification({required bool debug}) async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: channelKey,
          channelName: 'Basic Notifications',
          channelDescription: 'channel_Description',
          importance: NotificationImportance.Max,
          // defaultPrivacy: NotificationPrivacy.Secret,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          enableVibration: true,
          defaultColor: Colors.redAccent,
          channelShowBadge: true,
          enableLights: true,
          // icon: 'resource://drawable/res_naruto',
          // playSound: true,
          // soundSource: 'resource://raw/naruto_jutsu',
        ),
      ],
      debug: debug,
    );
  }
}
