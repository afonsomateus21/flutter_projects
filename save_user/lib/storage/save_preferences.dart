import 'package:shared_preferences/shared_preferences.dart';

class SavePreferences {
  static Future<SharedPreferences>  _preferences = SharedPreferences.getInstance();
}