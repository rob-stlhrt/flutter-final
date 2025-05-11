import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color.fromRGBO(103, 164, 255, 1);

  static final ThemeData myTheme = ThemeData( 
      primaryColor: const Color.fromARGB(255, 255, 0, 149),
      brightness: Brightness.light,
      fontFamily: 'Releway',
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 237, 149, 255),
        elevation: 10,
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primary)),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primary));
}
