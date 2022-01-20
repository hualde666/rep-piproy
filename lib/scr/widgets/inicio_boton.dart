import 'package:flutter/material.dart';

class InicioBoton extends StatelessWidget {
  final String pagina = '';
  InicioBoton({pagina});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (pagina != 'home') {
          Navigator.of(context).popUntil(ModalRoute.withName('home'));
        }
      },
      child: Container(
          width: 90,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.white30)),
          margin: EdgeInsets.only(right: 5),
          child: Center(
            child: Text(
              'INICIO',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )),
    );
  }
}
