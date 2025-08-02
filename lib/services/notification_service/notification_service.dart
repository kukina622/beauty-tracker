abstract class NotificationService {
  Future<void> initialize();

  Future<bool> requestPermissions();

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? channelId,
  });
}
