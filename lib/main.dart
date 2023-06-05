import 'dart:async';

import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:notification_course/services/local_notification.dart';
import 'package:notification_course/services/notification_controller.dart';

const channelKey = 'basic_channel';
const channelChatKey = 'chat_channel';
const channelChatGroupKey = 'chat_group_channel';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController().initializeLocalNotification(debug: true);
  await NotificationController.initializeNotificationsEventListeners();

  scheduleMicrotask(() async {
    await NotificationController.getInitialNotification();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  LocalNotification.showIndeterminateProgressNotification(19),
              child: const Text('Show indefinite progress'),
            ),
            ElevatedButton(
              onPressed: () => LocalNotification.showProgressNotification(2),
              child: const Text('Show Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
