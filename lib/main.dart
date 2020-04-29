import 'package:expenses/UI/screens/account/providers/current_month_year_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UI/themes/dark_theme_styles.dart';
import 'UI/themes/darktheme_provider.dart';
import 'UI/screens/bottomnavigation.dart';

void main() {
  // in order to prevent the error occuring on calling multipler providers in the same context
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.isDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CurrentMonthYearProvider(),
      child: ChangeNotifierProvider.value(
        value: themeChangeProvider,
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
            return MaterialApp(
              title: 'AylikGelirGider',
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeChangeProvider.isDarkTheme, context),
              home: BottomNavigation(),
            );
          },
        ),
      ),
    );
  }
}
