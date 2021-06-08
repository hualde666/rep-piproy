import 'package:flutter/material.dart';
import 'package:piproy/scr/pages/botonrojo_page.dart';
import 'package:piproy/scr/pages/contactos_page.dart';
import 'package:piproy/scr/pages/home2_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedIconTheme:
                IconThemeData(color: Colors.green, opacity: 0.6, size: 20.0),
            unselectedIconTheme: IconThemeData(
                color: Colors.green[100], opacity: 0.6, size: 10.0)),

        // style: BorderStyle()
      ),
      initialRoute: 'home',
      routes: {
        'home': (_) => Home2Page(),
        'botonRojo': (_) => BotonRojoPage(),
        'contactos': (_) => ContactosPage(),
      },
    );
  }
}
