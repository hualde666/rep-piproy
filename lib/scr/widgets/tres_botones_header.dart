import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/boton_home.dart';
import 'package:piproy/scr/widgets/boton_verde.dart';
import 'package:piproy/scr/widgets/boton_rojo.dart';

Widget tresBotonesHeader(BuildContext context, bool rojo) {
  return Container(
    //color: Colors.blue,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        botonRojoHeader(context, rojo),
        SizedBox(width: 10),
        Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            botonHomeHeader(context),
            SizedBox(
              height: 15,
            ),
            Text(
              'Vitalfon',
              style: TextStyle(color: Colors.white, fontSize: 45),
            )
          ],
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white30)),
                margin: EdgeInsets.only(right: 5),
                child: Center(
                  child: Text(
                    'ayuda',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
            SizedBox(
              height: 5,
            ),
            botonBackHeader(context)
          ],
        )
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
