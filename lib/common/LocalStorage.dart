import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  static SharedPreferences _prefs;

  static save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static String getString(String key, {String defValue = ''}) {
    getPreferences();
    return _prefs?.getString(key) ?? defValue;
  }

  static remove(String key) {
    getPreferences();
    _prefs?.remove(key);
  }

  static saveBool(String key, bool value) {
    getPreferences();
    _prefs?.setBool(key, value);
  }

  static bool getBool(String key, {bool defValue = false})  {
    getPreferences();
    return _prefs?.getBool(key) ?? defValue;
  }

  static void getPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
}