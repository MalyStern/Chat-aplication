import 'package:flutter/material.dart';
import '../theme/dark_mode.dart';
import '../theme/light_mode.dart';


class ThemeProvider with ChangeNotifier{
  ThemeData _themeData =lightMode;
  ThemeData get themeData=>_themeData;

  bool get isDarkMode=>_themeData==darkMode;

  void updateThemeData(ThemeData themData){
    _themeData =themData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData==lightMode){
      updateThemeData(darkMode);
    }
    else{
      updateThemeData(lightMode);
    } 
  }
}

