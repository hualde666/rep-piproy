import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/botonrojo_app.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [BotonRojoHeader(context)], // Hora(context)],
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
