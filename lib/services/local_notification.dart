import 'package:awesome_notifications/awesome_notifications.dart';

import '../main.dart';

class LocalNotification {
  static Future<void> createBasicNotificationWithPayload() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: channelKey,
        title: 'This is basic notification',
        body: 'Go to temp screen',
        payload: {
          'screen_name': 'TEMP_SCREEN',
        },
      ),
    );
  }
// static Future<void> createBasicNotificationWithPayload() async {}
}
