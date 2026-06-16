import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _keyRememberBook = 'remember_last_book';

  Future<void> setRememberLastSelectedBook(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberBook, value);
  }

  Future<bool> getRememberLastSelectedBook() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRememberBook) ?? false;
  }
}