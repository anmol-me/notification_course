import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notification_course/temp_screen.dart';

import '../main.dart';

navigateHelper(ReceivedAction receivedAction) {
  if (receivedAction.payload != null &&
      receivedAction.payload!['screen_name'] == 'TEMP_SCREEN') {
    MyApp.navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => const TempScreen(),
      ),
    );
  }
}

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

  static Future<void> initializeNotificationsEventListeners() async {
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    bool isSilent = receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction;

    var message =
        "${isSilent ? 'Silent Action' : 'Acton'} notification received";

    log(message);

    navigateHelper(receivedAction);

    if (receivedAction.buttonKeyPressed == 'SUBSCRIBE') {
      log('Subscribe action button was pressed');
    } else if (receivedAction.buttonKeyPressed == 'DISMISS') {
      log('Dismiss action button was pressed');
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedAction,
  ) async {
    log('Notification created');

    Fluttertoast.showToast(
      msg: 'Notification created',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedAction,
  ) async {
    log('Notification displayed');

    Fluttertoast.showToast(
      msg: 'Notification displayed',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    log('Notification dismiss');

    Fluttertoast.showToast(
      msg: 'Notification dismiss',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static Future<void> getInitialNotification() async {
    ReceivedAction? receivedAction =
        await AwesomeNotifications().getInitialNotificationAction(
      removeFromActionEvents: true,
    );

    if (receivedAction == null) return;

    navigateHelper(receivedAction);
  }
}
