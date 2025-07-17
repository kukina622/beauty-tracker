import 'package:beauty_tracker/services/background_service/background_service.dart';
import 'package:beauty_tracker/services/background_service/task_key.dart';
import 'package:beauty_tracker/services/expiry_notification_service/expiry_notification_handler.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_service.dart';
import 'package:get_it/get_it.dart';

class ExpiryNotificationService {
  ExpiryNotificationService(this._backgroundService);

  final BackgroundService _backgroundService;

  /// 初始化到期通知服務
  Future<void> initialize() async {
    final localStorage = GetIt.instance<LocalStorageService>();

    // 檢查是否已經註冊過任務
    final isTaskRegistered =
        await localStorage.getBool(LocalStorageKeys.expiryNotificationTaskRegistered) ?? false;

    // 只有在未註冊過時才註冊背景任務
    if (!isTaskRegistered) {
      await _backgroundService.registerPeriodicTask(
        taskKey: TaskKey.expireNotifications,
        taskName: 'Check Expiring Products',
        frequency: const Duration(hours: 24),
      );

      // 標記任務已註冊
      await localStorage.setBool(LocalStorageKeys.expiryNotificationTaskRegistered, true);
    }
  }

  /// 停止到期通知服務
  Future<void> stop() async {
    final localStorage = GetIt.instance<LocalStorageService>();

    await _backgroundService.cancelTask(TaskKey.expireNotifications);

    // 清除註冊標記，允許重新註冊
    await localStorage.setBool(LocalStorageKeys.expiryNotificationTaskRegistered, false);
  }

  /// 重置服務（清除註冊狀態，用於測試或重新配置）
  Future<void> reset() async {
    final localStorage = GetIt.instance<LocalStorageService>();
    await localStorage.setBool(LocalStorageKeys.expiryNotificationTaskRegistered, false);
  }

  /// 手動觸發檢查（用於測試）
  Future<void> triggerManualCheck() async {
    await ExpiryNotificationHandler.handle(null);
  }
}
