import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/usuario_pref.dart';
import 'package:provider/provider.dart';

Widget botonBackHeader(BuildContext context) {
  final pref = Provider.of<Preferencias>(context);
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      // child: Image(
      //     image: AssetImage('assets/boton_verde.png'), fit: BoxFit.contain),
      child: Column(
        children: [
          Icon(Icons.arrow_back_outlined,
              size: 60,
              color: pref.paleta == '4'
                  ? Theme.of(context).primaryColor
                  : Colors.white),
          Text(
            '  ATRAS',
            style: TextStyle(
                fontSize: 20,
                color: pref.paleta == '4'
                    ? Theme.of(context).primaryColor
                    : Colors.white),
          )
        ],
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
              spreadRadius: 0.5,
              offset: Offset(0, 3),
            ),
          ],
          color: pref.paleta == '4'
              ? Theme.of(context).backgroundColor
              : Colors.green[900],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), bottomLeft: Radius.circular(35)),
          border:
              Border.all(color: Theme.of(context).primaryColor, width: 0.5)),
      height: 85,
      width: 100,
      //color: Colors.red),
    ),
  );
}
