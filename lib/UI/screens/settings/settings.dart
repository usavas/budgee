import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/darktheme_provider.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
      child: Center(
          child: Checkbox(
        value: themeChange.isDarkTheme,
        onChanged: (bool value) {
          themeChange.isDarkTheme = value;
        },
      )),
    );
  }
}
