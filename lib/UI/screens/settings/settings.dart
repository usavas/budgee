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

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Switch(
                  value: themeChange.isDarkTheme,
                  onChanged: (bool value) {
                    themeChange.isDarkTheme = !themeChange.isDarkTheme;
                  },
                ),
                Padding(padding: EdgeInsets.only(right: 8),),
                Text('Dark Theme'),
              ]),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text('Remove the ads'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Divider(),
          ]),
        ),
      ),
    );
  }
}
