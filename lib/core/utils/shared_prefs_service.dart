import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  final SharedPreferences _prefs;
  SharedPrefsService(this._prefs);

  // Bool
  bool getBool(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;
  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);

  // Int
  int getInt(String key, {int defaultValue = 0}) =>
      _prefs.getInt(key) ?? defaultValue;
  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);

  // Double
  double getDouble(String key, {double defaultValue = 0.0}) =>
      _prefs.getDouble(key) ?? defaultValue;
  Future<void> setDouble(String key, double value) => _prefs.setDouble(key, value);

  // String
  String getString(String key, {String defaultValue = ''}) =>
      _prefs.getString(key) ?? defaultValue;
  Future<void> setString(String key, String value) => _prefs.setString(key, value);

  // String List
  List<String> getStringList(String key, {List<String> defaultValue = const []}) =>
      _prefs.getStringList(key) ?? defaultValue;
  Future<void> setStringList(String key, List<String> value) => _prefs.setStringList(key, value);

  // Remove
  Future<void> remove(String key) => _prefs.remove(key);

  // Clear all
  Future<void> clear() => _prefs.clear();
} 