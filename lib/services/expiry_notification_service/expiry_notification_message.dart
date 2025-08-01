import 'package:beauty_tracker/models/expiry_notification_record.dart';

class ExpiryNotificationMessage {
  ExpiryNotificationMessage({
    required this.title,
    required this.body,
    required this.type,
  });

  factory ExpiryNotificationMessage.fromType(
    ExpiryNotificationType type, {
    required String productName,
  }) {
    switch (type) {
      case ExpiryNotificationType.thirtyDays:
        return ExpiryNotificationMessage(
          title: '美妝品過期通知',
          body: '您的美妝品 $productName 即將於30天內到期，請注意使用期限！',
          type: type,
        );
      case ExpiryNotificationType.sevenDays:
        return ExpiryNotificationMessage(
          title: '美妝品過期通知',
          body: '您的美妝品 $productName 即將於7天內到期，請盡快使用！！',
          type: type,
        );
      case ExpiryNotificationType.today:
        return ExpiryNotificationMessage(
          title: '美妝品過期通知',
          body: '您的美妝品 $productName 今天將到期，請立即處理！！！',
          type: type,
        );
    }
  }
  String title;
  String body;
  ExpiryNotificationType type;
}
