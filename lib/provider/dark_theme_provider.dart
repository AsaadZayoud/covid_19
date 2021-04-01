import 'package:flutter/material.dart';
import 'package:covid_19/preferance/dark_theme_preferance.dart';
class DarkThemeProvider with ChangeNotifier {

  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}