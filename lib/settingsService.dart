import 'package:shared_preferences/shared_preferences.dart';

// TODO singleton?
class SettingsService {
  static const String _keyRememberBook = 'remember_last_book';
  static const String _keyLastBookId = 'last_book_id';

  const SettingsService();

  Future<void> setRememberLastSelectedBook(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberBook, value);
  }

  Future<bool> getRememberLastSelectedBook() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRememberBook) ?? false;
  }

  Future<void> setLastSelectedBookId(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance(); // TODO to field?
    if (value == null) {
      await prefs.remove(_keyLastBookId);
    } else {
      await prefs.setString(_keyLastBookId, value);
    }
  }

  Future<String?> getLastSelectedBookId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastBookId);
  }
}