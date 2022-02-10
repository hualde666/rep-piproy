import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/icon_conteiner.dart';
import 'package:provider/provider.dart';

Widget encabezadoIcon(BuildContext context) {
  //final bool isOn = false;
  final pref = Provider.of<Preferencias>(context);
  List<Widget> _listaWidget = [];

  if (pref.iBateria) {
    _listaWidget.add(widgetHorizontal(context, Icons.battery_std, 'bateria'));
  }

  if (pref.iWifi) {
    _listaWidget.add(widgetHorizontal(
      context,
      Icons.wifi,
      'wifi',
    ));
  }
  if (pref.iLinterna) {
    _listaWidget.add(widgetHorizontal(
      context,
      Icons.filter_alt,
      'linterna',
    ));
  }

  if (pref.iTelefono) {
    _listaWidget.add(widgetHorizontal(context, Icons.call, 'telefono'));
  }

  if (pref.iLinea) {
    _listaWidget.add(widgetHorizontal(
      context,
      Icons.signal_cellular_alt_rounded,
      'linea',
    ));
  }

  if (pref.iGps) {
    _listaWidget.add(widgetHorizontal(
      context,
      Icons.gps_fixed_rounded,
      'gps',
    ));
  }

  if (pref.iMensaje) {
    _listaWidget.add(widgetHorizontal(
      context,
      Icons.chat,
      'mensaje',
    ));
  }

  if (pref.iReloj) {
    _listaWidget.add(widgetHorizontal(
      context,
      Icons.access_alarm,
      'alarma',
    ));
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    // color: Colors.green,
    height: 91,
    width: _listaWidget.length < 5
        ? 80.0 * _listaWidget.length
        : MediaQuery.of(context).size.width,
    child: Center(
      child: ListView.builder(
        physics: _listaWidget.length < 5
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _listaWidget.length,
        itemBuilder: (context, i) => _listaWidget[i],
      ),
    ),
  );
}

Widget widgetHorizontal(BuildContext context, IconData icon, String titulo) {
  return Row(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 75,
            child: conteinerIcon(
                context,
                Icon(
                  icon,
                  size: 40.0,
                ),
                titulo,
                null),
          ),
          Text(
            titulo,
            style: TextStyle(color: Colors.white60),
          )
        ],
      ),
      SizedBox(
        width: 10,
      ),
    ],
  );
}
