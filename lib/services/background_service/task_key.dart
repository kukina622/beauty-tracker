// If it is iOS, refer to https://github.com/fluttercommunity/flutter_workmanager/blob/main/IOS_SETUP.md
// Amend your AppDelegate.swift and Info.plist file to register your task ID
import 'package:beauty_tracker/app_info.dart';
import 'package:collection/collection.dart';

enum TaskKey {
  todayExpiryNotification,
  dailyExpireNotificationScheduler,
}

extension TaskKeysExtension on TaskKey {
  Future<String> get key async {
    final appId = await AppInfo.getApplicationId();
    return '$appId.$name';
  }
}

class TaskKeyHelper {
  static Future<TaskKey?> fromString(String key) async {
    final appId = await AppInfo.getApplicationId();
    final prefix = '$appId.';
    
    if (!key.startsWith(prefix)) {
      return null;
    }
    
    final taskName = key.substring(prefix.length);
    return TaskKey.values.firstWhereOrNull(
      (taskKey) => taskKey.name == taskName,
    );
  }
}
