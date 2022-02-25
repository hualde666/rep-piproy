import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_botonrojo.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_configurar.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_editar_contact.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_emer_contact.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_home.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_mensaje_emerg.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_mostrar_contact.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_selec_contact.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_pagina_contactos.dart';
import 'package:piproy/scr/widgets/boton_ayuda_dibujo.dart';
import 'package:piproy/scr/widgets/boton_rojo.dart';
import 'package:piproy/scr/widgets/boton_verde.dart';

import 'package:piproy/scr/widgets/inicio_boton.dart';

import '../ayuda_widget/ayuda_apis_grupos.dart';
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
      case 'ContactoGrupos':
        ayuda = AyudaPaginaContactos();
        break;
      case 'home':
        ayuda = AyudaHome();
        break;
      case 'ApiGrupos':
        ayuda = AyudaApisGrupos();
        break;
      case 'configurar':
        ayuda = AyudaConfigurarPage();
        break;
      case 'emergiContactos':
        ayuda = AyudaContactosEmergencia();
        break;
      case 'ContactoSeleccion':
        ayuda = AyudaSeleccionContactos();
        break;
      case 'mostrarContacto':
        ayuda = AyudaMostrarContacto();
        break;
      case 'editarContacto':
        ayuda = AyudaEditarContacto();
        break;
      case 'EmergenciaMensaje':
        ayuda = AyudaMensajeEmergencia();
        break;
      case 'botonRojo':
        ayuda = AyudaBotonRojo();
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
