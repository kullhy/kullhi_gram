import 'package:shared_preferences/shared_preferences.dart';

import '../data/local/app_data.dart';

abstract class PreferenceManager {
  static String subLocation = "subLocation";
  static String tokenKey = "token";
  static String username = "username";
  static String firebaseToken = "firebaseToken";
  static String password = "password";
  static String remember = "remember";
  static String isFirstLogin = "isFirstLogin";
  static String userID = "userID";

  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static setLanguage(String code) async {
    await _prefsInstance?.setString(subLocation, code);
  }

  static Future<String> getLanguage([String? defValue]) async {
    return _prefsInstance?.getString(subLocation) ?? defValue ?? '';
  }

  static setToken(String token) async {
    AppProvider.instance.token = token;
    await _prefsInstance?.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    return _prefsInstance?.getString(tokenKey);
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue!;
  }

  static Future<bool> setString(String key, String value) async {
    var pref = await _instance;
    return pref.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    var pref = await _instance;
    return pref.setBool(key, value);
  }

  static clear() async {
    await _prefsInstance?.clear();
  }
}
