import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManage {

  static var fcmToken = "fcm_token";

  static Future<void> setPreferencesValue(var key,var value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key,value);
  }

  static Future getPreferencesValue(var key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

}