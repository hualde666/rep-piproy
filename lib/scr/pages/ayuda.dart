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
import 'package:piproy/scr/widgets/header_app.dart';

class Ayuda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String pagina = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Ayuda', Text(''), 0.0, true),
        // backgroundColor: Colors.white,
        body: PaginaAyuda(pagina: pagina),
      ),
    );
  }
}

class PaginaAyuda extends StatelessWidget {
  const PaginaAyuda({
    Key key,
    @required this.pagina,
  }) : super(key: key);

  final String pagina;

  @override
  Widget build(BuildContext context) {
    return contenido(pagina);
  }

  Widget contenido(String pagina) {
    Widget ayuda = Center(
        child: Container(
            child: Text(
      pagina,
      style: TextStyle(color: Colors.red),
    )));
    switch (pagina) {
      case 'contactosPage':
        ayuda = AyudaPaginaContactos();
        break;
      case 'home':
        ayuda = AyudaHome();
        break;
      case 'configurar':
        ayuda = AyudaConfigurarPage();
        break;
      case 'emergiContactos':
        ayuda = AyudaContactosEmergencia();
        break;
      case 'selecContactos':
        ayuda = AyudaSeleccionContactos();
        break;
      case 'mostrarContacto':
        ayuda = AyudaMostrarContacto();
        break;
      case 'editarContacto':
        ayuda = AyudaEditarContacto();
        break;
      case 'emergiMensaje':
        ayuda = AyudaMensajeEmergencia();
        break;
      case 'botonRojo':
        ayuda = AyudaBotonRojo();
        break;
    }
    return ayuda;
  }
}
