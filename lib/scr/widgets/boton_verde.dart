import 'package:flutter/material.dart';

Widget BotonBackHeader(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      child:
          Image(image: AssetImage('assets/boton_verde.png'), fit: BoxFit.cover),
      height: 100,
      width: 100,
      //color: Colors.red),
    ),
  );
}
