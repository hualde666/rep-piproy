import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/boton_exit.dart';
import 'package:piproy/scr/widgets/boton_rojo.dart';
import 'package:piproy/scr/widgets/encabezado_icon.dart';
import 'package:piproy/scr/widgets/hora.dart';

encabezadoApp2(BuildContext context, String titulo) {
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
              BotonExit(context),
              BotonRojoHeader(context),
              Container(
                height: 100,
                width: 100,
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
