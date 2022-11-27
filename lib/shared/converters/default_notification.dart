import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter_fcm/shared/models/notification_message.dart';
import 'package:uuid/uuid.dart';

class DefaultNotifications {
  static NotificationMessage getNotification(RemoteMessage message) {
    var uuid = Uuid();

    if (kIsWeb) {
      return NotificationMessage(
          title: message.notification!.title,
          description: message.notification!.body,
          image: message.notification!.web!.image,
          sentAt: message.sentTime,
          id: message.messageId ?? uuid.v4().replaceAll('-', ''),
          from: message.from,
          data: message.data);
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return NotificationMessage(
            title: message.notification!.title,
            description: message.notification!.body,
            sentAt: message.sentTime,
            id: message.messageId,
            from: message.from,
            image: message.notification!.android!.imageUrl,
            data: message.data);
      case TargetPlatform.iOS:
        return NotificationMessage(
            title: message.notification!.title,
            description: message.notification!.body,
            sentAt: message.sentTime,
            id: message.messageId,
            from: message.from,
            image: message.notification!.apple!.imageUrl,
            data: message.data);
      default:
        throw UnsupportedError(
          'Notifications are not supported for this platform.',
        );
    }
  }
}
