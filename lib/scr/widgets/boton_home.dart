import 'package:flutter/material.dart';

Widget botonHomeHeader(BuildContext context) {
  String pagina = '';
  return GestureDetector(
    onTap: () {
      if (pagina == 'home') {
      } else {
        Navigator.of(context).popUntil(ModalRoute.withName('home'));
      }
    },
    child: Container(
      // child: Center(
      //     child: Text('INICIO',
      //         style: TextStyle(color: Colors.white, fontSize: 25))),

      // decoration: BoxDecoration(
      //   color: Colors.amber[400],
      //   borderRadius: BorderRadius.circular(15.0),
      // ),
      //  border:
      //   Border.all( width: 3.0)),
      child:
          Image(image: AssetImage('assets/boton_home.png'), fit: BoxFit.cover),
      height: 60,
      width: 60,
      //color: Colors.red),
    ),
  );
}
