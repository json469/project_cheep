import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project_cheep/blocs/theme_changer.dart';
import 'package:project_cheep/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(true),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Project Cheep',
      home: Home(),
      theme: themeProvider.getTheme(),
    );
  }
}
