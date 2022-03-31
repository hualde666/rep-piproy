import 'package:flutter/material.dart';
import 'package:piproy/scr/pages/home2_page.dart';
import 'package:piproy/scr/providers/usuario_pref.dart';
import 'package:provider/provider.dart';

Widget botonBackHeader(BuildContext context, String pagina) {
  final pref = Provider.of<Preferencias>(context);
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
  return GestureDetector(
    onTap: () {
      if (pagina == 'Configurar') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home2Page()));
      } else {
        Navigator.pop(context);
      }
    },
    child: Container(
      // child: Image(
      //     image: AssetImage('assets/boton_verde.png'), fit: BoxFit.contain),
      child: Column(
        children: [
          Icon(Icons.arrow_back_outlined,
              size: icon,
              color: pref.paleta == '4'
                  ? Theme.of(context).primaryColor
                  : Colors.white),
          Text(
            '  ATRAS',
            style: TextStyle(
                fontSize: font,
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
      height: alto,
      width: ancho,
      //color: Colors.red),
    ),
  );
}
