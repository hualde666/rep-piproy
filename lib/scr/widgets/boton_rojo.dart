import 'package:flutter/material.dart';

Widget botonRojoHeader(BuildContext context, bool activo) {
  return GestureDetector(
    onTap: () {
      if (activo) {
        Navigator.pushNamed(context, 'botonRojo');
      }
    },
    child: Container(
      // child: Center(
      //     child: Text('EMERGENCIA',
      //         style: TextStyle(color: Colors.white, fontSize: 25))),
      child:
          Image(image: AssetImage('assets/boton_rojo.png'), fit: BoxFit.cover),
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
    ),
  );
}
