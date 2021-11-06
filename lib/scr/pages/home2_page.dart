import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';

import 'package:piproy/scr/widgets/boton_exit.dart';

import 'package:piproy/scr/widgets/boton_rojo.dart';
import 'package:piproy/scr/widgets/elemntos.dart';

import 'package:piproy/scr/widgets/encabezado_icon.dart';
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

  Application api;
  @override
  void initState() {
    super.initState();

    //  _scrollController = ScrollController()
    //    ..addListener(() {
    setState(() {
      //  _topScroll = true;
    });
    //    });
  }

  void scrollToTop() {
    //_scrollController.jumpTo(0.0);
  }
  Future<List<String>> cargarMenu() async {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    if (cargando) {
      cargando = false;
      final List<ApiTipos> lista = await apiProvider.cargarCategorias();
      apiProvider.ordenarListasMenu(lista);
    }

    return apiProvider.listaMenu;
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(220.0),
        child: AppBar(flexibleSpace: encabezadoApp(context, 'Proyecto PI')),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
          future: cargarMenu(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return detalle(context);
              } else {
                return Container();
              }
            }
          }),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BotonFlotante(pagina: 'home'),
          ],
          // bottomNavigationBar: BottonBarNavegador(),
        ),
      ),
    ));
  }

  detalle(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    List<String> listaMenu = apiProvider.listaMenu;
    List<Widget> listaOpciones = [
      SizedBox(height: 5.0),
      elementos(context, PilaTimpoClima(), 200, '', ''),
      elementos(
          context,
          Text('Contactos',
              style: TextStyle(color: Colors.white, fontSize: 35.0)),
          100,
          'contactos',
          ''),
      elementos(
          context,
          Text('Aplicaciones',
              style: TextStyle(color: Colors.white, fontSize: 35.0)),
          100,
          'apigrupos',
          ''),
    ];
    if (listaMenu.isNotEmpty) {
      for (var i = 0; i < listaMenu.length; i++) {
        final String titulo = listaMenu[i].substring(3);
        if (listaMenu[i].contains('MPC')) {
          listaOpciones.add(elementos(
              context,
              Text(titulo,
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              100,
              titulo,
              listaMenu[i]));
        } else {
          final apiProvider = Provider.of<AplicacionesProvider>(context);
          final Application api = apiProvider.categoryApi['Todas']
              .firstWhere((eApi) => eApi.appName == listaMenu[i].substring(3));
          listaOpciones.add(elementoApi2(context, api));
        }
      }
    }
    listaOpciones.add(SizedBox(
      height: 70,
    ));

    return ListView.builder(
        itemCount: listaOpciones.length,
        itemBuilder: (context, i) {
          return listaOpciones[i];
        });
  }

  encabezadoApp(BuildContext context, String titulo) {
    return AppBar(
      //elevation: 1.0,
      automaticallyImplyLeading: true,
      flexibleSpace: Container(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                botonExit(context),
                botonRojoHeader(context),
                GestureDetector(
                  onTap: () {
                    scrollToTop();
                    //            mScrollView.scrollBy(10, 10);
                  },
                  child: Container(
                    child: Image(
                        image: AssetImage('assets/boton_home.png'),
                        fit: BoxFit.cover),
                    height: 100,
                    width: 100,
                    //color: Colors.red),
                  ),
                )
              ], // Hora(context)],
            ),
            Divider(
              height: 2,
            ),
            encabezadoIcon(context),
          ],
        ),
        color: Color.fromRGBO(55, 57, 84, 1.0),
      ),
    );
  }
}

class BotonRojoHeader {}

Widget botonInicio() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      child:
          Image(image: AssetImage('assets/boton_home.png'), fit: BoxFit.cover),
      height: 100,
      width: 100,
      //color: Colors.red),
    ),
  );
}

Widget elementoApi2(BuildContext context, Application api) {
  return GestureDetector(
    onTap: () {
      if (api.appName != "") {
        api.openApp();
      }
    },
    onLongPress: () {
      // eliminar del Menu principal
      eliminarApi(context, 'MPA' + api.appName);
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 3.0),
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
          Image.memory(
            (api as ApplicationWithIcon).icon,
            width: 100,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            api.appName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Future<dynamic> eliminarApi(BuildContext context, String tipo) {
  final String titulo = tipo.substring(3);
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text('¿Desea eliminar $titulo  del menú ?'),
      // shape: CircleBorder(),
      elevation: 14.0,
      actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
      actions: [
        TextButton(
            onPressed: () {
              /// elina api de pantalla
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarTipoMPC(tipo);

              DbTiposAplicaciones.db
                  .deleteApi(tipo.substring(0, 3), tipo.substring(3));

              //elimina api de BD

              Navigator.pop(context);
            },
            child: Text('Si', style: TextStyle(fontSize: 20.0))),
        TextButton(
            autofocus: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No', style: TextStyle(fontSize: 20.0))),
      ],
    ),
  );
}
