import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piproy/scr/definicion/thema_colores.dart';
import 'package:piproy/scr/pages/ayuda.dart';
import 'package:piproy/scr/pages/configuracion_page.dart';
import 'package:piproy/scr/pages/editar_contacto.dart';
import 'package:piproy/scr/pages/mostrar_contacto.dart';
import 'package:piproy/scr/pages/envio_emergencia.dart';
import 'package:piproy/scr/pages/home2_page.dart';
import 'package:piproy/scr/pages/mensaje_emergencia.dart';

import 'package:piproy/scr/pages/botonrojo_page.dart';

import 'package:piproy/scr/pages/contactos_page.dart';
import 'package:piproy/scr/pages/emergi_contactos_page.dart';
import 'package:piproy/scr/pages/seleccion_contactos_page.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/providers/lista_id_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    ContactosProvider contactosProvider = new ContactosProvider();
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => new ListaIdProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proyecto',
        theme: themaApi(),
        initialRoute: 'home',
        routes: {
          'home': (_) => Home2Page(),
          'botonRojo': (_) => BotonRojoPage(),
          'resumenRojo': (_) => ResumenEnvioPage(),
          'contactos': (_) => ContactosPage(),
          'mostrarContacto': (_) => MostrarContacto(),
          'editarContacto': (_) => EditarContacto(),
          'emergiContactos': (_) => EmergenciaContactos(),
          'selecContactos': (_) => SeleccionContacto(),
          'emergiMensaje': (_) => EmergenciaMensaje(),
          'configurar': (_) => ConfiguracionPage(),
          'ayuda': (_) => Ayuda(),
        },
      ),
    );
  }
}
