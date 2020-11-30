import 'package:flutter/material.dart';

class ThemeNotifier {
  static bool _isDark = false;

  static setTheme(bool isDark) {
    _isDark = isDark;
  }

  static getIsDark() {
    return _isDark;
  }

  static getTheme() {
    return _isDark == true ? ThemeMode.dark : ThemeMode.light;
  }
}
