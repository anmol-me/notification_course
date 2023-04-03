import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

const channelKey = 'basic_channel';

void main() {
  AwesomeNotifications().initialize(
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
    debug: true,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  scheduleNotification() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: channelKey,
        title: 'Simple Notification',
        bigPicture:
            "https://images.unsplash.com/photo-1555485898-0f23a85a607f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
        notificationLayout: NotificationLayout.BigPicture,
      ),
      /// Permission added to androidManifest for scheduling
      schedule: NotificationCalendar.fromDate(
        date: DateTime.now().add(
          const Duration(seconds: 30),
        ),
        preciseAlarm: true,
        // Battery hungry
        allowWhileIdle: true,
        // will bypass low battery
        repeats: true,
      ),
      /// Repeat
      // schedule: NotificationCalendar(
      //   second: 0,
      //   repeats: true,
      // ),
    );
  }

  cancelScheduleNotification(int id) async {
    await AwesomeNotifications().cancelSchedule(id);
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
              onPressed: scheduleNotification,
              child: const Text('Schedule Notification'),
            ),
            ElevatedButton(
              onPressed: () => cancelScheduleNotification(10),
              child: const Text('Cancel Schedule Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
