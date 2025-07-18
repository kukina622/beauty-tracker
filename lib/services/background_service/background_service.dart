import 'package:beauty_tracker/services/background_service/task_key.dart';
import 'package:beauty_tracker/services/background_service/work_policy.dart';

abstract class BackgroundService {
  Future<void> initialize();
  Future<void> registerPeriodicTask({
    required TaskKey taskKey,
    Duration frequency = const Duration(hours: 24),
    WorkPolicy? workPolicy,
    Duration initialDelay = Duration.zero,
  });
  Future<void> registerOneOffTask({
    required TaskKey taskKey,
    Duration initialDelay = Duration.zero,
    WorkPolicy? workPolicy,
  });
  Future<void> cancelAllTasks();
  Future<void> cancelTask(TaskKey taskKey);
}

Duration calculateInitialDelay(int hour, int minute) {
  final now = DateTime.now();
  var scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);

  if (scheduledTime.isBefore(now)) {
    scheduledTime = scheduledTime.add(Duration(days: 1));
  }

  return scheduledTime.difference(now);
}
