import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';

abstract class LocalStorageService {
  Future<void> setString(LocalStorageKeys storageKey, String value);
  Future<String?> getString(LocalStorageKeys storageKey);
  Future<void> remove(LocalStorageKeys storageKey);
  Future<void> setBool(LocalStorageKeys storageKey, bool value);
  Future<bool?> getBool(LocalStorageKeys storageKey);
  Future<void> setInt(LocalStorageKeys storageKey, int value);
  Future<int?> getInt(LocalStorageKeys storageKey);
  Future<void> setDouble(LocalStorageKeys storageKey, double value);
  Future<double?> getDouble(LocalStorageKeys storageKey);
}
