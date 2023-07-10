import 'package:flutter/material.dart';
import 'package:numerology_app/model/theme_preferences.dart';

class ThemeModal extends ChangeNotifier {
  bool _isDark = true;
  ThemePreferences _preferences = ThemePreferences();
  bool get isDark => _isDark;

  ThemeModal() {
    _isDark = true;
    _preferences = ThemePreferences();
    getThemePreferences();
  }

  getThemePreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }
}
