import 'package:flutter/material.dart';
import 'package:piproy/scr/pages/botonrojo_page.dart';
import 'package:piproy/scr/pages/home_page.dart';

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
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'botonRojo': (_) => BotonRojoPage(),
      },
    );
  }
}
