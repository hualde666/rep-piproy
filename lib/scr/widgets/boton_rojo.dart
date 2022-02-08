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
              child: Column(
                children: [
                  Icon(Icons.health_and_safety_outlined,
                      size: 60, color: Colors.white),
                  Text(
                    'S O S',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.red[700],
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 75, 8, 3),
                      blurRadius: 1,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                  border: Border.all(color: Colors.white12)),
              // child: Image(
              //     image: AssetImage('assets/boton_rojo.png'),
              //     fit: BoxFit.contain),
              height: 85,
              width: 100,
            )
          : Container(
              height: 100,
              width: 100,
            ));
}
