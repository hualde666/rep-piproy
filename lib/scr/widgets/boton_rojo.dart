import 'package:flutter/material.dart';

import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:provider/provider.dart';

Widget botonRojoHeader(BuildContext context, bool activo) {
  final celProvider = Provider.of<EstadoProvider>(context);

  bool activoDatos = celProvider.conexionDatos;
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
              // child: Center(
              //     child: Text('EMERGENCIA',
              //         style: TextStyle(color: Colors.white, fontSize: 25))),
              child: Image(
                  image: AssetImage('assets/boton_rojo.png'),
                  fit: BoxFit.cover),
              height: 90,
              width: 90,
              // decoration:
              //     BoxDecoration(borderRadius: BorderRadius.circular(100.0), boxShadow: [
              //   BoxShadow(
              //     color: Colors.white12.withOpacity(0.3),
              //     spreadRadius: 3,
              //     blurRadius: 2,
              //     offset: Offset(0.0, 1.0),
              //   ),
              // ]),
              //color: Colors.red),
            )
          : Container(
              height: 90,
              width: 90,
            ));
}
