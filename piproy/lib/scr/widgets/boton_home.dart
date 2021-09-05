import 'package:flutter/material.dart';

Widget BotonHomeHeader(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).popUntil(ModalRoute.withName('home')),
    child: Container(
      child:
          Image(image: AssetImage('assets/boton_home.png'), fit: BoxFit.cover),
      height: 100,
      width: 100,
      //color: Colors.red),
    ),
  );
}
