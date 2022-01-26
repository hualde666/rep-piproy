import 'package:flutter/material.dart';

import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:provider/provider.dart';

Widget botonRojoHeader(BuildContext context, bool activo) {
  final celProvider = Provider.of<EstadoProvider>(context);
  final activoDatos = celProvider.conexionDatos;
  // bool activoDatos = celProvider.conexionDatos;
  return GestureDetector(
      onTap: () {
        if (activoDatos) {
          if (activo) {
            Navigator.pushNamed(context, 'botonRojo');
          }
        }
      },
      child: activoDatos
          ? Container(
              child: Image(
                  image: AssetImage('assets/boton_rojo.png'),
                  fit: BoxFit.contain),
              height: 90,
              width: 90,
            )
          : Container(
              height: 90,
              width: 90,
            ));
}
