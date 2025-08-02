import 'package:beauty_tracker/constants.dart';
import 'package:beauty_tracker/services/background_service/background_service.dart';
import 'package:beauty_tracker/services/background_service/task_key.dart';
import 'package:beauty_tracker/services/background_service/work_policy.dart';
import 'package:get_it/get_it.dart';

class ExpiryNotificationScheduler {
  static Future<bool> handle(Map<String, dynamic>? inputData) async {
    try {
      final backgroundService = GetIt.instance<BackgroundService>();

      final now = DateTime.now();

      final today18pm = DateTime(
        now.year,
        now.month,
        now.day,
        AppConstants.dailyExpiryReminderHour,
        AppConstants.dailyExpiryReminderMinute,
      );

      DateTime targetTime;

      if (now.isAfter(today18pm)) {
        targetTime = today18pm.add(const Duration(days: 1));
      } else {
        targetTime = today18pm;
      }

      final delay = targetTime.difference(now);

      await backgroundService.registerOneOffTask(
        taskKey: TaskKey.todayExpiryNotification,
        initialDelay: delay,
        workPolicy: WorkPolicy.replace,
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
