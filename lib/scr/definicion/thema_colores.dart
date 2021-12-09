import 'package:flutter/material.dart';

ThemeData themaApi(String color) {
  //final celProvider = Provider.of<EstadoProvider>(context);
  //final color = "1"; // celProvider.paleta;
  ThemeData tema;
  switch (color) {
    case '1':
      tema = ThemeData(
        primaryColor: Color.fromRGBO(55, 57, 84, 1.0),
        scaffoldBackgroundColor:
            Colors.grey[700], //  Color.fromRGBO(55, 57, 84, 1.0),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(249, 75, 11, 1),
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
        )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: Color.fromRGBO(249, 75, 11, 1),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(249, 75, 11, 1),
            selectedIconTheme:
                IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
            unselectedIconTheme: IconThemeData(
                color: Colors.green[100], opacity: 0.6, size: 30.0)),

        // style: BorderStyle()
      );
      break;
    case '2':
      tema = ThemeData(
        primaryColor:
            Color.fromRGBO(55, 57, 84, 1), //Color.fromRGBO(55, 57, 84, 1.0),
        // primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Colors.black)),
        scaffoldBackgroundColor: Color.fromRGBO(220, 118, 51, 1),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(192, 57, 43, 1),
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
        )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: Color.fromRGBO(192, 57, 43, 1),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(249, 75, 11, 1),
            selectedIconTheme:
                IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
            unselectedIconTheme: IconThemeData(
                color: Colors.green[100], opacity: 0.6, size: 30.0)),

        // style: BorderStyle()
      );
      break;
    case '3':
      tema = ThemeData(
        primaryColor: Colors.teal[700], //Color.fromRGBO(55, 57, 84, 1.0),
        // primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Colors.black)),
        scaffoldBackgroundColor: Colors.teal[700],
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(192, 57, 43, 1),
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
        )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: Color.fromRGBO(192, 57, 43, 1),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(249, 75, 11, 1),
            selectedIconTheme:
                IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
            unselectedIconTheme: IconThemeData(
                color: Colors.green[100], opacity: 0.6, size: 30.0)),

        // style: BorderStyle()
      );
      break;
    case '4':
      tema = ThemeData(
        primaryColor: Colors.green[300], // Color.fromRGBO(55, 57, 84, 1.0),

        scaffoldBackgroundColor: Colors.black,
        //Color.fromRGBO(           39, 174, 96, 1.0), // Color.fromRGBO(220, 118, 51, 1),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black)),

        iconTheme: IconThemeData(color: Colors.black, size: 40),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(192, 57, 43, 1),
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
        )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: Color.fromRGBO(192, 57, 43, 1),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(249, 75, 11, 1),
            selectedIconTheme:
                IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
            unselectedIconTheme: IconThemeData(
                color: Colors.green[100], opacity: 0.6, size: 30.0)),

        // style: BorderStyle()
      );
      break;
  }
  return tema;
}
