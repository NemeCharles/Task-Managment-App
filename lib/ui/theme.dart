import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

const Color primaryColor = Color(0xFF4E5AE8);
const Color blueColor = Color(0xFFFFB746);
const Color pinkColor = Color(0xFFFF4667);
const Color darkGrey = Color(0xFF121212);
const Color darkGreyHeader = Color(0xFF424242);


class Themes {
  static final lightMode = ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    brightness: Brightness.light
  );
  static final darkMode = ThemeData(
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black54,
    primaryColor: Colors.black,
    brightness: Brightness.dark
  );
}

TextStyle get dateTextStyle{
  return TextStyle(
    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
    fontSize: 25,
    fontWeight: FontWeight.w500
  );
}

Color? get textColor{
  return Get.isDarkMode ? Colors.grey[400] : Colors.grey;
}

TextStyle get dayTextStyle{
  return TextStyle(
    color: textColor,
    fontSize: 15
  );
}

TextStyle get monthTextStyle{
  return TextStyle(
    color: textColor,
    fontSize: 15
  );
}

class ThemeServices {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  bool get loadTheme => _box.read(_key) ?? false;
  ThemeMode get theme => loadTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    Get.changeThemeMode(loadTheme ? ThemeMode.light : ThemeMode.dark);
    _saveTheme(!loadTheme);
  }
  void _saveTheme(bool val) {
    _box.write(_key, val);
  }
}
