import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/boton_ayuda_dibujo.dart';
import 'package:piproy/scr/widgets/boton_rojo_dibujo.dart';
import 'package:piproy/scr/widgets/boton_salida.dart';
import 'package:piproy/scr/widgets/encabezado_icon.dart';

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
      //**********************************SALIDA******** */
      Container(
        margin: EdgeInsets.only(left: 5),
        child: Column(
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
      SizedBox(
        height: 10,
      ),
      //********************************** CONFIGURACION ******** */
      Container(
        // height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
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
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Permite: selección de contactos de emergencia, el mensaje de emergencia, color de Vitalfon y hablitar o deshablita elmentos  en pantalla principal',
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
      //********************************** MENU HORIZONTAL******** */
      SizedBox(
        height: 10,
      ),

      Container(
        // height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 130),
                child: widgetHorizontal(context, Icons.battery_std, 'bateria')),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Indicador del nivel de carga de la batería. En amarillo carga menor al 50% y rojo carga menor del 20%',
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 130),
              child: widgetHorizontal(
                context,
                Icons.wifi,
                'wifi',
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Indica si el celular tiene activa la señal Wifi. Rojo si no lo está.',
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 130),
              child: widgetHorizontal(
                context,
                Icons.filter_alt,
                'linterna',
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Prende o apaga la linterna. En amarillo está prendida.',
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 130),
                child: widgetHorizontal(context, Icons.call, 'telefono')),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Permite realizar llamadas.',
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 130),
              child: widgetHorizontal(
                context,
                Icons.signal_cellular_alt_rounded,
                'linea',
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Indica si tiene linea telefónica. En rojo no la tiene.',
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 130),
              child: widgetHorizontal(
                context,
                Icons.gps_fixed_rounded,
                'gps',
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Indica si GPS está activo. En rojo no está activo.',
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 130),
              child: widgetHorizontal(
                context,
                Icons.chat,
                'mensaje',
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Permite mandar mensajes de texto SMS.',
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
              margin: EdgeInsets.symmetric(horizontal: 130),
              //color: Colors.green,
              child: widgetHorizontal(
                context,
                Icons.access_alarm,
                'alarma',
              ),
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Configuración de alarmas: despertador, recordatorios y otras.',
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
