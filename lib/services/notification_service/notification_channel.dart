import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationChannels {
  static const String general = 'general_notifications';
  static const String expiring = 'beauty_expiring_soon';

  // 頻道詳細資訊
  static const Map<String, NotificationChannelInfo> channelInfo = {
    general: NotificationChannelInfo(
      id: general,
      name: '一般通知',
      description: '應用程式的一般通知',
      importance: Importance.defaultImportance,
    ),
    expiring: NotificationChannelInfo(
      id: expiring,
      name: '美妝品即將過期通知',
      description: '美妝品過期提醒通知',
      importance: Importance.high,
    ),
  };
}

class NotificationChannelInfo {
  const NotificationChannelInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.importance,
  });
  final String id;
  final String name;
  final String description;
  final Importance importance;
}
