import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/boton_verde.dart';
import 'package:piproy/scr/widgets/boton_rojo.dart';

Widget tresBotonesHeader(BuildContext context, bool rojo, String pagina) {
  return Container(
    //color: Colors.blue,
    padding: EdgeInsets.only(
      left: 5,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
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
          ),
          SizedBox(
            height: 3,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'ayuda', arguments: pagina);
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
                    'AYUDA',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
          ),
        ]),
        //
        SizedBox(height: 5),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                botonRojoHeader(context, rojo),
                // botonHomeHeader(context),
                // SizedBox(
                //   height: 15,
                // ),
                Text(
                  'Vitalfon',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 40),
                ),
                botonBackHeader(context)
              ],
            )),
      ], // Ho
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      // children: [
      //   botonBackHeader(context),
      //   botonRojoHeader(context),
      //   botonHomeHeader(context),
      // ],
    ),
  );
}
