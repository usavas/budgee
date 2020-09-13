import 'package:flutter/material.dart';

ThemeData themedata = ThemeData(
  // brightness: Brightness.light,
  backgroundColor: const Color(0xff1B262C),
  cardColor: const Color(0xFF2C373D),
  primaryColor: Color(0xffAF1A24),
  accentColor: Colors.white.withOpacity(0.6),

  appBarTheme: AppBarTheme(
      color: Color(0xFF2C373D),
      textTheme: TextTheme(
          headline1: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ))),
  fontFamily: 'OpenSans',
  iconTheme: IconThemeData(color: Color(0xffAF1A24)),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontFamily: 'OpenSans', fontSize: 18, color: Colors.white70),
      bodyText2: TextStyle(
          fontFamily: 'OpenSans', fontSize: 18, color: Colors.black87)),
  inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.3)),
      hintStyle: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.3))),
  buttonTheme: ButtonThemeData(
      buttonColor: Color(0xffAF1A24),
      padding: EdgeInsets.all(16),
      textTheme: ButtonTextTheme.primary),
);
