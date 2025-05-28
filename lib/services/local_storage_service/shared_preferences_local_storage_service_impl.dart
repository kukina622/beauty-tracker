import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorageServiceImpl implements LocalStorageService {
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @override
  Future<bool?> getBool(LocalStorageKeys storageKey) {
    return prefs.then((prefs) => prefs.getBool(storageKey.key));
  }

  @override
  Future<double?> getDouble(LocalStorageKeys storageKey) {
    return prefs.then((prefs) => prefs.getDouble(storageKey.key));
  }

  @override
  Future<int?> getInt(LocalStorageKeys storageKey) {
    return prefs.then((prefs) => prefs.getInt(storageKey.key));
  }

  @override
  Future<String?> getString(LocalStorageKeys storageKey) {
    return prefs.then((prefs) => prefs.getString(storageKey.key));
  }

  @override
  Future<void> remove(LocalStorageKeys storageKey) {
    return prefs.then((prefs) => prefs.remove(storageKey.key));
  }

  @override
  Future<void> setBool(LocalStorageKeys storageKey, bool value) {
    return prefs.then((prefs) => prefs.setBool(storageKey.key, value));
  }

  @override
  Future<void> setDouble(LocalStorageKeys storageKey, double value) {
    return prefs.then((prefs) => prefs.setDouble(storageKey.key, value));
  }

  @override
  Future<void> setInt(LocalStorageKeys storageKey, int value) {
    return prefs.then((prefs) => prefs.setInt(storageKey.key, value));
  }

  @override
  Future<void> setString(LocalStorageKeys storageKey, String value) {
    return prefs.then((prefs) => prefs.setString(storageKey.key, value));
  }
}
