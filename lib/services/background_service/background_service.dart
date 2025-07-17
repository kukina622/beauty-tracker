import 'package:beauty_tracker/services/background_service/task_key.dart';

abstract class BackgroundService {
  Future<void> initialize();
  Future<void> registerPeriodicTask({
    required TaskKey taskKey,
    required String taskName,
    Duration frequency = const Duration(hours: 24),
  });
  Future<void> registerOneOffTask({
    required TaskKey taskKey,
    required String taskName,
    Duration delay = Duration.zero,
  });
  Future<void> cancelAllTasks();
  Future<void> cancelTask(TaskKey taskKey);
}
