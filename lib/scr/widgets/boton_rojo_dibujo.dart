import 'package:flutter/material.dart';

import 'package:piproy/scr/providers/usuario_pref.dart';
import 'package:provider/provider.dart';

class BotonRojo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    double ancho = 100;
    double alto = 85;
    double font = 20;
    double icon = 60;
    if (width <= 320) {
      ancho = 80;
      alto = 65;
      font = 15;
      icon = 40;
    }
    final pref = Provider.of<Preferencias>(context);
    return Container(
      child: Column(
        children: [
          Icon(Icons.call, //Icons.health_and_safety_outlined,
              size: icon,
              color: pref.paleta == '4'
                  ? Color.fromARGB(255, 255, 230, 7)
                  : Colors.white),
          Text(
            'S O S',
            style: TextStyle(
                fontSize: font,
                fontWeight: FontWeight.bold,
                color: pref.paleta == '4'
                    ? Color.fromARGB(255, 246, 242, 4)
                    : Colors.white),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: pref.paleta == '4' ? Colors.black : Colors.red[900],
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
              spreadRadius: 0.5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
          border:
              Border.all(color: Theme.of(context).primaryColor, width: 0.5)),
      height: alto,
      width: ancho,
    );
  }
}
