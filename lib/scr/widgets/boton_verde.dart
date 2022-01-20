import 'package:flutter/material.dart';

Widget botonBackHeader(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      // child: Center(
      //     child: Text('RETORNO',
      //         style: TextStyle(color: Colors.white, fontSize: 25))),
      child: Image(
          image: AssetImage('assets/boton_verde.png'), fit: BoxFit.contain),
      // decoration: BoxDecoration(
      //   color: Colors.green[400],
      //   borderRadius: BorderRadius.circular(15.0),
      // ),
      height: 90,
      width: 90,
      //color: Colors.red),
    ),
  );
}
