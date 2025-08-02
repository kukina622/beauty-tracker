enum LocalStorageKeys {
  userEmail,
  isFirstVisit,

  // Notifications
  thirtyDayExpiryNotificationEnabled,
  sevenDayExpiryNotificationEnabled,
  todayExpiryNotificationEnabled,
}

extension LocalStorageKeysExtension on LocalStorageKeys {
  String get key {
    return name;
  }
}
