import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piproy/scr/definicion/thema_colores.dart';
import 'package:piproy/scr/pages/api_grupos.dart';

import 'package:piproy/scr/pages/api_por_grupos.dart';
import 'package:piproy/scr/pages/ayuda.dart';
import 'package:piproy/scr/pages/configuracion_page.dart';
import 'package:piproy/scr/pages/conta_grupos.dart';
import 'package:piproy/scr/pages/contacts_por_grupo.dart';

import 'package:piproy/scr/pages/home_agrega_boton.dart';

import 'package:piproy/scr/pages/envio_emergencia.dart';
import 'package:piproy/scr/pages/home2_page.dart';
import 'package:piproy/scr/pages/mensaje_emergencia.dart';

import 'package:piproy/scr/pages/botonrojo_page.dart';

import 'package:piproy/scr/pages/splash.dart';
//import 'package:piproy/scr/pages/splash.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:piproy/scr/providers/lista_id_provider.dart';

import 'package:provider/provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String paleta;
//   @override
//   void initState() {
//     super.initState();
//     //cargarPrefPaleta();
//   }

  @override
  Widget build(BuildContext context) {
    DbTiposAplicaciones.db.database;
    EstadoProvider estadoProvider = new EstadoProvider();
    ContactosProvider contactosProvider = new ContactosProvider();
    // AplicacionesProvider aplicacionesProvider = new AplicacionesProvider();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => new EstadoProvider()),
          ChangeNotifierProvider(create: (_) => new ListaIdProvider()),
          ChangeNotifierProvider(create: (_) => new AplicacionesProvider()),
          ChangeNotifierProvider(create: (_) => new ContactosProvider()),
        ],
        child: Consumer<EstadoProvider>(builder: (context, appInfo, _) {
          String colorKey = appInfo.paleta;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (BuildContext context, Widget child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(textScaleFactor: 1),
                child: child,
              );
            },
            title: 'Proyecto',
            theme: themaApi(colorKey),
            // home: SplashPage(),

            initialRoute: 'home',
            routes: rutasApp,
          );
        }));
  }

  Map<String, WidgetBuilder> get rutasApp {
    return {
      'home': (_) => Home2Page(),
      'botonRojo': (_) => BotonRojoPage(),
      'resumenRojo': (_) => ResumenEnvioPage(),
      'contactos': (_) => ContactsGruposPage(),
      //'mostrarContacto': (_) => MostrarContacto(),
      'emergiMensaje': (_) => EmergenciaMensaje(),
      'configurar': (_) => ConfiguracionPage(),
      'ayuda': (_) => Ayuda(),
      'apigrupos': (_) => ApiGruposPage(),
      'grupo': (_) => ApiPorGrupoPage(),
      'splash': (_) => SplashPage(),
      'agregaboton': (_) => AgregaBotonPage(),
      'grupocontacto': (_) => ContactsPorGrupoPage()
    };
  }
}
