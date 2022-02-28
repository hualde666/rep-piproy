import 'package:flutter/material.dart';

import 'package:piproy/scr/ayuda_widget/ayuda_home.dart';

import 'package:piproy/scr/widgets/boton_ayuda_dibujo.dart';
import 'package:piproy/scr/widgets/boton_rojo.dart';
import 'package:piproy/scr/widgets/boton_verde.dart';

import 'package:piproy/scr/widgets/inicio_boton.dart';

import '../ayuda_widget/ayuda_api_seleccion.dart';
import '../ayuda_widget/ayuda_apis_en_gropo.dart';
import '../ayuda_widget/ayuda_apis_grupos.dart';
import '../ayuda_widget/ayuda_contacs_en_grupo.dart';
import '../ayuda_widget/ayuda_contacs_grupos.dart';
import '../ayuda_widget/ayuda_seleccion_contactos.dart';
import '../widgets/reloj.dart';

class Ayuda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String pagina = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: headerAyuda(context, 'Ayuda'),
        // backgroundColor: Colors.white,
        body: contenido(pagina),
      ),
    );
  }

  Widget contenido(String pagina) {
    Widget ayuda = Center(
        child: Container(
            child: Text(
      pagina,
      style: TextStyle(color: Colors.red),
    )));
    switch (pagina) {
      case 'home':
        ayuda = AyudaHome();
        break;
      case 'ApiGrupos':
        ayuda = AyudaApisGrupos();
        break;
      case 'ApiPorGrupos':
        ayuda = AyudaApisPorGrupos();
        break;
      case 'ContactoGrupos':
        ayuda = AyudaContacsGrupos();
        break;
      case 'ContactosPorGrupo':
        ayuda = AyudaContactosPorGrupos();
        break;
      case 'ContactoSeleccion':
        ayuda = AyudaContactosSeleccion();
        break;
      case 'ApisSeleccion':
        ayuda = AyudaApisSeleccion();
        break;
    }
    return ayuda;
  }
}

Widget headerAyuda(BuildContext context, String pagina) {
  return PreferredSize(
    preferredSize: Size.fromHeight(185.0),
    child: Container(
      width: double.infinity,
      child: Column(
        children: [
          tresBotonesHeader(context, pagina),
          SizedBox(
            height: 1,
          ),
          Container(
            child: Text('Ayuda',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 25)),
          ),
        ],
      ),
    ),
  );
}

Widget tresBotonesHeader(BuildContext context, String pagina) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          InicioBoton(pagina: pagina),
          SizedBox(
            height: 10,
          ),
          botonRojoHeader(context, true)
        ]),
        //
        Reloj(),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // AyudaBoton(pagina: pagina),
            BotonAyudaDibujo(),
            SizedBox(
              height: 10,
            ),

            botonBackHeader(context)
          ],
        )
      ], // Ho
    ),
  );
}
