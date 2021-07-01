import 'package:flutter/material.dart';
import 'package:piproy/scr/pages/botonrojo_page.dart';
import 'package:piproy/scr/pages/contactos_page.dart';
import 'package:piproy/scr/pages/emergi_contactos_page.dart';
import 'package:piproy/scr/pages/home2_page.dart';
import 'package:piproy/scr/pages/seleccion_contactos_page.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //List<Contact> listaSelect;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proyecto',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(55, 57, 84, 1.0), //Colors.green,
          accentColor: Color.fromRGBO(55, 57, 84, 1.0), //Colors.green,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            primary: Colors.white,
          )),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Color.fromRGBO(55, 57, 84, 0.9),
              selectedIconTheme:
                  IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
              unselectedIconTheme: IconThemeData(
                  color: Colors.green[100], opacity: 0.6, size: 30.0)),

          // style: BorderStyle()
        ),
        initialRoute: 'home',
        routes: {
          'home': (_) => Home2Page(),
          'botonRojo': (_) => BotonRojoPage(),
          'contactos': (_) => ContactosPage(),
          'emergiContactos': (_) => EmergenciaContactos(),
          'selecContactos': (_) => SeleccionContacto()
        },
      ),
    );
  }
}
