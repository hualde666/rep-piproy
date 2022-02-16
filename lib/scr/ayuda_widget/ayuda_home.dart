import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/boton_rojo_dibujo.dart';
import 'package:piproy/scr/widgets/boton_salida.dart';

class AyudaHome extends StatelessWidget {
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
            child: Text('Pantalla Inicial',
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
      Container(
        height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              children: [
                BotonSalida(),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 70,
                  // width: 250,
                  child: Center(
                    child: Text(
                      'Boton de Salida:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 25, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 5, right: 6, top: 3),
              child: Text(
                'Cierra la aplicación y regresa al menu original del celular.',
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
      Container(
        //height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
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
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 5, top: 5),
              child: Column(
                children: [
                  Text(
                    '  Inicia el proceso de envio de menaje de emergencia (Deberá haber seleccionado sus contactos de emergencia previamente y tener activo el GPS para que funcione el envio de su geolocalización).',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    '  Se enviará un mensaje genérico a sus contactos advirtiendo que se encuentra en una situación de emergencia y necesita ayuda. También se enviará su geolocalización.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    '   El 112 no puede recibir este tipo de mensaje.',
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
      Container(
        // height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 50,
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
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                            width: 0.5, color: Theme.of(context).primaryColor)),
                    margin: EdgeInsets.only(right: 5),
                    child: Center(
                      child: Icon(
                        Icons.build,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      //  Text(
                      //   'CONFIGURAR',
                      //   style: TextStyle(fontSize: 18, color: Colors.white),
                      // ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 70,
                  // width: 250,
                  child: Center(
                    child: Text(
                      'Configuración:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 25, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Permite: seleccioón decontactos de emergencia, el mensaje de emergencia, color de Vitalfon y hablitar o deshablita elmentos  en pantalla principal',
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
    ];
    return lista;
  }
}
