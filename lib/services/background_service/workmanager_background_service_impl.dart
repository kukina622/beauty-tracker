import 'dart:io';

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
      final taskKey = await TaskKeyHelper.fromString(taskKeyString);
      final taskHandler = TaskRegistry.getHandler(taskKey);

      if (taskHandler == null) {
        return false;
      }

      // setup the background task dependencies
      // This is necessary to ensure that the dependencies are available in the background isolate.
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
    Duration frequency = const Duration(hours: 24),
    WorkPolicy? workPolicy,
    Duration initialDelay = Duration.zero,
  }) async {
    final key = await taskKey.key;
    await Workmanager().registerPeriodicTask(
      key,
      key,
      frequency: frequency,
      initialDelay: initialDelay,
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
    Duration initialDelay = Duration.zero,
    WorkPolicy? workPolicy,
  }) async {
    final key = await taskKey.key;

    // Because iOS does not support initialDelay for one-off tasks,
    // we register it as a processing task instead.
    if (Platform.isIOS) {
      await Workmanager().registerProcessingTask(
        key,
        key,
        initialDelay: initialDelay,
      );
      return;
    }

    await Workmanager().registerOneOffTask(
      key,
      key,
      initialDelay: initialDelay,
      existingWorkPolicy: workPolicy?.toWorkmanagerPolicy(),
    );
  }

  @override
  Future<void> cancelAllTasks() async {
    await Workmanager().cancelAll();
  }

  @override
  Future<void> cancelTask(TaskKey taskKey) async {
    final key = await taskKey.key;
    await Workmanager().cancelByUniqueName(key);
  }
}
