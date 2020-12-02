import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool isDarkMode = false;

  void updateTheme() {
    this.isDarkMode = !isDarkMode;
    notifyListeners();
  }

  get theme => isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
