import 'package:awesome_notifications/awesome_notifications.dart';

import '../main.dart';

class LocalNotification {
  static scheduleNotification() async {
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

  static cancelScheduleNotification(int id) async {
    await AwesomeNotifications().cancelSchedule(id);
  }
}
