import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManage {

  static var fcmToken = "fcm_token";

  static var isUserLogin='is_user_login';
  static var loginUserDocumentId='login_user_document_id';
  static var loginUserEmail ='login_user_email';
  static var loginUserName ='login_user_name';
  static var loginUserGoogleLoginToken ='login_google_login_token';
  static var loginUserProfileImage ='login_user_profile_image';
  static var loginUserPhoneNumber ='login_user_phone_number';


  static Future<void> setPreferencesValue(var key,var value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key,value);
  }

  static Future getPreferencesValue(var key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

}