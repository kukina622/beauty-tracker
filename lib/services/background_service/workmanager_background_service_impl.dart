import 'package:beauty_tracker/services/background_service/background_service.dart';
import 'package:beauty_tracker/services/background_service/task_keys.dart';
import 'package:beauty_tracker/services/background_service/task_registry.dart';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

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
    required TaskKeys taskKey,
    required String taskName,
    Duration frequency = const Duration(hours: 24),
  }) async {
    await Workmanager().registerPeriodicTask(
      taskKey.key,
      taskName,
      frequency: frequency,
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
    required TaskKeys taskKey,
    required String taskName,
    Duration delay = Duration.zero,
  }) async {
    await Workmanager().registerOneOffTask(
      taskKey.key,
      taskName,
      initialDelay: delay,
    );
  }

  @override
  Future<void> cancelAllTasks() async {
    await Workmanager().cancelAll();
  }

  @override
  Future<void> cancelTask(TaskKeys taskKey) async {
    await Workmanager().cancelByUniqueName(taskKey.key);
  }

  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    Workmanager().executeTask((taskKey, inputData) async {
      final handler = TaskRegistry().getHandler(taskKey);
      if (handler != null) {
        try {
          return await handler(inputData);
        } catch (e) {
          return false;
        }
      } else {
        return false;
      }
    });
  }
}
