import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:piproy/scr/definicion/thema_colores.dart';
import 'package:piproy/scr/pages/api_grupos.dart';
import 'package:piproy/scr/pages/ayuda.dart';

import 'package:piproy/scr/pages/conta_grupos.dart';

import 'package:piproy/scr/pages/home2_page.dart';
import 'package:piproy/scr/pages/permisos_bienvenida.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/providers/db_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = new Preferencias();
  final apiMenu = new AplicacionesProvider();
  await pref.init();
  await apiMenu.cargarCategorias();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => new Preferencias()),
      ChangeNotifierProvider(create: (_) => new ContactosProvider()),
      ChangeNotifierProvider(create: (_) => new EstadoProvider()),
      ChangeNotifierProvider(create: (_) => new AplicacionesProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);

    DbTiposAplicaciones.db.database;

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1),
          child: child,
        );
      },
      title: 'vitalfon',
      theme: themaApi(pref.paleta),

      //initialRoute: 'home',
      initialRoute: pref.instalado ? 'home' : 'instalar',
      routes: rutasApp,
    );
  }
}

Map<String, WidgetBuilder> get rutasApp {
  return {
    'home': (_) => Home2Page(),
    'contactos': (_) => ContactsGruposPage(),
    'apigrupos': (_) => ApiGruposPage(),
    'instalar': (_) => BienvenidaPage(),
    'ayuda': (_) => Ayuda(),
  };
}
