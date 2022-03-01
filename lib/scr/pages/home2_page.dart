import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:piproy/scr/models/contactos_modelo.dart';

import 'package:piproy/scr/pages/configuracion_page.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/db_provider.dart';

import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/boton_ayuda_dibujo.dart';

import 'package:piproy/scr/widgets/boton_rojo.dart';
import 'package:piproy/scr/widgets/boton_salida.dart';

import 'package:piproy/scr/widgets/contactos_card.dart';
import 'package:piproy/scr/widgets/elemntos.dart';

import 'package:piproy/scr/widgets/encabezado_icon.dart';
import 'package:piproy/scr/widgets/google_busqueda.dart';

import 'package:piproy/scr/widgets/reloj.dart';
import 'package:provider/provider.dart';

class Home2Page extends StatefulWidget {
  //final contactosProvider = new ContactosProvider();

  @override
  State<Home2Page> createState() => _Home2PageState();
}

class _Home2PageState extends State<Home2Page> {
  bool cargando = true;
  List<Widget> lista2 = [];
  Application api;

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);

    // final lista = apiProvider.listaMenu;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(pref.menuHorizontal ? 275.0 : 196.0),
          child: encabezadoApp(context),
        ),
        body: FutureBuilder(
            future: detalle(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Theme.of(context).scaffoldBackgroundColor,
                                    Colors.white,
                                  ],
                                )),
                                // padding: EdgeInsets.only(top: 50),
                                height: 100,
                                width: double.infinity,
                                child: Stack(children: [
                                  Positioned(
                                    left: 90,
                                    top: 32,
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/icon_otro_blanco.png'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Positioned(
                                    left: 115,
                                    top: 40,
                                    child: Text('vitalfon',
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w900,
                                            fontStyle: FontStyle.italic)),
                                  ),
                                ]),
                              ),
                            ],
                          )),
                      ListView.builder(
                          padding: EdgeInsets.only(bottom: 100),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return snapshot.data[i];
                          }),
                    ],
                  );
                } else {
                  return Container();
                }
              }
            }),
      ),
    );
  }

  detalle(BuildContext context) async {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final pref = Provider.of<Preferencias>(context);
    final listaMenu = apiProvider.listaMenu;
    List<Widget> listaOpciones = [];
    if (pref.iGoogle) {
      final apiGoogle = await apiProvider
          .obtenerApi('com.google.android.googlequicksearchbox');
      listaOpciones.add(googleBusqueda(context, apiGoogle));
      listaOpciones.add(
        SizedBox(height: 8),
      );
    }
    if (listaMenu.isNotEmpty) {
      listaOpciones.addAll(await listaContactos(context, listaMenu));
      listaOpciones.add(await matrizApis(context, listaMenu));
      listaOpciones.addAll(listaGrupos(context, listaMenu));
    }
    if (pref.iContactos) {
      listaOpciones.add(elementos(
          context,
          Text('Contactos',
              style: TextStyle(
                  fontSize: 40.0, color: Theme.of(context).backgroundColor)),
          60,
          'contactos',
          ''));
      listaOpciones.add(SizedBox(height: 8));
    }
    if (pref.iAplicaciones) {
      listaOpciones.add(elementos(
          context,
          Text('Aplicaciones', style: TextStyle(fontSize: 40.0)),
          60,
          'apigrupos',
          ''));

      listaOpciones.add(SizedBox(
        height: 70,
      ));
    }

    return listaOpciones;
  }
}

encabezadoApp(BuildContext context) {
  final pref = Provider.of<Preferencias>(context);
  final menuHorizontal = pref.menuHorizontal;

  return Container(
    height: pref.menuHorizontal ? 275 : 196,
    //   padding: EdgeInsets.only(left: 5, right: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BotonesEncabezado(),
        menuHorizontal ? encabezadoIcon(context) : Text(''),
      ],
    ),
  );
}

Iterable<Widget> listaGrupos(BuildContext context, List<String> listaMenu) {
  final List<String> lista = [];
  final List<Widget> listaGrupos = [];
  //********************************************************** */
  //************** grupos de contactoa************************* */
  lista.addAll(listaMenu.where((element) => element.contains('MPC')));
  for (var i = 0; i < lista.length; i++) {
    final String titulo = lista[i].substring(3);
    listaGrupos.add(elementos(context,
        Text(titulo, style: TextStyle(fontSize: 40.0)), 60, titulo, lista[i]));
    listaGrupos.add(SizedBox(height: 8));
  }
  final List<String> lista2 = [];

  lista2.addAll(listaMenu.where((element) => element.contains('MPD')));
  for (var i = 0; i < lista2.length; i++) {
    final String titulo = lista2[i].substring(3);
    listaGrupos.add(elementos(context,
        Text(titulo, style: TextStyle(fontSize: 40.0)), 60, titulo, lista2[i]));
    listaGrupos.add(SizedBox(height: 8));
  }
  return listaGrupos;
}

