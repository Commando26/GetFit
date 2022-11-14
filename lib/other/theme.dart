import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier {

  static bool _isDark = true;
  Color textColor = Colors.yellow;
  bool isSwitched = false;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Color currentColor() {
    return textColor;
  }



  void switchTheme() {
    _isDark = !_isDark;
    if (!_isDark)
      textColor = Colors.lightBlueAccent;
    else
      textColor = Colors.yellow;
    notifyListeners();
  }
}