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

  /// PROGRESS BAR NOTIFICATION
  static Future<void> showIndeterminateProgressNotification(int id) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: 'Downloading pdf...',
        body: 'file.pdf',
        payload: {'file': 'file.pdf'},
        category: NotificationCategory.Progress,
        notificationLayout: NotificationLayout.ProgressBar,
        progress: null,
        locked: true,
      ),
    );

    await Future.delayed(const Duration(seconds: 5));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: 'Download finished',
        body: 'file.pdf',
        category: NotificationCategory.Progress,
        locked: false,
      ),
    );
  }

  static int currentStep = 0;

  static Future<void> showProgressNotification(int id) async {
    int maxStep = 10;

    for (int stimulatedStep = 0;
        stimulatedStep <= maxStep + 1;
        stimulatedStep++) {
      currentStep = stimulatedStep;

      await Future.delayed(const Duration(seconds: 1));

      _updateCurrentProgressBar(
        id: id,
        stimulatedStep: stimulatedStep,
        maxStep: maxStep,
      );
    }
  }

  static void _updateCurrentProgressBar({
    required int id,
    required int stimulatedStep,
    required int maxStep,
  }) {
    // Finished
    if (stimulatedStep > maxStep) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: 'Download finished',
          body: 'file.pdf',
          category: NotificationCategory.Progress,
          locked: false,
        ),
      );
    }
    // in-Progress
    else {
      int progress = min((stimulatedStep / maxStep * 100).round(), 100);

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: 'Downloading pdf in progress ($progress%)',
          body: 'file.pdf',
          payload: {'file': 'file.pdf'},
          category: NotificationCategory.Progress,
          notificationLayout: NotificationLayout.ProgressBar,
          progress: progress,
          locked: true,
        ),
      );
    }
  }

  /// Emoji Notification
  static Future<void> showEmojiNotification(int id) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: 'Emoji -> 😍',
        body: '${Emojis.activites_firecracker} Boom!',
        category: NotificationCategory.Social,
      ),
    );
  }

  /// Wake Up Notification
  // Wake up permission added
  static Future<void> showWakeUpNotification(int id) async {
    await Future.delayed(const Duration(seconds: 5));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: 'Hey Wake up',
        body: 'Sleepy!',
        wakeUpScreen: true,
      ),
    );
  }
}
