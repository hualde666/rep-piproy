import 'package:flutter/material.dart';

import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:piproy/scr/providers/usuario_pref.dart';
import 'package:provider/provider.dart';

Widget botonRojoHeader(BuildContext context, bool activo) {
  final celProvider = Provider.of<EstadoProvider>(context);
  final activoDatos = celProvider.conexionDatos;
  // bool activoDatos = celProvider.conexionDatos;
  final pref = Provider.of<Preferencias>(context);
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
                      size: 60,
                      color: pref.paleta == '4'
                          ? Color.fromARGB(255, 255, 230, 7)
                          : Colors.white),
                  Text(
                    'S O S',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: pref.paleta == '4'
                            ? Color.fromARGB(255, 246, 242, 4)
                            : Colors.white),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: pref.paleta == '4' ? Colors.black : Colors.red[900],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 1,
                      spreadRadius: 0.5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 0.5)),
              height: 85,
              width: 100,
            )
          : Container(
              height: 100,
              width: 100,
            ));
}
