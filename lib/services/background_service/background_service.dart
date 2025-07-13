import 'package:beauty_tracker/services/background_service/task_keys.dart';

abstract class BackgroundService {
  Future<void> initialize();
  Future<void> registerPeriodicTask({
    required TaskKeys taskKey,
    required String taskName,
    Duration frequency = const Duration(hours: 24),
  });
  Future<void> registerOneOffTask({
    required TaskKeys taskKey,
    required String taskName,
    Duration delay = Duration.zero,
  });
  Future<void> cancelAllTasks();
  Future<void> cancelTask(TaskKeys taskKey);
}
