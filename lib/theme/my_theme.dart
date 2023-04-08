import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color.fromRGBO(4, 75, 134, 1);
  static final ThemeData mytheme = ThemeData(
    useMaterial3: true,
    primaryColor: primary,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      color: Color.fromRGBO(17, 100, 168, 1),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      elevation: 10,
    ),
  );
}