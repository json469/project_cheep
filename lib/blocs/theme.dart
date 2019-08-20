import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _isLight;

  ThemeChanger(this._isLight);

  getTheme() => _isLight
      ? ThemeData.light().copyWith(buttonColor: Colors.blue)
      : ThemeData.dark().copyWith(buttonColor: Colors.blueGrey);

  toggleTheme() {
    _isLight = !_isLight;
    notifyListeners();
  }
}
