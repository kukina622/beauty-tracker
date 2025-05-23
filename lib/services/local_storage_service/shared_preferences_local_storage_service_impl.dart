import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorageServiceImpl implements LocalStorageService {
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @override
  Future<bool?> getBool(LocalStorageKeys key) {
    return prefs.then((prefs) => prefs.getBool(key.key));
  }

  @override
  Future<double?> getDouble(LocalStorageKeys key) {
    return prefs.then((prefs) => prefs.getDouble(key.key));
  }

  @override
  Future<int?> getInt(LocalStorageKeys key) {
    return prefs.then((prefs) => prefs.getInt(key.key));
  }

  @override
  Future<String?> getString(LocalStorageKeys key) {
    return prefs.then((prefs) => prefs.getString(key.key));
  }

  @override
  Future<void> remove(LocalStorageKeys key) {
    return prefs.then((prefs) => prefs.remove(key.key));
  }

  @override
  Future<void> setBool(LocalStorageKeys key, bool value) {
    return prefs.then((prefs) => prefs.setBool(key.key, value));
  }

  @override
  Future<void> setDouble(LocalStorageKeys key, double value) {
    return prefs.then((prefs) => prefs.setDouble(key.key, value));
  }

  @override
  Future<void> setInt(LocalStorageKeys key, int value) {
    return prefs.then((prefs) => prefs.setInt(key.key, value));
  }

  @override
  Future<void> setString(LocalStorageKeys key, String value) {
    return prefs.then((prefs) => prefs.setString(key.key, value));
  }
}
