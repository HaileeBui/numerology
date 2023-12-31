import 'package:numerology_app/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY);
  }
}
