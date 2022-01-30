import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:piproy/scr/models/contactos_modelo.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/db_provider.dart';

import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/boton_rojo.dart';

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
          preferredSize: Size.fromHeight(pref.menuHorizontal ? 275.0 : 190.0),
          child: encabezadoApp(context, 'Proyecto PI'),
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
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return snapshot.data[i];
                      });
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
    // final listaMenu = apiProvider.listaMenu;
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
          Text('Contactos', style: TextStyle(fontSize: 40.0)),
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

encabezadoApp(BuildContext context, String titulo) {
  final pref = Provider.of<Preferencias>(context);
  final menuHorizontal = pref.menuHorizontal;
  // celProvider.menuHorizontal;
  return Container(
    // color: Colors.amber,
    height: pref.menuHorizontal ? 275 : 190,
    padding: EdgeInsets.only(left: 5, right: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BotonesEncabezado(),
        menuHorizontal ? encabezadoIcon(context) : Text(''),
      ],
      // ),

      // decoration: new BoxDecoration(
      //     gradient: LinearGradient(
      //         colors: [
      //       Theme.of(context).primaryColor,

      //       Colors.white,
      //       Theme.of(context).scaffoldBackgroundColor,
      //       //Color.fromRGBO(55, 57, 84, 1.0)
      //     ],
      //         stops: [
      //       0.1, //2
      //       0.4,
      //       0.9
      //     ],
      //         begin: FractionalOffset.topCenter,
      //         end: FractionalOffset.bottomCenter)),
      // color: Color.fromRGBO(55, 57, 84, 1.0),
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
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: altura,
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
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
      // color: Colors.green,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        backgroundColor: Colors.red[900],
                        title: Container(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Text('¿ Desea salir de Vitalfon ?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 28, color: Colors.white)),
                          ),
                        ),

                        //shape: CircleBorder(),
                        elevation: 14.0,
                        actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
                        //actionsAlignment: MainAxisAlignment.spaceAround,
                        actions: [
                          TextButton(
                              onPressed: () {
                                // se sale con flecha menu inferior
                                SystemNavigator.pop();

                                // exit(0);
                                //Navigator.pop(context);
                              },
                              child: ClipOval(
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.black38,
                                  child: Center(
                                    child: Text('Si',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.white)),
                                  ),
                                ),
                              )),
                          TextButton(
                              autofocus: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: ClipOval(
                                  child: Container(
                                      height: 80,
                                      width: 80,
                                      color: Colors.black38,
                                      child: Center(
                                          child: Text('No',
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  color: Colors.white))))))
                        ],
                      ));
            },
            child: Container(
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white30)),
                margin: EdgeInsets.only(right: 5),
                child: Center(
                  child: Text(
                    'SALIDA',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          botonRojoHeader(context, true),
          SizedBox(
            height: 30,
          )
        ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, 'ayuda',
                //     arguments: 'home');
                Navigator.pushNamed(context, 'configurar');
              },
              child: Container(
                  width: 50,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.white30)),
                  margin: EdgeInsets.only(right: 5),
                  child: Center(
                    child: Icon(
                      Icons.ac_unit,
                      size: 35,
                      color: Colors.white,
                    ),
                    //  Text(
                    //   'CONFIGURAR',
                    //   style: TextStyle(fontSize: 18, color: Colors.white),
                    // ),
                  )),
            ),
            // HoraFecha(),
            SizedBox(
              height: 3,
            ),
            HoraFecha(),
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'ayuda', arguments: 'home');
              },
              child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.white30)),
                  margin: EdgeInsets.only(right: 5),
                  child: Center(
                    child: Text(
                      'AYUDA',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              height: 130,
              width: 90,
            )
          ],
        ),
      ]),
    );
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
      // margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white38, width: 1)),
      // color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30,
                height: 30,
              ),
              Image.memory(
                (api as ApplicationWithIcon).icon,
                width: 90,
              ),
              GestureDetector(
                  onTap: () {
                    eliminarApiMP(
                        context, 'MPB' + api.packageName, api.appName);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
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
          SizedBox(
            height: 10,
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
