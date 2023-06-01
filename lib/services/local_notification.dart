import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

import '../main.dart';

int createUniqueId(int maxValue) => Random().nextInt(maxValue);

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

  /// CHAT NOTIFICATION

  static Future<void> createMessagingNotification({
    required String channelKey,
    required String groupKey,
    required String chatName,
    required String username,
    required String message,
    String? largeIcon,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(AwesomeNotifications.maxID),
        groupKey: groupKey,
        channelKey: channelKey,
        summary: chatName,
        title: username,
        body: message,
        largeIcon: largeIcon,
        notificationLayout: NotificationLayout.MessagingGroup,
        category: NotificationCategory.Message,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'REPLY',
          label: 'Reply',
          requireInputText: true,
          autoDismissible: false,
        ),
        NotificationActionButton(
          key: 'READ',
          label: 'Mark as Read',
          autoDismissible: true,
        )
      ],
    );
  }
}
