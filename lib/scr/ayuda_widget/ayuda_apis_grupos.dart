import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/boton_ayuda_dibujo.dart';
import 'package:piproy/scr/widgets/boton_rojo_dibujo.dart';

import '../widgets/boton_inicio_dibujo.dart';

class AyudaApisGrupos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _listaAyudaHome(context);
  }

  Widget _listaAyudaHome(BuildContext context) {
    List<Widget> _listaAyuda = _crearListaAyuda(context);

    return ListView.builder(
        itemCount: _listaAyuda.length,
        itemBuilder: (contest, i) {
          return _listaAyuda[i];
        });
  }

  List<Widget> _crearListaAyuda(BuildContext context) {
    List<Widget> lista = [
      SizedBox(
        height: 10,
      ),
      Container(
        child: Center(
            child: Text('Grupos Aplicaiones',
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
      //**********************************SALIDA******** */
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
                  'Boton de Inicio',
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
                  'Ayuda:',
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
                'Explica la función de cada elemento en la aplicación',
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
                    'Inicia el proceso de envio de menaje de emergencia (Deberá haber seleccionado sus contactos de emergencia previamente y tener activo el GPS para que funcione el envio de su geolocalización).',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    'Se enviará un mensaje genérico a sus contactos advirtiendo que se encuentra en una situación de emergencia y necesita ayuda. También se enviará su geolocalización.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    'El 112 no puede recibir este tipo de mensaje.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).primaryColor),
                  ),
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

      Container(
        // height: 150,

        margin: EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color:
                      /** es un contacto o grupo de contacto */
                      Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  )),
              child: Center(
                child: Text(
                  'Todas',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Muestra todas las aplicaciones del celular',
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

      Container(
        // height: 150,

        margin: EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Icon(
                Icons.close,
                size: 50,
                color: Colors.red,
              ),
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Permite eliminar un grupo',
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
    ];
    return lista;
  }
}
