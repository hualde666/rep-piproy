import 'package:flutter/material.dart';

Widget botonBackHeader(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      // child: Image(
      //     image: AssetImage('assets/boton_verde.png'), fit: BoxFit.contain),
      child: Column(
        children: [
          Icon(Icons.arrow_back_outlined, size: 60, color: Colors.white),
          Text(
            '  ATRAS',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 3, 49, 27),
              blurRadius: 1,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.green[900],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), bottomLeft: Radius.circular(35)),
          border: Border.all(color: Colors.white12)),
      height: 85,
      width: 100,
      //color: Colors.red),
    ),
  );
}
