import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';

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
  ScrollController _scrollController = ScrollController();

  Application api;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          //  _topScroll = true;
        });
      });
  }

  void scrollToTop() {
    _scrollController.jumpTo(0.0);
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
          future: apiProvider.cargarCategorias(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return detalle(context);
            }
          }),

      //  CustomScrollView(
      //   controller: _scrollController,
      //   slivers: _detalle(context),

      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
          Text('ApiGruposNuevo',
              style: TextStyle(color: Colors.white, fontSize: 35.0)),
          100,
          'apigrupos',
          ''),
    ];
    if (listaMenu.isNotEmpty) {
      for (var i = 0; i < listaMenu.length; i++) {
        final String titulo = listaMenu[i];
        listaOpciones.add(elementos(
            context,
            Text(titulo, style: TextStyle(color: Colors.white, fontSize: 35.0)),
            100,
            titulo,
            'MPC'));
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

    // <Widget>[
    //   SliverList(
    //     delegate: SliverChildListDelegate([
    //       SizedBox(height: 5.0),
    //       elementos(context, PilaTimpoClima(), 200, ''),
    //       elementos(
    //           context,
    //           Text('Contactos',
    //               style: TextStyle(color: Colors.white, fontSize: 35.0)),
    //           100,
    //           'contactos'),

    //       elementos(
    //           context,
    //           Text('ApiGruposNuevo',
    //               style: TextStyle(color: Colors.white, fontSize: 35.0)),
    //           100,
    //           'apigrupos'),
    //      SizedBox(
    //         height: 100,
    //       )
    //     ]),
    //   )
    // ];
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

  obtener(String nombre) async {
    // AplicacionesProvider aplicacionesProvider = new AplicacionesProvider();
    //  List listaApp = await aplicacionesProvider.listaApp;
    // Application app;
    // int i = 0;
    // int items = listaApp.length;
    // if (items >= 0) {
    //   while (i <= items - 1) {
    //     if (listaApp[i].appName == nombre) {
    //       app = listaApp[i];
    //       return app;
    //     } else {
    //       i++;
    //     }
    //   }

    // return listaApp;
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
