import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _darkModeKey = 'dark_mode';
  static const String _languageKey = 'language';

  static late SharedPreferences _prefs;

   static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

   static bool get isDarkMode => _prefs.getBool(_darkModeKey) ?? false;

  static Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_darkModeKey, value);
  }

   static String get language => _prefs.getString(_languageKey) ?? 'en';

  static Future<void> setLanguage(String value) async {
    await _prefs.setString(_languageKey, value);
  }

  static bool get isArabic => language == 'ar';
}