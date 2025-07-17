import 'package:beauty_tracker/services/background_service/background_service.dart';
import 'package:beauty_tracker/services/background_service/task_key.dart';
import 'package:beauty_tracker/services/expiry_notification_service/expiry_notification_handler.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_service.dart';

class ExpiryNotificationService {
  ExpiryNotificationService({
    required this.backgroundService,
    required this.localStorageService,
  });

  final BackgroundService backgroundService;
  final LocalStorageService localStorageService;

  Future<void> initialize() async {
    final isTaskRegistered =
        await localStorageService.getBool(LocalStorageKeys.expiryNotificationTaskRegistered) ??
            false;

    if (!isTaskRegistered) {
      await backgroundService.registerPeriodicTask(
        taskKey: TaskKey.expireNotifications,
        taskName: 'Check Expiring Products',
        frequency: const Duration(hours: 24),
      );

      await localStorageService.setBool(LocalStorageKeys.expiryNotificationTaskRegistered, true);
    }
  }

  Future<void> stop() async {
    await backgroundService.cancelTask(TaskKey.expireNotifications);

    await localStorageService.setBool(LocalStorageKeys.expiryNotificationTaskRegistered, false);
  }

  Future<void> reset() async {
    await localStorageService.setBool(LocalStorageKeys.expiryNotificationTaskRegistered, false);
  }

  Future<void> triggerManualCheck() async {
    await ExpiryNotificationHandler.handle(null);
  }
}
