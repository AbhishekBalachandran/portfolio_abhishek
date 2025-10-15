import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Inter',
    appBarTheme: appBarTheme(),
    primaryColor: Colors.white,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
  );
}
