import 'package:beauty_tracker/services/background_service/background_service.dart';
import 'package:beauty_tracker/services/background_service/setup/background_di_setup.dart';
import 'package:beauty_tracker/services/background_service/task_key.dart';
import 'package:beauty_tracker/services/background_service/task_registry.dart';
import 'package:beauty_tracker/services/background_service/work_policy.dart';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskKeyString, inputData) async {
    try {
      final taskKey = TaskKeyHelper.fromString(taskKeyString);
      final taskHandler = TaskRegistry.getHandler(taskKey);
      if (taskHandler == null) {
        return false;
      }
      await setupBackgroundDependencies();

      return taskHandler(inputData);
    } catch (e) {
      return false;
    }
  });
}

class WorkmanagerBackgroundServiceImpl implements BackgroundService {
  @override
  Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );
  }

  @override
  Future<void> registerPeriodicTask({
    required TaskKey taskKey,
    required String taskName,
    Duration frequency = const Duration(hours: 24),
    WorkPolicy? workPolicy,
  }) async {
    await Workmanager().registerPeriodicTask(
      taskKey.key,
      taskName,
      frequency: frequency,
      existingWorkPolicy: workPolicy?.toWorkmanagerPolicy(),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      ),
    );
  }

  @override
  Future<void> registerOneOffTask({
    required TaskKey taskKey,
    required String taskName,
    Duration delay = Duration.zero,
    WorkPolicy? workPolicy,
  }) async {
    await Workmanager().registerOneOffTask(
      taskKey.key,
      taskName,
      initialDelay: delay,
      existingWorkPolicy: workPolicy?.toWorkmanagerPolicy(),
    );
  }

  @override
  Future<void> cancelAllTasks() async {
    await Workmanager().cancelAll();
  }

  @override
  Future<void> cancelTask(TaskKey taskKey) async {
    await Workmanager().cancelByUniqueName(taskKey.key);
  }
}
