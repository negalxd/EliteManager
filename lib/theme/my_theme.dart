import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color.fromRGBO(8, 76, 132, 1);
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
    drawerTheme: DrawerThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(8, 76, 132, 1),
      foregroundColor: Colors.white,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134), width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134), width: 2.0),
      ),
      labelStyle: TextStyle(color: Color.fromARGB(255, 4, 75, 134)),
    ),

  );
}