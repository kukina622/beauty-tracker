enum LocalStorageKeys {
  userEmail,
}

extension LocalStorageKeysExtension on LocalStorageKeys {
  String get key {
    return name;
  }
}
