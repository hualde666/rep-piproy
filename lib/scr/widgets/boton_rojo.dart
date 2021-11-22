import 'package:flutter/material.dart';

Widget botonRojoHeader(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, 'botonRojo'),
    child: Container(
      // child: Center(
      //     child: Text('EMERGENCIA',
      //         style: TextStyle(color: Colors.white, fontSize: 25))),
      child:
          Image(image: AssetImage('assets/boton_rojo.png'), fit: BoxFit.cover),
      height: 100,
      width: 100,
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
