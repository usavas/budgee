import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static final String _fontFamily = "Open Sans";

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      cardTheme: CardTheme(
          color: isDarkTheme ? const Color(0xFF2C373D) : Colors.grey[100],
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      primaryColor: isDarkTheme ? Color(0xffAF1A24) : Colors.blueGrey,
      scaffoldBackgroundColor:
          isDarkTheme ? const Color(0xff1B262C) : Colors.grey[200],

      backgroundColor: isDarkTheme ? const Color(0xff1B262C) : Colors.grey[200],
      iconTheme: IconThemeData(color: Color(0xffAF1A24)),

      fontFamily: _fontFamily,
      textTheme: TextTheme(
          bodyText1: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: isDarkTheme ? Colors.white70 : Colors.black87),
          bodyText2: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: isDarkTheme ? Colors.white70 : Colors.black87),
          button: TextStyle(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isDarkTheme ? Colors.white70 : Colors.black87,
          ),
          headline5: TextStyle(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: isDarkTheme ? Colors.white70 : Colors.black87,
          ),
          headline6: TextStyle(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w300,
            fontSize: 14,
            color: isDarkTheme ? Colors.white70 : Colors.black87,
          ),
          // this color is used for the weekdays on datepicker widget
          caption: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w400,
              color: isDarkTheme ? Colors.white70 : Colors.black87),
          // this color is used for the month-year slider on datepicker widget
          subtitle1: TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w400,
              color: isDarkTheme ? Colors.white70 : Colors.black87)),

      inputDecorationTheme: InputDecorationTheme(
          labelStyle: isDarkTheme
              ? TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.4))
              : TextStyle(fontSize: 16, color: Colors.black26),
          hintStyle: isDarkTheme
              ? TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.4))
              : TextStyle(fontSize: 16, color: Colors.black26)),
      buttonTheme: isDarkTheme
          ? ButtonThemeData(
              buttonColor: Color(0xffAF1A24),
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              textTheme: ButtonTextTheme.primary)
          : ButtonThemeData(
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              textTheme: ButtonTextTheme.primary),

      // indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      // hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      // highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      // hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      // focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      // disabledColor: Colors.grey,
      // textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      // canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
    );
  }
}
