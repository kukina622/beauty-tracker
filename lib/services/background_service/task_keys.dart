// If it is iOS, refer to https://github.com/fluttercommunity/flutter_workmanager/blob/main/IOS_SETUP.md
// Amend your AppDelegate.swift and Info.plist file to register your task ID
enum TaskKeys {
  expireNotifications,
}

extension TaskKeysExtension on TaskKeys {
  String get key {
    return name;
  }
}
