import 'package:beauty_tracker/services/background_service/task_key.dart';
import 'package:beauty_tracker/services/background_service/work_policy.dart';

abstract class BackgroundService {
  Future<void> initialize();
  Future<void> registerPeriodicTask({
    required TaskKey taskKey,
    Duration frequency = const Duration(hours: 24),
    WorkPolicy? workPolicy,
  });
  Future<void> registerOneOffTask({
    required TaskKey taskKey,
    Duration delay = Duration.zero,
    WorkPolicy? workPolicy,
  });
  Future<void> cancelAllTasks();
  Future<void> cancelTask(TaskKey taskKey);
}
