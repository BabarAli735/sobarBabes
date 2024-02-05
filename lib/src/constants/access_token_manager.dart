import 'package:shared_preferences/shared_preferences.dart';

class AccessTokenManager {
  static final String _accessTokenKey = 'access_token';
  static final String _phoneNumberKey = '_phoneNumberKey';

  // Save the access token
  static Future<void> saveAccessToken(String userdata) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, userdata);
  }

  static Future<void> savePhoneNumber(String userdata) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneNumberKey, userdata);
  }

  // Get the access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Get the phone number
  static Future<String?> getNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneNumberKey);
  }

  // Check if the user has a valid access token
  static Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Remove the access token (logout)
  static Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
  }
}
