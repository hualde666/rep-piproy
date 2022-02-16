import 'package:flutter/material.dart';
import 'package:piproy/scr/pages/botonrojo_page.dart';

import 'package:piproy/scr/providers/estado_celular.dart';

import 'package:piproy/scr/widgets/boton_rojo_dibujo.dart';
import 'package:provider/provider.dart';

Widget botonRojoHeader(BuildContext context, bool activo) {
  final celProvider = Provider.of<EstadoProvider>(context);
  final activoDatos = celProvider.conexionDatos;

  return GestureDetector(
      onTap: () {
        if (activoDatos) {
          if (activo) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BotonRojoPage()));
          }
        }
      },
      child: activoDatos
          ? BotonRojo()
          : Container(
              height: 100,
              width: 100,
            ));
}
