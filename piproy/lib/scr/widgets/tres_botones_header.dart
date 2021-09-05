import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/boton_home.dart';
import 'package:piproy/scr/widgets/botonback_app.dart';
import 'package:piproy/scr/widgets/botonrojo_app.dart';

Widget TresBotonesHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      BotonBackHeader(context),
      BotonRojoHeader(context),
      BotonHomeHeader(context)
    ],
  );
}
