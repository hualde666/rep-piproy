import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/ayuda_boton.dart';

import 'package:piproy/scr/widgets/boton_verde.dart';
import 'package:piproy/scr/widgets/boton_rojo.dart';
import 'package:piproy/scr/widgets/inicio_boton.dart';
import 'package:piproy/scr/widgets/reloj.dart';

Widget tresBotonesHeader(BuildContext context, bool rojo, String pagina) {
  return Container(
    //color: Colors.blue,
    padding: EdgeInsets.only(
      left: 5,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          InicioBoton(pagina: pagina),
          SizedBox(
            height: 5,
          ),
          botonRojoHeader(context, rojo)
        ]),
        //
        Reloj(),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AyudaBoton(pagina: pagina),
            SizedBox(
              height: 5,
            ),
            botonBackHeader(context)
          ],
        )
      ], // Ho
    ),
  );
}
