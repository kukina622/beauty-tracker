enum LocalStorageKeys {
  userEmail,
  isFirstVisit,
  expiryNotificationTaskRegistered,
}

extension LocalStorageKeysExtension on LocalStorageKeys {
  String get key {
    return name;
  }
}
