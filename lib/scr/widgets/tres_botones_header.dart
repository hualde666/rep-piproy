import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/boton_home.dart';
import 'package:piproy/scr/widgets/boton_verde.dart';
import 'package:piproy/scr/widgets/boton_rojo.dart';

Widget tresBotonesHeader(BuildContext context) {
  return Container(
    //color: Colors.blue,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        botonBackHeader(context),
        botonRojoHeader(context),
        botonHomeHeader(context),
      ],
    ),
  );
}
