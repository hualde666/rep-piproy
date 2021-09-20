import 'package:flutter/material.dart';

Widget botonRojoBack(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Center(
      child: Container(
        child: Image(
            image: AssetImage('assets/boton_rojo.png'), fit: BoxFit.cover),
        height: 100,
        width: 100,
      ),
    ),
  );
}
