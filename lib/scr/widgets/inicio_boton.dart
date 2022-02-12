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
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black38,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 1,
                  spreadRadius: 0.5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              border: Border.all(
                  color: Theme.of(context).primaryColor, width: 0.5)),
          margin: EdgeInsets.only(right: 5),
          child: Center(
            child: Text(
              'INICIO',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            ),
          )),
    );
  }
}
