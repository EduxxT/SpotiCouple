import 'package:flutter/material.dart';
import 'package:spoticouple/themes/light_theme.dart';
import 'package:spoticouple/themes/dark_theme.dart';

class ThemeProvider extends ChangeNotifier {
 // La aplicacion iniciara con el tema claro
  ThemeData _themeData = lightThemeData;

  ThemeData get themeData => _themeData;

  // verificar si es dark o light
  bool get isDarkMode => _themeData == darkThemeData;

  // Cambiar tema
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    //Updateeeeeeeeeeeeeeee
    notifyListeners();
  }

  // Alternar entre temas
  void toggleTheme() {
    if (_themeData == lightThemeData) {
      _themeData = darkThemeData;
    } else {
      _themeData = lightThemeData;
    }
    notifyListeners();
  }
}