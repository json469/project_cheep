import 'package:flutter/material.dart';
import 'package:project_cheep/constants/theme_changer_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  bool _isLight;

  ThemeChanger(this._isLight) {
    _loadFromSharedPreferences();
  }

  getTheme() => _isLight
      ? ThemeData.light().copyWith(buttonColor: Colors.blue)
      : ThemeData.dark().copyWith(buttonColor: Colors.blueGrey);

  toggleTheme() {
    _saveToSharedPreferences(!_isLight);
  }

  void _loadFromSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _isLight = sharedPreferences.getBool(kIsLightSharedPreference) ?? true;
    notifyListeners();
  }

  void _saveToSharedPreferences(bool isLight) async {
    _isLight = isLight;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool(kIsLightSharedPreference, isLight);
    notifyListeners();
  }
}
