import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<void> saveUserData(String uid, String email,
      String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setString('email', email);
    await prefs.setString('name', name);
  }

  static Future<Map<String, String?>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'uid': prefs.getString('uid'),
      'email': prefs.getString('email'),
      'name': prefs.getString('name'),
    };
  }

  static Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}