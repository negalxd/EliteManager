import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color.fromRGBO(255, 255, 255, 1);
  static final ThemeData mytheme = ThemeData(
    useMaterial3: true,
    primaryColor: primary,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
      color: Color.fromRGBO(255, 255, 255, 1),
      titleTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
      elevation: 0,
    ),
  );
}