matrizApis(BuildContext context, List<String> listaMenu) async {
  //******************************************************* */
  //********************* una Api   MPB            */
  //final apiProvider = Provider.of<AplicacionesProvider>(context, listen: false);
  //final listaMenu = apiProvider.listaMenu;
  final List<String> lista = [];
  final List<Widget> listaApis = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPB')));
  for (var i = 0; i < lista.length; i++) {
    final Application api =
        await DeviceApps.getApp(lista[i].substring(3), true);

    if (api != null) {
      listaApis.add(elementoApi2(context, api));
    }
  }
  if (listaApis.isNotEmpty) {
    final altura =
        lista.length > 2 ? 180.0 * (lista.length / 2).round() : 180.0;
    return Container(
      // color: Colors.white12,
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: altura,
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          //  childAspectRatio: 1.2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          children: listaApis),
    );
  } else {
    return Container();
  }
}

listaContactos(BuildContext context, List<String> listaMenu) async {
  //*********************************************************** */
  /****************** un contacto MPA***************************/
  //*********************************************************** */
  final contactosProvider =
      Provider.of<ContactosProvider>(context, listen: false);
  final List<Widget> listaWidgetContactos = [];
  final List<String> lista = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPA')));
  for (var i = 0; i < lista.length; i++) {
    String nombre = lista[i].substring(3);
    final ContactoDatos contacto =
        await contactosProvider.obtenerContacto(nombre);
    if (contacto != null) {
      listaWidgetContactos
          .add(TarjetaContacto2(context, contacto, false, true));
      listaWidgetContactos.add(SizedBox(height: 8));
    }
  }

  return listaWidgetContactos;
}

class BotonesEncabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.green,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                GestureDetector(
                  onTap: () {
                    salida(context);
                  },
                  child: BotonSalida(),
                ),
                SizedBox(
                  height: 10,
                ),
                botonRojoHeader(context, true),
                SizedBox(
                  height: 20,
                )
              ]),
            ),
            Container(
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, 'ayuda',
                      //     arguments: 'home');

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfiguracionPage()));
                    },
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 1,
                                spreadRadius: 0.5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                width: 0.5,
                                color: Theme.of(context).primaryColor)),
                        margin: EdgeInsets.only(right: 5),
                        child: Center(
                          child: Icon(
                            Icons.build,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          //  Text(
                          //   'CONFIGURAR',
                          //   style: TextStyle(fontSize: 18, color: Colors.white),
                          // ),
                        )),
                  ),
                  HoraFecha(),
                ],
              ),
            ),
            Container(
              //  color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Ayuda(pagina: 'home')));
                      Navigator.pushNamed(context, 'ayuda', arguments: 'home');
                    },
                    child: BotonAyudaDibujo(),
                  ),
                  Container(
                    height: 110,
                    width: 90,
                  )
                ],
              ),
            ),
          ]),
    );
  }

  Future<dynamic> salida(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              //backgroundColor: Colors.red[900],
              title: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text('¿ Desea salir de vitalfon ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.red)),
                ),
              ),

              //shape: CircleBorder(),
              elevation: 14.0,
              //actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // se sale con flecha menu inferior
                    SystemNavigator.pop();

                    // exit(0);
                    //Navigator.pop(context);
                  },
                  child: Text('Si',
                      style: TextStyle(fontSize: 25.0, color: Colors.white)),
                ),
                ElevatedButton(
                    autofocus: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No',
                        style: TextStyle(fontSize: 25.0, color: Colors.white)))
              ],
            ));
  }
}

class BotonAyuda extends StatelessWidget {
  const BotonAyuda({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.black38,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 1,
                spreadRadius: 0.5,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            border:
                Border.all(width: 0.5, color: Theme.of(context).primaryColor)),
        // decoration: BoxDecoration(
        //     color: Colors.black38,
        //     borderRadius: BorderRadius.circular(20.0),
        //     border: Border.all(color: Colors.white30)),
        // margin: EdgeInsets.only(right: 5),
        child: Center(
          child: Text(
            'AYUDA',
            style:
                TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
          ),
        ));
  }
}

Widget elementoApi2(BuildContext context, Application api) {
  return GestureDetector(
    onTap: () {
      if (api.packageName != "") {
        api.openApp();
      }
    },
    child: Container(
      // height: 80,
      // decoration: BoxDecoration(
      //     color: Theme.of(context).scaffoldBackgroundColor,
      //     borderRadius: BorderRadius.circular(20.0),
      //     border:
      //         Border.all(color: Theme.of(context).primaryColor, width: 0.5)),
      // color: Colors.white12, //Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 145,
            width: 120,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Image.memory(
                  (api as ApplicationWithIcon).icon,
                  width: 90,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  api.appName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                eliminarApiMP(context, 'MPB' + api.packageName, api.appName);
              },
              child: Container(
                width: 30,
                height: 100,
                child: Center(
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              )),
        ],
      ),
    ),
  );
}

Future<dynamic> eliminarApiMP(
    BuildContext context, String tipo, String nombre) {
  // final String titulo = tipo.substring(3);
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text('¿Desea eliminar $nombre  del menú principal?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          )),
      // shape: CircleBorder(),
      elevation: 14.0,
      actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              /// elina api de pantalla
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarTipoMP(tipo);

              DbTiposAplicaciones.db
                  .deleteApi(tipo.substring(0, 3), tipo.substring(3));

              //elimina api de BD

              Navigator.pop(context);
            },
            child: Text('Si')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO')),
      ],
    ),
  );
}
