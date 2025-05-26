enum LocalStorageKeys {
  userEmail,
  isFirstVisit,
}

extension LocalStorageKeysExtension on LocalStorageKeys {
  String get key {
    return name;
  }
}
