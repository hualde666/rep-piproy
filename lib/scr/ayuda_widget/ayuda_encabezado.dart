import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/usuario_pref.dart';
import '../widgets/boton_ayuda_dibujo.dart';
import '../widgets/boton_inicio_dibujo.dart';
import '../widgets/boton_rojo_dibujo.dart';

List<Widget> ayudaEncabezado(BuildContext context, String titulo) {
  final pref = Provider.of<Preferencias>(context);
  List<Widget> listaAyudaEncabezado = [
    SizedBox(
      height: 10,
    ),
    Container(
      child: Center(
          child: Text(titulo,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30, color: Theme.of(context).primaryColor))),
    ),
    SizedBox(
      height: 10,
    ),
    Divider(
      height: 10,
      color: Theme.of(context).primaryColor,
    ),
    //**********************************INICIO******** */
    Container(
      margin: EdgeInsets.only(left: 5),
      child: Column(
        children: [
          inicioBoton(context),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 70,
            // width: 250,
            child: Center(
              child: Text(
                'Boton de Inicio.',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 5, right: 6, top: 3),
            child: Text(
              'Regresa a la pantalla principal',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    ),
    Divider(
      height: 10,
      color: Theme.of(context).primaryColor,
    ),
    SizedBox(
      height: 10,
    ),

    //**********************************AYUDA******** */
    Container(
      // height: 150,
      margin: EdgeInsets.only(left: 5),
      child: Column(
        children: [
          BotonAyudaDibujo(),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 70,
            // width: 250,
            child: Center(
              child: Text(
                'Ayuda.',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 6, right: 6, top: 3),
            child: Text(
              'Explica los elementos de la página actual. ',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    ),
    SizedBox(
      height: 10,
    ),
    Divider(
      height: 10,
      color: Theme.of(context).primaryColor,
    ),
    SizedBox(
      height: 10,
    ),
    //**********************************BOTON ROJO******** */
    Container(
      //height: 150,
      margin: EdgeInsets.only(left: 5),
      child: Column(
        children: [
          BotonRojo(),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 70,
            // width: 250,
            child: Center(
              child: Text(
                'Boton de Emergencia:',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 6, right: 5, top: 5),
            child: Column(
              children: [
                Text(
                  'Inicia el proceso de envio de menaje de emergencia', // (Deberá haber seleccionado sus contactos de emergencia previamente y tener activo el GPS para que funcione el envio de su geolocalización).',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 25, color: Theme.of(context).primaryColor),
                ),
                // Text(
                //   'Se enviará un mensaje genérico a sus contactos advirtiendo que se encuentra en una situación de emergencia y necesita ayuda. También se enviará su geolocalización.',
                //   textAlign: TextAlign.justify,
                //   style: TextStyle(
                //       fontSize: 25, color: Theme.of(context).primaryColor),
                // ),
                // Text(
                //   'El 112 no puede recibir este tipo de mensaje.',
                //   textAlign: TextAlign.justify,
                //   style: TextStyle(
                //       fontSize: 25, color: Theme.of(context).primaryColor),
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
    SizedBox(
      height: 10,
    ),
    Divider(
      height: 10,
      color: Theme.of(context).primaryColor,
    ),
    SizedBox(
      height: 10,
    ),
    //******************* BOTON VERDE */
    Container(
      //height: 150,
      margin: EdgeInsets.only(left: 5),
      child: Column(
        children: [
          Container(
            height: 85,
            width: 100,

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
                    topLeft: Radius.circular(35),
                    bottomLeft: Radius.circular(35)),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 0.5)),

            //color: Colors.red),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 70,
            // width: 250,
            child: Center(
              child: Text(
                'Boton de Retorno:',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 6, right: 5, top: 5),
            child: Text(
              'Retorna a la pantalla anterior',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    ),

    SizedBox(
      height: 10,
    ),
    Divider(
      height: 10,
      color: Theme.of(context).primaryColor,
    ),
    SizedBox(
      height: 10,
    ),
  ];
  return listaAyudaEncabezado;
}
