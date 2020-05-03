import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;

  ThemeData _currentTheme;

  ThemeChanger(int theme) {
    switch (theme) {
      case 1: // light
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light().copyWith(
          accentColor: Colors.pink,
        );
        break;
      case 2: // dark
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = ThemeData.dark();
        break;
      case 3: // light
        _darkTheme = false;
        _customTheme = true;
        _currentTheme = ThemeData.light();
        break;
      default:
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
        break;
    }
  }

  bool get darkTheme => _darkTheme;
  bool get customTheme => _customTheme;
  ThemeData get currentTheme => _currentTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    _customTheme = false;
    if (value) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light().copyWith(
        accentColor: Colors.pink,
      );
    }
    notifyListeners();
  }

  set customTheme(bool value) {
    _customTheme = value;
    _darkTheme = false;
    if (value) {
      _currentTheme = ThemeData.dark().copyWith(
        accentColor: Color(0xff1DA1F2),
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Color(0xff16202B),
        textTheme: TextTheme(
            body1: TextStyle(
          color: Colors.white,
        )),
      );
    } else {
      _currentTheme = ThemeData.light().copyWith(
        accentColor: Colors.pink,
      );
    }
    notifyListeners();
  }
}
