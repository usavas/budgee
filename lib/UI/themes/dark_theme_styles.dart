import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      // brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      cardTheme: CardTheme(
          color: isDarkTheme ? 
          const Color(0xFF2C373D) 
          : Colors.grey[100],
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      primaryColor: isDarkTheme 
      ? Color(0xffAF1A24) 
      : Colors.blueGrey,
      scaffoldBackgroundColor:
          isDarkTheme ? const Color(0xff1B262C) 
          : Colors.grey[200],

      backgroundColor:
          isDarkTheme ? const Color(0xff1B262C) 
          : Colors.grey[200],
      iconTheme: IconThemeData(color: Color(0xffAF1A24)),

      fontFamily: 'OpenSans',
      textTheme: TextTheme(
          body1: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              color: isDarkTheme ? Colors.white70 : Colors.black87),
          body2: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12,
              color: isDarkTheme ? Colors.white70 : Colors.black87)),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle:
              TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.3)),
          hintStyle:
              TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.3))),
      buttonTheme: isDarkTheme
          ? ButtonThemeData(
              buttonColor: Color(0xffAF1A24),
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              textTheme: ButtonTextTheme.primary)
          : ButtonThemeData(
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              textTheme: ButtonTextTheme.primary
          ),
          
      // indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      // hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      // highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      // hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      // focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      // disabledColor: Colors.grey,
      // textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      // // cardColor: isDarkTheme ? Color(0xFF2C373D) : Color(0xFFFFFFFF),
      // canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      // buttonTheme: Theme.of(context).buttonTheme.copyWith(
      //     colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      // appBarTheme: AppBarTheme(
      //   elevation: 0.0,
      // ),
    );
  }
}
