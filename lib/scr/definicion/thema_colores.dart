import 'package:flutter/material.dart';

ThemeData themaApi() {
  return ThemeData(
    primaryColor: Color.fromRGBO(55, 57, 84, 1.0),
    // primarySwatch:Color.fromRGBO(55, 57, 84, 1.0),
    //colorScheme.copyWith(secondary: Color.fromRGBO(55, 57, 84, 1.0)),
//colorScheme:              ColorScheme.fromRGBO(55, 57, 84, 1.0), // afecta flotin action botto
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: Colors.white,
    )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(55, 57, 84, 0.9),
        selectedIconTheme:
            IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
        unselectedIconTheme:
            IconThemeData(color: Colors.green[100], opacity: 0.6, size: 30.0)),

    // style: BorderStyle()
  );
}
