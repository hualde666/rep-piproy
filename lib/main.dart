import 'package:flutter/material.dart';
import 'package:piproy/scr/definicion/thema_colores.dart';
import 'package:piproy/scr/pages/configuracion_page.dart';
import 'package:piproy/scr/pages/editar_contacto.dart';
import 'package:piproy/scr/pages/home2_page.dart';
import 'package:piproy/scr/pages/mensaje_emergencia.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:piproy/scr/pages/botonrojo_page.dart';
import 'package:piproy/scr/pages/contactos_page.dart';
import 'package:piproy/scr/pages/emergi_contactos_page.dart';
import 'package:piproy/scr/pages/home_page.dart';
import 'package:piproy/scr/pages/seleccion_contactos_page.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //List<Contact> listaSelect;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => new ContactosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proyecto',
        theme: ThemaApi(),
        initialRoute: 'home',
        routes: {
          'home': (_) => Home2Page(),
          'botonRojo': (_) => BotonRojoPage(),
          'contactos': (_) => ContactosPage(),
          'editarContacto': (_) => EditarContacto(),
          'emergiContactos': (_) => EmergenciaContactos(),
          'selecContactos': (_) => SeleccionContacto(),
          'emergiMensaje': (_) => EmergenciaMensaje(),
          'configurar': (_) => ConfiguracionPage(),
        },
      ),
    );
  }
}
