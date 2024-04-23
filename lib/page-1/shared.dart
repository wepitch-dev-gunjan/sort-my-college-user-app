import 'package:shared_preferences/shared_preferences.dart';

class SharedPre {

  static const String auth = 'authLogin';

  static Future<void> saveAuthLogin(bool authLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(auth, authLogin);
  }

  static Future<bool?> getAuthLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(auth) ?? false;
  }
}
