// If it is iOS, refer to https://github.com/fluttercommunity/flutter_workmanager/blob/main/IOS_SETUP.md
// Amend your AppDelegate.swift and Info.plist file to register your task ID
import 'package:collection/collection.dart';

enum TaskKey {
  expireNotifications,
}

extension TaskKeysExtension on TaskKey {
  String get key {
    return name;
  }
}

class TaskKeyHelper {
  static TaskKey? fromString(String key) {
    return TaskKey.values.firstWhereOrNull(
      (taskKey) => taskKey.key == key,
    );
  }
}
