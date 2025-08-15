import 'package:flutter/material.dart';


final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF65AB0E),
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF65AB0E),
    secondary: const Color(0xFF65AB0E),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF65AB0E),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF65AB0E),
    foregroundColor: Colors.white,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF65AB0E),
    selectionColor: Color(0x3365AB0E),
    selectionHandleColor: Color(0xFF65AB0E),
  ),
);



final TextTheme textTheme = TextTheme();