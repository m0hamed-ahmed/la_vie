import 'package:shared_preferences/shared_preferences.dart';

const String PREFERENCES_KEY_USER_DATA = "PREFERENCES_KEY_USER_DATA";
const String PREFERENCES_KEY_EXAM_TIME = "PREFERENCES_KEY_EXAM_TIME";

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({required String key, required dynamic value}) async {
    if(value.runtimeType == String) {return await _sharedPreferences.setString(key, value);}
    if(value.runtimeType == bool) {return await _sharedPreferences.setBool(key, value);}
    if(value.runtimeType == int) {return await _sharedPreferences.setInt(key, value);}
    return await _sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }
}