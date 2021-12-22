import 'package:contacts_service/contacts_service.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:piproy/scr/models/api_tipos.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/db_provider.dart';

import 'package:piproy/scr/widgets/boton_rojo.dart';

import 'package:piproy/scr/widgets/contactos_card.dart';

import 'package:piproy/scr/widgets/elemntos.dart';

import 'package:piproy/scr/widgets/encabezado_icon.dart';
import 'package:piproy/scr/widgets/google_busqueda.dart';
import 'package:piproy/scr/widgets/pila_tiempo_clima.dart';
import 'package:provider/provider.dart';

class Home2Page extends StatefulWidget {
  //final contactosProvider = new ContactosProvider();

  @override
  State<Home2Page> createState() => _Home2PageState();
}

class _Home2PageState extends State<Home2Page> {
  // ScrollController _scrollController = ScrollController();
  bool cargando = true;
  List<Widget> lista2 = [];
  Application api;
  @override
  void initState() {
    super.initState();
    // cargarMenu();
    //  _scrollController = ScrollController()
    //    ..addListener(() {

    //    });
  }

  void scrollToTop() {
    //_scrollController.jumpTo(0.0);
  }
  Future cargarMenu() async {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    if (apiProvider.listaMenu.isEmpty) {
      final List<ApiTipos> lista = await apiProvider.cargarCategorias();
      Provider.of<AplicacionesProvider>(context, listen: false)
          .ordenarListasMenu(lista);
      lista2 = await detalle(context, apiProvider.listaMenu);
    }
    return apiProvider.listaMenu;
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final lista = apiProvider.listaMenu;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(240.0),
          child: encabezadoApp(context, 'Proyecto PI'),
        ),
        // backgroundColor: Theme.of(context).primaryColor,
        body: FutureBuilder(
            future: detalle(context, lista),
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

  detalle(BuildContext context, List<String> listaMenu) async {
    final contactosProvider = Provider.of<ContactosProvider>(context);
    final apiProvider =
        Provider.of<AplicacionesProvider>(context, listen: false);

    final apiGoogle =
        await apiProvider.obtenerApi('com.google.android.googlequicksearchbox');
    List<Widget> listaOpciones = [
      SizedBox(height: 8.0),
      elementos(context, PilaTimpoClima(), 200, '', ''),
      SizedBox(height: 8),
      googleBusqueda(context, apiGoogle),
      SizedBox(height: 8),
      //SizedBox(height: 5),
    ];
    if (listaMenu.isNotEmpty) {
      for (var i = 0; i < listaMenu.length; i++) {
        final String titulo = listaMenu[i].substring(3);
        //********************************************************** */
        //***** es un grupo API => MPD o un grupo de CONTACTO => MPC */
        if (listaMenu[i].contains('MPD') || listaMenu[i].contains('MPC')) {
          listaOpciones.add(elementos(
              context,
              Text(titulo, style: TextStyle(fontSize: 40.0)),
              100,
              titulo,
              listaMenu[i]));
          listaOpciones.add(SizedBox(height: 8));
        } else {
          if (listaMenu[i].contains('MPA')) {
            String nombre = listaMenu[i].substring(3);

            //*********************************************************** */
            /****************** un contacto MPA*/
            final Contact contacto =
                await contactosProvider.obtenerContacto(nombre);
            if (contacto != null) {
              listaOpciones.add(TarjetaContacto2(context, contacto, false));
            }
          } else {
            //******************************************************* */
            //********************* una Api   MPB            */
            // final apiProvider = Provider.of<AplicacionesProvider>(context);
            final Application api =
                await DeviceApps.getApp(listaMenu[i].substring(3), true);

            if (api != null) {
              listaOpciones.add(elementoApi2(context, api));
              listaOpciones.add(SizedBox(height: 8));
            }
          }
        }
      }
    }
    listaOpciones.add(elementos(
        context,
        Text('Contactos', style: TextStyle(fontSize: 40.0)),
        100,
        'contactos',
        ''));
    listaOpciones.add(SizedBox(height: 8));
    listaOpciones.add(elementos(
        context,
        Text('Aplicaciones', style: TextStyle(fontSize: 40.0)),
        100,
        'apigrupos',
        ''));

    listaOpciones.add(SizedBox(
      height: 70,
    ));

    return listaOpciones;
  }

  encabezadoApp(BuildContext context, String titulo) {
    return Container(
      height: 240,
      padding: EdgeInsets.only(left: 5, top: 5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                                              fontSize: 28,
                                              color: Colors.white)),
                                    ),
                                  ),

                                  //shape: CircleBorder(),
                                  elevation: 14.0,
                                  actionsPadding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
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
                                                            color: Colors
                                                                .white))))))
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    botonRojoHeader(context, true),
                  ]),
              Container(
                // height: 200,
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    'Vitalfon',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 45),
                  ),
                ),
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
                    height: 90,
                    width: 90,
                  )
                ],
              ),
            ]),
            encabezadoIcon(context),
          ]),

      decoration: new BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Theme.of(context).primaryColor,

            Colors.white,
            Theme.of(context).scaffoldBackgroundColor,
            //Color.fromRGBO(55, 57, 84, 1.0)
          ],
              stops: [
            0.2,
            0.4,
            0.9
          ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter)),
      // color: Color.fromRGBO(55, 57, 84, 1.0),
      //  ),
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
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white)),
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
                width: 100,
              ),
              GestureDetector(
                  onTap: () {
                    eliminarApiMP(context, 'MPB' + api.packageName);
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
            width: 20,
          ),
          Text(
            api.appName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ],
      ),
    ),
  );
}

Future<dynamic> eliminarApiMP(BuildContext context, String tipo) {
  final String titulo = tipo.substring(3);
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text('¿Desea eliminar $titulo  del menú principal?',
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
