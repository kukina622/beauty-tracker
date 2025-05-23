import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';

abstract class LocalStorageService {
  Future<void> setString(LocalStorageKeys key, String value);
  Future<String?> getString(LocalStorageKeys key);
  Future<void> remove(LocalStorageKeys key);
  Future<void> setBool(LocalStorageKeys key, bool value);
  Future<bool?> getBool(LocalStorageKeys key);
  Future<void> setInt(LocalStorageKeys key, int value);
  Future<int?> getInt(LocalStorageKeys key);
  Future<void> setDouble(LocalStorageKeys key, double value);
  Future<double?> getDouble(LocalStorageKeys key);
}
