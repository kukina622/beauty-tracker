import 'package:beauty_tracker/services/background_service/background_service.dart';
import 'package:beauty_tracker/services/background_service/task_key.dart';
import 'package:beauty_tracker/services/background_service/work_policy.dart';
import 'package:beauty_tracker/services/expiry_notification_service/expiry_notification_handler.dart';

class ExpiryNotificationService {
  ExpiryNotificationService({
    required this.backgroundService,
  });

  final BackgroundService backgroundService;

  Future<void> initialize() async {
    await backgroundService.registerPeriodicTask(
      taskKey: TaskKey.expireNotifications,
      frequency: const Duration(hours: 24),
      workPolicy: WorkPolicy.keep,
    );
  }

  Future<void> stop() async {
    await backgroundService.cancelTask(TaskKey.expireNotifications);
  }

  Future<void> triggerManualCheck() async {
    await ExpiryNotificationHandler.handle(null);
  }
}
